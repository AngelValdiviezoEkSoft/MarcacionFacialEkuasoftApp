
import 'package:go_router/go_router.dart';
import 'package:marcacion_facial_ekuasoft_app/ui/ui.dart';
//export 'package:marcacion_facial_ekuasoft_app/ui/screens/marcacion_facial/marcacion_facial.dart';

final objRutas = Rutas();

final GoRouter appRouter = GoRouter(
  routes: [//
    GoRoute(
      path: objRutas.rutaDefault,
      builder: (context, state) => const MarcacionScreen(),
    ),
    GoRoute(
      path: objRutas.rutaTomaFoto,
      builder: (context, state) => const TomaFotoScreen(),
    ),
  ],
  initialLocation: objRutas.rutaDefault,
);
