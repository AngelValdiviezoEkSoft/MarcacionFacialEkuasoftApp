import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:marcacion_facial_ekuasoft_app/ui/ui.dart';

class CameraDetectionPreview extends StatelessWidget {

  CameraDetectionPreview({Key? key}) : super(key: key);

  final CameraService _cameraService = getIt<CameraService>();
  final FaceDetectorService _faceDetectorService = getIt<FaceDetectorService>();

  @override
  Widget build(BuildContext context) {
    
    final width = MediaQuery.of(context).size.width;

    return Transform.scale(
      scale: 1.0,
      child: AspectRatio(
        aspectRatio: MediaQuery.of(context).size.aspectRatio,
        child: OverflowBox(
          alignment: Alignment.center,
          child: FittedBox(
            fit: BoxFit.fitHeight,
            child: Container(
              color: Colors.transparent,
              width: width,
              height:
                  width * _cameraService.cameraController!.value.aspectRatio,
              child: Stack(
                fit: StackFit.expand,
                children: <Widget>[
                  CameraPreview(_cameraService.cameraController!),
                  if (_faceDetectorService.faceDetected)
                    CustomPaint(
                      painter: FacePainterWidget(
                        face: _faceDetectorService.faces[0],
                        imageSize: _cameraService.getImageSize(),
                      ),
                    )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
