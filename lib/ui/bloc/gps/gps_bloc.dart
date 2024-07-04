import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';

part 'gps_event.dart';
part 'gps_state.dart';

class GpsBloc extends Bloc<GpsEvent, GpsState> {

  StreamSubscription? gpsServiceSubscription;
  bool? tieneUbicacion;

  
  GpsBloc() : super( const GpsState(isGpsEnabled: false, isGpsPermissionGranted: false, isScreenInitial: true, isScreenMapa: false, tieneUbicacion: false) ) {
    
      on<GpsAndPermissionEvent>((event, emit) => emit(state.copyWith(
        isGpsEnabled: event.isGpsEnabled,
        isGpsPermissionGranted: event.isGpsPermissionGranted,
        isScreenMap: event.isMuestraMapa,
        tieneUbicacion: event.tieneUbicacion
      )),

    );

    _init();

  }


  Future<void> _init() async {

    final gpsInitStatus = await Future.wait([
        _checkGpsStatus(),
        _isPermissionGranted(),
    ]);


    add( GpsAndPermissionEvent(
      isGpsEnabled: gpsInitStatus[0],
      isGpsPermissionGranted: gpsInitStatus[1],
      isMuestraMapa: false,
      tieneUbicacion: false
    ));


  }

  Future<bool> _isPermissionGranted() async {
    final isGranted = await Permission.location.isGranted;
    return isGranted;
  }

  Future<bool> _checkGpsStatus() async {

    final isEnable = await Geolocator.isLocationServiceEnabled();

    gpsServiceSubscription = Geolocator.getServiceStatusStream().listen((event) {
      final isEnabled = ( event.index == 1 ) ? true : false;
      add(GpsAndPermissionEvent(
        isGpsEnabled: isEnabled,
        isGpsPermissionGranted: state.isGpsPermissionGranted,
        isMuestraMapa: state.isScreenMapa,
        tieneUbicacion: false
      ));
    });

    return isEnable;  
  }


  Future<void> askGpsAccess() async {
    final status = await Permission.location.request();

    if(status == PermissionStatus.granted){
      add( GpsAndPermissionEvent(isGpsEnabled: state.isGpsEnabled, isGpsPermissionGranted: true, isMuestraMapa: true, tieneUbicacion: false) );//Código original
    }

    if((status == PermissionStatus.denied) || (status == PermissionStatus.restricted) 
      || (status == PermissionStatus.limited) || (status == PermissionStatus.permanentlyDenied)) {
        add( GpsAndPermissionEvent(isGpsEnabled: state.isGpsEnabled, isGpsPermissionGranted: false, isMuestraMapa: false, tieneUbicacion: false) );
        openAppSettings();
    }

/*
    switch ( status ) {
      case PermissionStatus.granted:
        add( GpsAndPermissionEvent(isGpsEnabled: state.isGpsEnabled, isGpsPermissionGranted: true, isMuestraMapa: true, tieneUbicacion: false) );//Código original
        break;
      case PermissionStatus.denied:
      case PermissionStatus.restricted:
      case PermissionStatus.limited:
      case PermissionStatus.permanentlyDenied:
        add( GpsAndPermissionEvent(isGpsEnabled: state.isGpsEnabled, isGpsPermissionGranted: false, isMuestraMapa: false, tieneUbicacion: false) );
        openAppSettings();
    }
    */
  }

  Future<void> vuelvePantallaFrm(bool tieneUbicacion, bool gpsActivado, bool isPermisionGranted) async {
    add(GpsAndPermissionEvent(isGpsEnabled: gpsActivado, isGpsPermissionGranted: isPermisionGranted, isMuestraMapa: false, tieneUbicacion: tieneUbicacion));
  }

  Future<void> vuelveUbicacionNormal(bool tieneUbicacion) async {
    add(GpsAndPermissionEvent(isGpsEnabled: state.isGpsEnabled, isGpsPermissionGranted: state.isGpsPermissionGranted, isMuestraMapa: false, tieneUbicacion: tieneUbicacion));
  }

  @override
  Future<void> close() {
    gpsServiceSubscription?.cancel();
    return super.close();
  }

}
