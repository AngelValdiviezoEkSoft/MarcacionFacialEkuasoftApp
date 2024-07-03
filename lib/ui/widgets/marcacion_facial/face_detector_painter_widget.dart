
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';

class FaceDetectorPainter extends CustomPainter {
  final Size absulteImageSize;
  
  CameraLensDirection cameraLensDirection;

  FaceDetectorPainter(
      this.absulteImageSize, this.cameraLensDirection);

  @override
  void paint(Canvas canvas, Size size) {
    final double scaleX = size.width / absulteImageSize.width;
    final double scaleY = size.height / absulteImageSize.height;
    final Paint paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.0
      ..color = Colors.greenAccent;

    //for (Face face in faces) {
      canvas.drawRect(
          Rect.fromLTRB(
              cameraLensDirection == CameraLensDirection.back
                  ? 5 * scaleX
                  : (absulteImageSize.width - 6) * scaleX,
              2 * scaleY,
              cameraLensDirection == CameraLensDirection.back
                  ? 4 * scaleX
                  : (absulteImageSize.width - 4) * scaleX,
              2 * scaleY),
          paint);
    //}
  }

  @override
  bool shouldRepaint(covariant FaceDetectorPainter oldDelegate) {
    return oldDelegate.absulteImageSize != absulteImageSize;
  }
}
