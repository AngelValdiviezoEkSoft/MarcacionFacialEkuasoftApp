
import 'package:go_router/go_router.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:marcacion_facial_ekuasoft_app/config/config.dart';
import '../../presentation/blocs/auth/auth_bloc.dart';
import '../../presentation/blocs/auth/auth_state.dart';

final objRutas = Rutas();

final GoRouter appRouter = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => BlocBuilder<AuthBloc, AuthState>(
        builder: (context, state) {

          if (state is AuthUnauthenticated) {
            return const WelcomeScreen();
          }
          
          return const SplashScreen();
        },
      ),
    ),
    GoRoute(
      path: objRutas.rutaInitialSplash,
      builder: (context, state) => const WelcomeSplashScreen(),
    ),
    GoRoute(
      path: objRutas.rutaWelcome,
      builder: (context, state) => const WelcomeScreen(),
    ),
    GoRoute(
      path: objRutas.rutaLicense,
      builder: (context, state) => const LicenseScreen(),
    ),
    GoRoute(
      path: objRutas.rutaSetUpPin,
      builder: (context, state) => const SetupPinScreen(),
    ),
    GoRoute(
      path: objRutas.rutaConfirmPin,
      builder: (context, state) => const ConfirmPinScreen(),
    ),
    GoRoute(
      path: objRutas.rutaEnterPin,
      builder: (context, state) => EnterPinScreen(),
    ),
    GoRoute(
      path: objRutas.rutaUserName,
      builder: (context, state) => const UsernameScreen(),
    ),
    GoRoute(
      path: objRutas.rutaChats,
      builder: (context, state) => const ChatListScreen(),
    ),
    GoRoute(
      path: objRutas.rutaChat,
      builder: (context, state) => ChatScreen(),
    ),
    GoRoute(
      path: objRutas.rutaCopiaSeguridad,
      builder: (context, state) => const CopiaSeguridadScreen(),
    ),
  ],
  initialLocation: '/',
);
