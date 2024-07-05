import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:marcacion_facial_ekuasoft_app/ui/bloc/bloc.dart';

class MapView extends StatelessWidget {

  final LatLng initialLocation;
  final LatLng llegadaLocation;
  //final Set<Polyline> polylines;
  final Set<Marker> markers;
  final Set<Circle> circleLlegada;

  const MapView({ 
    Key? key, 
    required this.initialLocation, 
    required this.llegadaLocation,
    //required this.polylines, 
    required this.markers,
    required this.circleLlegada
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final mapBloc = BlocProvider.of<MapBloc>(context);
    final CameraPosition initialCameraPosition = CameraPosition(
      target: circleLlegada.length - 1 < 0 ? initialLocation : llegadaLocation,
      //zoom: circleLlegada.length - 1 < 0 ? 25 : 17,//20.5,//15
      zoom: 17
    );

    final size = MediaQuery.of(context).size;

    return SizedBox(
      width: size.width,
      height: size.height,
      child: Listener(
        onPointerMove: ( pointerMoveEvent )=> mapBloc.add( OnStopFollowingUserEvent() ),
        child: circleLlegada.length - 1 < 0 ?
          GoogleMap(
            initialCameraPosition: initialCameraPosition,
            compassEnabled: false,
            myLocationEnabled: true,
            zoomControlsEnabled: false,
            myLocationButtonEnabled: false,
            //polylines: polylines,//mostrar cuando sea como para uber
            markers: markers,
            onMapCreated: ( controller ) => mapBloc.add( OnMapInitialzedEvent(controller) ),
            onCameraMove: ( position ) => mapBloc.mapCenter = position.target,
            //layoutDirection: () => mapBloc. ,
          )
          :
          GoogleMap(
            initialCameraPosition: initialCameraPosition,
            compassEnabled: false,
            myLocationEnabled: true,
            zoomControlsEnabled: true,
            myLocationButtonEnabled: false,
            markers: markers,
            onMapCreated: ( controller ) => mapBloc.add( OnMapInitialzedEvent(controller) ),
            onCameraMove: ( position ) => mapBloc.mapCenter = position.target,
            circles: circleLlegada,
          ),
      
      ),
    );
  }
}