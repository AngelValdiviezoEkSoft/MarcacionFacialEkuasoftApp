import 'dart:async';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'dart:convert' as convert;

import 'package:marcacion_facial_ekuasoft_app/ui/ui.dart';
import 'package:marcacion_facial_ekuasoft_app/ui/widgets/buttons/buttons.dart';

class RecordFaceVideoScreen extends StatefulWidget {
  const RecordFaceVideoScreen({super.key});

  @override
  State<RecordFaceVideoScreen> createState() => _RecordFaceVideoScreenState();
}

class _RecordFaceVideoScreenState extends State<RecordFaceVideoScreen> {
  late CameraController controller;
  late List<CameraDescription> cameras;
  bool isCameraInitialized = false;
  late bool isRecording = false;
  late Timer timer;
  late int seconds;
  final int initialSeconds = 10;

  Future<void> _initializeCameras() async {
    cameras = await availableCameras();
    CameraDescription selectedCamera = cameras.firstWhere(
      (camera) => camera.lensDirection == CameraLensDirection.front,
      orElse: () => cameras[0],
    );
    controller = CameraController(
      selectedCamera,
      ResolutionPreset.low,
      enableAudio: false,
    );
    await controller.initialize();
    if (mounted) {
      Future.delayed(const Duration(seconds: 3)).then((value) => setState(() {
            isCameraInitialized = true;
          }));
    }
  }

