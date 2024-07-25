import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:marcacion_facial_ekuasoft_app/infraestructure/infraestructure.dart';
import 'package:marcacion_facial_ekuasoft_app/ui/ui.dart';
import 'package:no_screenshot/no_screenshot.dart';
import 'package:provider/provider.dart';
import 'package:trust_location/trust_location.dart';
//import 'package:location/location.dart';

bool isMockLocation = true;

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
  //Location location = Location();

  @override
  void initState() {
    super.initState();
    _initializeServices();
    
    //noScreenshot.screenshotOff();

    TrustLocation.start(1);
    getLocation();

    /*
    if(!isMockLocation) {
      locationBloc = BlocProvider.of<LocationBloc>(context);
      locationBloc.startFollowingUser();
    }
    */
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

/*
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
*/

  Future<void> getLocation() async {
    try {
      TrustLocation.onChange.listen((values) => setState(() {
        isMockLocation = values.isMockLocation ?? false;

        if(!isMockLocation) {
          locationBloc = BlocProvider.of<LocationBloc>(context);
          locationBloc.startFollowingUser();
        }
      }));
    } on PlatformException catch (_) {
      //print('PlatformException $e');
    }
  }

/*
  Future<void> getLocation() async {
    try {
      LocationData locationData = await location.getLocation();
      setState(() {
        isMockLocation = locationData.isMock ?? false;
      });
    } catch (e) {
      setState(() {
        isMockLocation = false;
      });
    }
  }
  */

  @override
  void dispose() {
    super.dispose();
    TrustLocation.stop();
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
    
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => LocalidadService(),
          lazy: false,
        ),
      ],
      child: MaterialApp.router(
          title: 'Friday',
          debugShowCheckedModeBanner: false,
          routerConfig: appRouter,
        ),
    );
  }
}