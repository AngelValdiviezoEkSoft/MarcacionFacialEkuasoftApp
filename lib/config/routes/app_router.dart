
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:marcacion_facial_ekuasoft_app/ui/ui.dart';
import 'package:trust_location/trust_location.dart';
//export 'package:marcacion_facial_ekuasoft_app/ui/screens/marcacion_facial/marcacion_facial.dart';

final objRutas = Rutas();

final GoRouter appRouter = GoRouter(
  routes: [//
  
    GoRoute(
      path: objRutas.rutaDefault,
      builder: (context, state) => BlocBuilder<AuthBloc, AuthState>(
        builder: (context, state) {

          if (state is AuthNoInternet) {
            return const ConexionInternetScreen(null);
          }

          TrustLocation.onChange.listen((values) {
            isMockLocation = values.isMockLocation ?? false;
          });

/*
          if(state is AuthGpsFake){
            return const GpsFakeScreen(null);
          }
          */

          return const MarcacionScreen();
        },
      ),
    ),
    
    GoRoute(
      path: objRutas.rutaDatosPersonalesOnBoarding,
      builder: (context, state) => RegistroDatosPersonalesScreen(null),
    ),

    GoRoute(
      path: objRutas.rutaDatosFotoOnBoarding,
      builder: (context, state) => const GrabaFotoScreen(null),
    ),
    
    GoRoute(
      path: objRutas.rutaTomaFoto,
      builder: (context, state) => const TomaFotoScreen(null),
    ),

    GoRoute(
      path: objRutas.rutaDatosVideoOnBoarding,
      builder: (context, state) => const RecordFaceVideoScreen(),
    ),

    GoRoute(
      path: objRutas.rutaDatosScanQrOnBoarding,
      builder: (context, state) => const ScanQrScreen(null),
    ),
    
  ],
  initialLocation: objRutas.rutaDefault,
);