  void startTimer() {
    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (mounted) {
        setState(() {
          if (seconds > 0) {
            seconds--;
          }
        });
      }
    });
  }

  @override
  void initState() {
    super.initState();
    _initializeCameras();
    seconds = initialSeconds;
  }

  @override
  void dispose() {
    controller.dispose();
    timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    const double previewAspectRatio = 1;

    return WillPopScope(
        onWillPop: () async => false,
        child: isCameraInitialized
            ? Scaffold(
                appBar: AppBarWidget(
                  null,
                  'Validación de identidad',
                  oColorLetra: AppLightColors().white,
                  backgorundAppBarColor:
                      AppLightColors().backgroundBlac.withOpacity(0.5),
                  arrowBackColor: AppLightColors().white,
                ),
                backgroundColor:
                    AppLightColors().backgroundBlac.withOpacity(0.5),
                body: SafeArea(
                  child: Container(
                    height: size.height * 0.92,
                    color: Colors.transparent,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Grabar video con su cara',
                                style: AppTextStyles.h1Bold(
                                    width: size.width,
                                    color: AppLightColors().white),
                              ),
                              SizedBox(height: AppSpacing.space05()),
                              Container(
                                color: Colors.transparent,
                                child: Text(
                                  'Gire su cabeza en sentido horario.',
                                  style: AppTextStyles.h2Medium(
                                      width: size.width,
                                      color: AppLightColors().white),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: AppSpacing.space06(),
                          ),
                          //*Circulo para grabar
                          Column(
                            children: [
                              SizedBox(
                                height: size.width * 0.9,
                                width: size.width * 0.9,
                                child: Stack(
                                  fit: StackFit.expand,
                                  children: [
                                    CircularProgressIndicator(
                                      valueColor: AlwaysStoppedAnimation(
                                          AppLightColors().primary),
                                      value: (initialSeconds - seconds) /
                                          initialSeconds,
                                      strokeWidth: 20,
                                      backgroundColor: AppLightColors().white,
                                    ),
                                    Center(
                                      child: AspectRatio(
                                        aspectRatio: 1 / previewAspectRatio,
                                        child: ClipRRect(
                                          borderRadius: BorderRadius.circular(
                                              size.width * 0.9),
                                          child: Transform.scale(
                                            scale:
                                                controller.value.aspectRatio /
                                                    previewAspectRatio,
                                            child: Center(
                                              child: CameraPreview(controller),
                                            ),
                                          ),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: AppSpacing.space04(),
                              ),
                              SizedBox(
                                width: size.width * 0.25,
                                child: Center(
                                  child: Row(
                                    children: [
                                      const Icon(
                                        Icons.circle,
                                        color: Colors.red,
                                        size: 18,
                                      ),
                                      const SizedBox(
                                        width: 5,
                                      ),
                                      Text(
                                          '${(seconds ~/ 60).toString().padLeft(2, "0")}:${(seconds % 60).toString().padLeft(2, "0")}',
                                          style: AppTextStyles.h3Bold(
                                              width: size.width,
                                              color: AppLightColors().white)),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: AppSpacing.space03(),
                          ),
                          Column(
                            children: [
                              GestureDetector(
                                  onTap: () async {
                                    if (!isRecording) {
                                      setState(() {
                                        isRecording = true;
                                      });
                                      startTimer();
                                      await _startRecording();
                                    }
                                  },
                                  child: AppButtonWidget(
                                    text: isRecording
                                        ? 'Grabando...'
                                        : 'Comenzar a grabar',
                                    textStyle: AppTextStyles.h3Bold(
                                        width: size.width,
                                        color: AppLightColors().white),
                                  )),
                              TextButtonWidget(
                                null,
                                onPress: () {
                                  showDialog(
                                    barrierDismissible: false,
                                    context: context,
                                    builder: (BuildContext context) {
                                      return const DialogContentEksWidget(
                                        message:
                                            'Funcionalidad en construcción.',
                                      );
                                    },
                                  );
                                },
                                text: 'Ver instructivo',
                                textStyle: AppTextStyles.h3Bold(
                                    width: size.width,
                                    color: AppLightColors().white),
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              )
            : Scaffold(
                body: Center(
                  child: Container(
                    width: size.width,
                    height: size.height,
                    color: AppLightColors().primary,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            AppConfig().rutaGifCoheteMorado,
                            height: 150.0,
                            width: 150.0,
                          ),
                          const SizedBox(height: 10),
                          Text(
                            "Espere mientras preparamos su cámara",
                            style: AppTextStyles.h3SemiBold(
                                width: size.width,
                                color: AppLightColors().white),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ));
  }

  Future<void> _startRecording() async {
    try {
      await controller.startVideoRecording();
      await Future.delayed(const Duration(seconds: 10));
      final file = await controller.stopVideoRecording();
      //print('Video capturado: ${file.path}');
      // TO_DO: Guardar en base64 el video
      List<int> videoBytes = await file.readAsBytes();
      String videoAsBase64 = convert.base64Encode(videoBytes);
      //Preferences.videoOnBoarding = videoAsBase64;
      setState(() {
        isRecording = false;
      });
      // ignore: use_build_context_synchronously
      /*
      await Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: ((context) => SendRecordFaceVideo(
                    videoPath: file.path,
                  ))));
                  */
      
    } on CameraException catch (_) {
      //print("Error al iniciar la grabación: $e");
      //ignore: use_build_context_synchronously
      _huboProblemaFoto(context);
    }
  }

  void _huboProblemaFoto(context) {
    final size = MediaQuery.of(context).size;
    showModalBottomSheet(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(32.0),
        ),
        context: context,
        builder: (BuildContext bc) {
          return SizedBox(
            height: size.height * 0.35,
            child: Padding(
              padding: const EdgeInsets.only(
                  top: 10, left: 20, right: 20, bottom: 5),
              child: Column(
                children: [
                  SizedBox(
                    width: size.width * 0.15,
                    child: Image.asset(
                      'assets/ic_horizontalLine.png',
                      fit: BoxFit.fill,
                    ),
                  ),
                  SizedBox(
                    height: AppSpacing.space05(),
                  ),
                  SizedBox(
                    child: SafeArea(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SizedBox(
                                height: size.height * 0.045,
                                child: Image.asset(
                                  'assets/ic_cancelar.png',
                                  fit: BoxFit.cover,
                                ),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Text(
                                'Hubo un problema',
                                style: AppTextStyles.h3Bold(width: size.width),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: size.height * 0.02,
                          ),
                          Text(
                            'La foto del documento tiene poca definición, inténtalo de nuevo y asegúrate que esté enfocada',
                            style: AppTextStyles.bodyRegular(width: size.width),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: size.height * 0.01,
                  ),
                  GestureDetector(
                      onTap: () {
                        
                        /*
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: ((context) =>
                                    const RecordFaceVideoExampleScreen())));
                                    */
                      },
                      child: AppButtonWidget(
                        text: 'Intentar de nuevo',
                        textStyle: AppTextStyles.h3Bold(
                            width: size.width, color: AppLightColors().white),
                      )),
                ],
              ),
            ),
          );
        });
  }
}
