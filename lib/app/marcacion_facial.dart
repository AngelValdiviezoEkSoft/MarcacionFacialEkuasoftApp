import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:marcacion_facial_ekuasoft_app/infraestructure/infraestructure.dart';
import 'package:marcacion_facial_ekuasoft_app/ui/ui.dart';
import 'package:no_screenshot/no_screenshot.dart';
import 'package:trust_location/trust_location.dart';

bool isMockLocation = false;

class MarcacionFacial extends StatefulWidget {

  //ignore: use_super_parameters
  const MarcacionFacial({Key? key}) : super (key: key);

  @override
  State<MarcacionFacial> createState() => MarcacionFacialState();
}

class MarcacionFacialState extends State<MarcacionFacial> {

  late LocationBloc locationBloc;
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

    locationBloc = BlocProvider.of<LocationBloc>(context);
    locationBloc.startFollowingUser(); 

    TrustLocation.start(1);
    getLocation();
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

  Future<void> getLocation() async {
    try {
      TrustLocation.onChange.listen((values) => 
      setState(
        () {
            isMockLocation = values.isMockLocation ?? false;
          }
        )
      );
    } on PlatformException catch (_) {
      //print('PlatformException $e'); 
    }
  }

  @override
  void dispose() {
    super.dispose();
    locationBloc.stopFollowingUser();
  }

  @override
  Widget build(BuildContext context) {
    
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    final gpsBloc = BlocProvider.of<GpsBloc>(context);
    gpsBloc.askGpsAccess();
    
    return MaterialApp.router(
        title: 'Friday',
        debugShowCheckedModeBanner: false,
        routerConfig: appRouter,
      );
  }
}