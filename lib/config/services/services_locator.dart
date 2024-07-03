import 'package:get_it/get_it.dart';
import 'package:marcacion_facial_ekuasoft_app/ui/ui.dart';


final GetIt getIt = GetIt.instance;

void setupServiceLocator() {
  getIt.registerLazySingleton<CameraService>(() => CameraService());
  getIt.registerLazySingleton<FaceDetectorService>(() => FaceDetectorService());
  getIt.registerLazySingleton<MLService>(() => MLService());
}
