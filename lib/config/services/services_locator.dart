import 'package:get_it/get_it.dart';
import 'package:marcacion_facial_ekuasoft_app/ui/ui.dart';


final GetIt getIt = GetIt.instance;

void setupServiceLocator() {
  getIt.registerLazySingleton<CameraService>(() => CameraService());
  getIt.registerLazySingleton<FaceDetectorService>(() => FaceDetectorService());
  getIt.registerLazySingleton<MLService>(() => MLService());

  /*
  getIt.registerLazySingleton(() => ApiService());

  getIt.registerLazySingleton(() => UserPreferences());

  //#Region Registro de Servicios
  getIt.registerLazySingleton(() => AuthRepository(getIt<ApiService>()));

  getIt.registerLazySingleton(() => ChatRepository(getIt<ApiService>()));

  getIt.registerLazySingleton(() => ContactService(getIt<ApiService>()));
  //#EndRegion

  getIt.registerLazySingleton(
      () => AuthBloc(getIt<AuthRepository>(), getIt<UserPreferences>()));

  getIt.registerLazySingleton(() => PinBloc(getIt<UserPreferences>()));

  getIt.registerLazySingleton(
      () => SelectedConversationBloc(getIt<UserPreferences>()));

  getIt.registerLazySingleton(
      () => ChatListBloc(getIt<ChatRepository>(), getIt<UserPreferences>()));

  getIt.registerLazySingleton(() => SocketService());
  
  getIt.registerLazySingleton(
      () => ContactBloc(getIt<ContactService>(), getIt<UserPreferences>()));

  getIt.registerLazySingleton(
      () => GenericBloc(getIt<UserPreferences>()));

  //

  getIt.registerLazySingleton(() => MessagesBloc(
        getIt<SocketService>(),
        getIt<UserPreferences>(),
        getIt<ChatListBloc>(),        
        getIt<ChatRepository>(),
        getIt<SelectedConversationBloc>(),
        getIt<ContactBloc>(),
        getIt<GenericBloc>(),
      ));
      */
}
