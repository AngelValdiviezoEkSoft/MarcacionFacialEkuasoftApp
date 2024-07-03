import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:marcacion_facial_ekuasoft_app/config/config.dart';
import 'package:marcacion_facial_ekuasoft_app/ui/widgets/widgets.dart';
import 'package:no_screenshot/no_screenshot.dart';


class MarcacionFacial extends StatefulWidget {

  //ignore: use_super_parameters
  const MarcacionFacial({Key? key}) : super (key: key);

  @override
  State<MarcacionFacial> createState() => MarcacionFacialState();
}

class MarcacionFacialState extends State<MarcacionFacial> {

  final noScreenshot = NoScreenshot.instance;
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
  final GlobalKey<ScaffoldMessengerState> messengerKey = GlobalKey<ScaffoldMessengerState>();

  late MLService _mlService;
  late FaceDetectorService _mlKitService;
  late CameraService _cameraService;
  bool loading = false;

  @override
  void initState() {
    super.initState();
    _initializeServices();
    //NO BORRAR PORQUE ESTE CÓDIGO SIRVE PARA BLOQUEAR LAS CAPTURAS DE PANTALLA
    noScreenshot.screenshotOff();
  }

  _initializeServices() async {
    _mlService = getIt<MLService>();
    _mlKitService = getIt<FaceDetectorService>();
    _cameraService = getIt<CameraService>();

    setState(() => loading = true);
    await _cameraService.initialize();
    await _mlService.initialize();
    _mlKitService.initialize();
    setState(() => loading = false);
  }

  @override
  Widget build(BuildContext context) {
    
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    
    return MaterialApp.router(
        title: 'Friday',
        debugShowCheckedModeBanner: false,
        routerConfig: appRouter,
      );
  }
}