import 'package:flutter/material.dart';

class TextButtonWidget extends StatelessWidget {
  final TextStyle textStyle;
  final String text;
  final Color? colorBoton;
  final Color? borderColor;
  final VoidCallback? onPress;

  const TextButtonWidget(
    Key? key,
    {    
    required this.text,
    this.colorBoton,
    this.borderColor,
    this.onPress,
    required this.textStyle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPress,
      style: TextButton.styleFrom(
        backgroundColor: colorBoton,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(50),
          side: BorderSide(
              color: borderColor ?? colorBoton ?? Colors.transparent),
        ),
      ),
      child: Text(
        text,
        style: textStyle,
      ),
    );
  }
}
