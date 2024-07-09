import 'package:get_it/get_it.dart';
import 'package:marcacion_facial_ekuasoft_app/infraestructure/infraestructure.dart';
import 'package:marcacion_facial_ekuasoft_app/ui/ui.dart';

final GetIt getIt = GetIt.instance;

void setupServiceLocator() {
  //#Region Servicios 
  getIt.registerLazySingleton<CameraService>(() => CameraService());
  getIt.registerLazySingleton<FaceDetectorService>(() => FaceDetectorService());
  getIt.registerLazySingleton<MLService>(() => MLService());
  getIt.registerLazySingleton<LocalidadService>(() => LocalidadService());
  getIt.registerLazySingleton<TrafficService>(() => TrafficService());
  //#EndRegion

  //#Region Blocs 
  getIt.registerLazySingleton(() => LocationBloc());
  getIt.registerLazySingleton(() => GpsBloc());
  getIt.registerLazySingleton(() => VerificacionBloc());
  getIt.registerLazySingleton(() => MapBloc(locationBloc: LocationBloc()));
  getIt.registerLazySingleton(() => GenericBloc());
  getIt.registerLazySingleton(() => AuthBloc());
  getIt.registerLazySingleton(() => SuscripcionBloc());
  getIt.registerLazySingleton(() => SearchBloc(trafficService: TrafficService()));
  //#EndRegion
}
