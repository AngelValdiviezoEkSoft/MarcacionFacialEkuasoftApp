part of 'gps_bloc.dart';

class GpsState extends Equatable {

  final bool isGpsEnabled;
  final bool isGpsPermissionGranted;
  final bool isScreenInitial;
  final bool isScreenMapa;
  final bool tieneUbicacion;

  bool get isAllGranted => isGpsEnabled && isGpsPermissionGranted;
  bool get isMuestraScreen => isScreenInitial;

  const GpsState({
    required this.isGpsEnabled, 
    required this.isGpsPermissionGranted,
    required this.isScreenInitial,
    required this.isScreenMapa,
    required this.tieneUbicacion
  });

  GpsState copyWith({
    bool? isGpsEnabled,
    bool? isGpsPermissionGranted,
    bool? isMuestraScreen,
    bool? isScreenMap,
    bool? tieneUbicacion
  }) => GpsState(
    isGpsEnabled: isGpsEnabled ?? this.isGpsEnabled, 
    isGpsPermissionGranted: isGpsPermissionGranted ?? this.isGpsPermissionGranted,
    isScreenInitial: isMuestraScreen ?? isScreenInitial,
    isScreenMapa: isScreenMap ?? isScreenMapa,
    tieneUbicacion: tieneUbicacion ?? this.tieneUbicacion
  );
  
  @override
  List<Object> get props => [ isGpsEnabled, isGpsPermissionGranted, isScreenMapa, tieneUbicacion ];

  @override
  String toString() => '{ isGpsEnabled: $isGpsEnabled, isGpsPermissionGranted: $isGpsPermissionGranted }';

}

