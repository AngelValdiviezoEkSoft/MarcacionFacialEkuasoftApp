import 'dart:convert';
import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:marcacion_facial_ekuasoft_app/domain/models/models.dart';
import 'dart:async';
import 'package:marcacion_facial_ekuasoft_app/ui/ui.dart';
export 'package:marcacion_facial_ekuasoft_app/config/config.dart';
import 'package:marcacion_facial_ekuasoft_app/infraestructure/infraestructure.dart';

class GrabaFotoScreen extends StatefulWidget {
  const GrabaFotoScreen(Key? key) : super(key: key);

  @override
  GrabaFotoScreenState createState() => GrabaFotoScreenState();
}

class GrabaFotoScreenState extends State<GrabaFotoScreen> {

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
    _cameraService.cameraController!.startImageStream((CameraImage image) async {
      
      if (processing) return;

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
      
      final pickedFile = await _cameraService.takePicture();
      //setState(() => _isPictureTaken = true);
      
      
      //final pickedFile = await ImagePicker().pickImage(source: ImageSource.camera);

      try {
        if (pickedFile != null) {
          final croppedFile = await ImageCropper().cropImage(                                        
            sourcePath: pickedFile.path,
            compressFormat: ImageCompressFormat.png,
            compressQuality: 100,
            uiSettings: [
              AndroidUiSettings(
                hideBottomControls: true,
                toolbarTitle: 'Recortando',
                toolbarColor: Colors.deepOrange,
                toolbarWidgetColor: Colors.white,
                initAspectRatio: CropAspectRatioPreset.square,
                lockAspectRatio: false
              ),
              IOSUiSettings(
                title: 'Recortando',
              ),

            ],
          );
          
          if (croppedFile != null) {
            
            final bytes = File(croppedFile.path).readAsBytesSync();
            imgBase64 = base64Encode(bytes);
            

            validandoFoto = true;

            setState(() {});

            validandoFoto = false;
            
            rutaNuevaFotoPerfil = croppedFile.path;

            setState(() {});

            _cameraService.dispose();
            _mlService.dispose();
            _faceDetectorService.dispose();

            //ignore: use_build_context_synchronously
            context.pop();
            
          }

        }
      } catch(_) {
        
      }
    } else {
      showDialog(
        context: context,
        builder: (context) =>
          const AlertDialog(content: Text('No se detecta rostro')
        )
      );
    }
  }

  _onBackPressed() {
    Navigator.of(context).pop();
  }

  _reload() {
    if (mounted) setState(() => _isPictureTaken = false);
    _start();
  }

  Future<void> onTap() async {
    await takePicture();
    if (_faceDetectorService.faceDetected) {
      
      UserFotoModel? user = await _mlService.predict();
      
      if(scaffoldKey.currentState != null)
      {
        var bottomSheetController = scaffoldKey.currentState!.showBottomSheet((context) => grabaFotoScreenSheet(user: user));
        bottomSheetController.closed.whenComplete(_reload);
      }
      
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
    Widget header = CameraHeader(null, "", onBackPressed: _onBackPressed);
    Widget body = getBodyWidget();
    Widget? fab;

    if (!_isPictureTaken) fab = AuthButton(null, textoBoton: 'Tomar foto', onTap: onTap);

    return Scaffold(
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
  }

  grabaFotoScreenSheet({@required UserFotoModel? user}) 
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
    grabaFotoScreenSheet(user: user);

}
