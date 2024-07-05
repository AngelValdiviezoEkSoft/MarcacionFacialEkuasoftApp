import 'dart:async';
import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:marcacion_facial_ekuasoft_app/domain/models/models.dart';

import 'package:marcacion_facial_ekuasoft_app/ui/ui.dart';

part 'map_event.dart';
part 'map_state.dart';

class MapBloc extends Bloc<MapEvent, MapState> {
  final LocationBloc locationBloc;
  GoogleMapController? mapController;
  GoogleMapController? _mapController;
  LatLng? mapCenter;

  StreamSubscription<LocationState>? locationStateSubscription;

  MapBloc({required this.locationBloc}) : super(const MapState()) {
    on<OnMapInitialzedEvent>(_onInitMap);
    on<OnStartFollowingUserEvent>(_onStartFollowingUser);
    on<OnStopFollowingUserEvent>((event, emit) => emit(state.copyWith(isFollowingUser: false)));
    on<UpdateUserPolylineEvent>(_onPolylineNewPoint);
    on<OnToggleUserRoute>((event, emit) => emit(state.copyWith(showMyRoute: !state.showMyRoute)));
    on<DisplayPolylinesEvent>((event, emit) => emit(state.copyWith(polylines: event.polylines, markers: event.markers)));

    locationStateSubscription = locationBloc.stream.listen((locationState) {
      if (locationState.lastKnownLocation != null) {
        add(UpdateUserPolylineEvent(locationState.myLocationHistory));
      }

      if (!state.isFollowingUser) return;
      if (locationState.lastKnownLocation == null) return;

      moveCamera(locationState.lastKnownLocation!);
    });
  }

  void _onInitMap(OnMapInitialzedEvent event, Emitter<MapState> emit) {
    _mapController = event.controller;
    _mapController!.setMapStyle(jsonEncode(uberMapTheme));
    mapController = _mapController;
    emit(state.copyWith(isMapInitialized: true));
  }

  void _onStartFollowingUser( OnStartFollowingUserEvent event, Emitter<MapState> emit) {
    emit(state.copyWith(isFollowingUser: true));

    if (locationBloc.state.lastKnownLocation == null) return;
    moveCamera(locationBloc.state.lastKnownLocation!);
  }

  void _onPolylineNewPoint( UpdateUserPolylineEvent event, Emitter<MapState> emit) {
    final myRoute = Polyline(
        polylineId: const PolylineId('myRoute'),
        color: Colors.black,
        width: 5,
        startCap: Cap.roundCap,
        endCap: Cap.roundCap,
        points: event.userLocations);

    final currentPolylines = Map<String, Polyline>.from(state.polylines);
    currentPolylines['myRoute'] = myRoute;

    emit(state.copyWith(polylines: currentPolylines));
  }

  Future drawRoutePolyline(RouteDestination destination) async {
    final myRoute = Polyline(
      polylineId: const PolylineId('route'),
      color: Colors.black,
      width: 5,
      points: destination.points,
      startCap: Cap.roundCap,
      endCap: Cap.roundCap,
    );

    double kms = destination.distance / 1000;
    kms = (kms * 100).floorToDouble();
    kms /= 100;

    //int tripDuration = (destination.duration / 60).floorToDouble().toInt();

    //final startMaker = await getStartCustomMarker(tripDuration, 'Mi ubicación');
    final endMaker = await getEndCustomMarker(kms.toInt(), destination.endPlace.text ?? '');

/*
    final startMarker = Marker(
      anchor: const Offset(0.1, 1),
      markerId: const MarkerId('start'),
      position: destination.points.first,
      icon: startMaker,
    );
    */

    final endMarker = Marker(
      markerId: const MarkerId('end'),
      position: destination.points.last,
      icon: endMaker,
    );

    final curretPolylines = Map<String, Polyline>.from(state.polylines);
    curretPolylines['route'] = myRoute;

    final currentMarkers = Map<String, Marker>.from(state.markers);
    //currentMarkers['start'] = startMarker;//este debería ir cuando sea para uber
    currentMarkers['end'] = endMarker;
    add(DisplayPolylinesEvent(curretPolylines, currentMarkers));
  }

  void moveCamera(LatLng newLocation) {
    final cameraUpdate = CameraUpdate.newLatLng(newLocation);
    _mapController?.animateCamera(cameraUpdate);
    mapController = _mapController;
  }
  /*

  void moveCameraString(String newLocation) {
    double latitud = double.parse(newLocation.split(',')[0].split(':')[1]);
    double longitud = double.parse(newLocation.split(',')[1].split(':')[1].split('}')[0]);

    LatLng convertNewLocation = LatLng(latitud,longitud);
    final cameraUpdate = CameraUpdate.newLatLng(convertNewLocation);
    _mapController?.animateCamera(cameraUpdate);
    mapController = _mapController;
  }
  */

  @override
  Future<void> close() {
    locationStateSubscription?.cancel();
    return super.close();
  }
}
