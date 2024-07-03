import 'package:flutter/material.dart';
import 'package:marcacion_facial_ekuasoft_app/ui/ui.dart';

class BaseText extends StatelessWidget {
  final double size;
  final FontWeight? weight;
  final Color? color;
  final TextAlign? align;
  final String text;
  final int? maxlines;

  const BaseText(this.text,
      {Key? key,
      this.color,
      required this.size,
      this.weight,
      this.align,
      this.maxlines})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    //double height = MediaQuery.of(context).size.height;
    //final oGoogleFonts = 'Mulish';

    return Text(
      text,
      textAlign: align ?? TextAlign.center,
      style: SafeGoogleFont(
        GoogleFontsApp().fontMulish,
        fontSize: width * size,
        fontWeight: weight ?? FontWeight.w500,
        color: color ?? ColorsApp().negro,
      ),
      maxLines: maxlines ?? 50,
      overflow: TextOverflow.ellipsis,
    );
  }
}
