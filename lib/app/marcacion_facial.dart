import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:marcacion_facial_ekuasoft_app/config/config.dart';
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

  @override
  void initState() {
    super.initState();
    
    //NO BORRAR PORQUE ESTE CÓDIGO SIRVE PARA BLOQUEAR LAS CAPTURAS DE PANTALLA
    noScreenshot.screenshotOff();
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