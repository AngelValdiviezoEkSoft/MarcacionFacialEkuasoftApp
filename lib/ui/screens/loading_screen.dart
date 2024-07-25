
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:marcacion_facial_ekuasoft_app/domain/models/models.dart';
import 'dart:async';
import 'package:marcacion_facial_ekuasoft_app/ui/ui.dart';
export 'package:marcacion_facial_ekuasoft_app/config/config.dart';
import 'package:marcacion_facial_ekuasoft_app/infraestructure/infraestructure.dart';

class LoadingScreen extends StatefulWidget {
  const LoadingScreen(Key? key) : super(key: key);

  @override
  LoadingScreenState createState() => LoadingScreenState();
}

class LoadingScreenState extends State<LoadingScreen> {

  late CameraService _cameraService;
  late FaceDetectorService _faceDetectorService;
  late MLService _mlService;
  late FaceDetectorService _mlKitService;

  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  bool _isPictureTaken = false;
  bool _isInitializing = false;

  @override
  void initState() {
    super.initState();
    _start();

    Future.delayed(
      //const Duration(milliseconds: 4500),
      const Duration(seconds: 2),
      () {
        _cameraService.dispose();
        _mlService.dispose();
        _faceDetectorService.dispose();
        
        context.push(Rutas().rutaDefault);
      }
    );
  }
  

  @override
  void dispose() {
    _cameraService.dispose();
    _mlService.dispose();
    _faceDetectorService.dispose();
    super.dispose();
  }

  Future _start() async {
    _faceDetectorService = getIt<FaceDetectorService>();
    _cameraService = getIt<CameraService>();
    _mlService = getIt<MLService>();
    _mlKitService = getIt<FaceDetectorService>();

    setState(() => _isInitializing = true);
    
    await _cameraService.initialize();
    
    _faceDetectorService.initialize();
    _mlKitService.initialize();
    
    setState(() => _isInitializing = false);
    _frameFaces();
  }

  _frameFaces() async {
    bool processing = false;
    _cameraService.cameraController!
        .startImageStream((CameraImage image) async {
      if (processing) return; // prevents unnecessary overprocessing.
      processing = true;
      await _predictFacesFromImage(image: image);
      processing = false;
    });
  }

  Future<void> _predictFacesFromImage({@required CameraImage? image}) async {
    assert(image != null, 'Image is null');
    
    await _faceDetectorService.detectFacesFromImage(image!);    
    
    if (_faceDetectorService.faceDetected) {
      _mlService.setCurrentPrediction(image, _faceDetectorService.faces[0]);
    }
    if (mounted) setState(() {});
  }

  Future<void> takePicture() async {
    if (_faceDetectorService.faceDetected) {
      await _cameraService.takePicture();
      setState(() => _isPictureTaken = true);
    } else {
      showDialog(
        barrierDismissible: false,
        //ignore: use_build_context_synchronously
        context: context,
        builder: (BuildContext context) {
          return DialogContentEksWidget(
            title: 'Atención',
            textPrimaryButton: 'Aceptar',
            colorIcon: Colors.red,
            message: 'No se detecta rostro',
            numMessageLines: 1,
            onPressedPrimaryButton: () {
              //ignore: use_build_context_synchronously
              //context.read<AuthBloc>().add(AppStarted());

              //ignore: use_build_context_synchronously
              //Navigator.of(context).pop();
              context.pop();
            },
            hasTwoOptions: false,
          );
        },
      );
    
    }
  }

  _onBackPressed() {
    //Navigator.of(context).pop();
    context.pop();
    //context.push(Rutas().rutaDefault);
  }

  Future<void> onTap() async {
    await takePicture();
    if (_faceDetectorService.faceDetected) {
      
      //ignore: use_build_context_synchronously
      context.pop();

      showDialog(
        barrierDismissible: false,
        //ignore: use_build_context_synchronously
        context: context,
        builder: (BuildContext context) {
          return DialogContentEksWidget(
            title: 'Atención',
            textPrimaryButton: 'Aceptar',
            colorIcon: Colors.blue,
            message: 'Marcación exitosa !!',
            numMessageLines: 1,
            onPressedPrimaryButton: () {
              //ignore: use_build_context_synchronously
              context.read<AuthBloc>().add(AppStarted());

              //ignore: use_build_context_synchronously
              context.pop();
              //Navigator.of(context).pop();
            },
            hasTwoOptions: false,
          );
        },
      );
    
    }
  }

  Widget getBodyWidget() {

    if (_isInitializing) return const Center(child: CircularProgressIndicator());
    
    if (_isPictureTaken)
    {
      return SinglePicture(imagePath: _cameraService.imagePath!);
    }

    return CameraDetectionPreview();
  }

  @override
  Widget build(BuildContext context) {
    final sizeScreen = MediaQuery.of(context).size;
    Widget header = CameraHeader(null, "", onBackPressed: _onBackPressed);
    Widget body = getBodyWidget();
    Widget? fab;

    if (!_isPictureTaken) fab = AuthButton(null, textoBoton: 'Marcar',onTap: onTap);

    return Scaffold(
        backgroundColor: Colors.black.withOpacity(0.5),        
        body: Container(
          color: ColorsApp().morado,
          width: sizeScreen.width,
          height: sizeScreen.height * 0.99,
          child: Image.asset(AppConfig().rutaGifCarga),
        )
      );
    /*
    Scaffold(
      key: scaffoldKey,
      body: Stack(
        children: [
          body,
          header
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: fab,
    );
    */
  }

  LoadingScreenSheet({@required UserFotoModel? user}) 
    => user == null ? 
    Container(
      width: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.all(20),
      child: const Text(
        'Usuario no encontrado',
        style: TextStyle(fontSize: 20),
      ),
    )
    : 
    LoadingScreenSheet(user: user);

}
