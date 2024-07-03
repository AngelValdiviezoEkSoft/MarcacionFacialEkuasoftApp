import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:marcacion_facial_ekuasoft_app/config/environments/environments.dart';

class TextButtonMarcacion extends StatelessWidget {
  final String text;
  final Color? colorBoton;
  final Color? colorTexto;
  final Color? colorBordes;
  final double? tamanioLetra;
  final double? tamanioBordes;

  const TextButtonMarcacion(
      {super.key,
      required this.text,
      required this.colorBoton,
      required this.colorTexto,
      required this.tamanioLetra,
      required this.tamanioBordes,
      required this.colorBordes});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    double fem = MediaQuery.of(context).size.width / size.width;
    return Container(
      width: double.infinity,
      height: 54 * fem,
      decoration: BoxDecoration(
        border: Border.all(
          color: colorBordes != null ? colorBordes! : Colors.white,
          width: size.width * 0.004,
          style: BorderStyle.solid,
        ),
        borderRadius: BorderRadius.circular(
          tamanioBordes != null ? tamanioBordes! : 500 * fem,
        ),
        color: colorBoton != null ? colorBoton! : ColorsApp().morado,
      ),
      child: Center(
        child: Text(
          text,
          style: GoogleFonts.mulish(
            fontSize: tamanioLetra != null ? tamanioLetra! : 24,
            fontWeight: FontWeight.w700,
            height: 1.1818181818,
            letterSpacing: -0.5,
            color: colorTexto != null ? colorTexto! : const Color(0xffffffff),
          ),
        ),
      ),
    );
  }
}
