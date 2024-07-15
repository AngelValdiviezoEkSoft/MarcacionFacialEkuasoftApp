import 'package:flutter/material.dart';
import 'package:marcacion_facial_ekuasoft_app/ui/ui.dart';

class AppButtonWidget extends StatelessWidget {
  final TextStyle textStyle;
  final String text;
  final Color? colorBoton;
  final VoidCallback? onPressed;

  const AppButtonWidget({
    super.key,
    required this.textStyle,
    required this.text,
    this.colorBoton,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return onPressed == null
        ? Container(
            width: double.infinity,
            height: size.height * 0.06,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(size.width * 0.4),
                color: colorBoton ?? AppLightColors().primary),
            child: Center(
                child: Text(
              text,
              style: textStyle,
            )),
          )
        : GestureDetector(
            onTap: () {
              if (onPressed != null) {
                onPressed!();
              }
            },
            child: Container(
              width: double.infinity,
              height: size.height * 0.06,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(size.width * 0.4),
                  color: colorBoton ?? AppLightColors().primary),
              child: Center(
                  child: Text(
                text,
                style: textStyle,
              )),
            ),
          );
  }
}
