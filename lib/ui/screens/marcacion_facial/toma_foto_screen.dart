
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:marcacion_facial_ekuasoft_app/domain/models/models.dart';
import 'dart:async';
import 'package:marcacion_facial_ekuasoft_app/ui/ui.dart';
export 'package:marcacion_facial_ekuasoft_app/config/config.dart';

class TomaFotoScreen extends StatefulWidget {
  const TomaFotoScreen({Key? key}) : super(key: key);

  @override
  TomaFotoScreenState createState() => TomaFotoScreenState();
}

class TomaFotoScreenState extends State<TomaFotoScreen> {
  CameraService _cameraService = getIt<CameraService>();
  FaceDetectorService _faceDetectorService = getIt<FaceDetectorService>();
  MLService _mlService = getIt<MLService>();

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
    setState(() => _isInitializing = true);
    await _cameraService.initialize();
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
    
    //try{
      await _faceDetectorService.detectFacesFromImage(image!);
    /*
    }
    catch(e){
      print('Error detección rostro: $e');
    }
    */
    
    if (_faceDetectorService.faceDetected) {
      _mlService.setCurrentPrediction(image!, _faceDetectorService.faces[0]);
    }
    if (mounted) setState(() {});
  }

  Future<void> takePicture() async {
    if (_faceDetectorService.faceDetected) {
      await _cameraService.takePicture();
      setState(() => _isPictureTaken = true);
    } else {
      showDialog(
          context: context,
          builder: (context) =>
              AlertDialog(content: Text('No face detected!')));
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
      var bottomSheetController = scaffoldKey.currentState!
          .showBottomSheet((context) => TomaFotoScreenSheet(user: user));
      bottomSheetController.closed.whenComplete(_reload);
      
    }
  }

  Widget getBodyWidget() {
    if (_isInitializing) return const Center(child: CircularProgressIndicator());
    
    if (_isPictureTaken)
      return SinglePicture(imagePath: _cameraService.imagePath!,);

    return CameraDetectionPreview();
  }

  @override
  Widget build(BuildContext context) {
    Widget header = CameraHeader("LOGIN", onBackPressed: _onBackPressed);
    Widget body = getBodyWidget();
    Widget? fab;

    if (!_isPictureTaken) fab = AuthButton(onTap: onTap);

    return Scaffold(
      key: scaffoldKey,
      body: Stack(
        children: [body, header],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: fab,
    );
  }

  TomaFotoScreenSheet({@required UserFotoModel? user}) => user == null
      ? Container(
          width: MediaQuery.of(context).size.width,
          padding: const EdgeInsets.all(20),
          child: const Text(
            'User not found 😞',
            style: TextStyle(fontSize: 20),
          ),
        )
      : TomaFotoScreenSheet(user: user);
}
