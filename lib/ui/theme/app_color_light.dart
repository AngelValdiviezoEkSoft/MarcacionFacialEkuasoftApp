import 'package:flutter/material.dart';

class AppLightColors {
  //Light Mode Theme
  //Brand Colors
  final Color primary = const Color(0xff7D1BE3);
  final Color primary100 = const Color(0xffFBF6FF);
  final Color primary200 = const Color(0xffEBE4F2);
  final Color textButtonPrimary = const Color(0xff661AB6);
  //Accent Colors
  final Color accent = const Color(0xffEF7D00);
  final Color accentBtn = const Color(0xffFFAA00);
  final Color accentBackground = const Color(0xffFFF2E8);
  final Color accent20 = const Color(0xffEF7D00).withOpacity(0.2);
  //Gray Colors
  final Color white = const Color(0xffFFFFFF);
  final Color whiteOnColor = const Color(0xFFFFFFFF);
  final Color gray100Background = const Color(0xFFF6F6F6);
  final Color gray300Stroke = const Color(0xFFE0E0E0);
  final Color gray400Disabled = const Color(0xFFD9D9D9);
  final Color gray500 = const Color(0xFFBDBDBD);
  final Color gray800SecondaryText = const Color(0xFF616161);
  final Color gray900PrimaryText = const Color(0xFF262626);
  final Color backgroundBlac = const Color(0xFF000000);
  //Semantic Colors
  final Color success = const Color(0xFF1A976A);
  final Color success10 = const Color(0xFF1A976A).withOpacity(0.1);
  final Color error = const Color(0xFF9D002B);
  //Gradient Colors
  final LinearGradient gradientCardCredito =
      const LinearGradient(colors: <Color>[
    Color(0XFF2C0670),
    Color(0XFF0080F6),
  ]);
  final LinearGradient gradientCardDebito =
      const LinearGradient(colors: <Color>[
    Color(0XFF37115F),
    Color(0XFF7A1DDD),
  ]);
  //Bank Cards Colors
  final LinearGradient gradientVisa = const LinearGradient(colors: <Color>[
    Color(0xFF183060),
    Color(0xFF183060),
  ]);
  final LinearGradient gradientMastercard =
      const LinearGradient(colors: <Color>[
    Color(0xFFE06D03),
    Color(0xFFE06D03),
  ]);
  final LinearGradient gradientDiners = const LinearGradient(colors: <Color>[
    Color(0xFF183060),
    Color(0xFF183060),
  ]);
  final LinearGradient gradientHome = const LinearGradient(
    begin: Alignment.bottomLeft,
    end: Alignment.topRight,
    colors: <Color>[
      Color(0xFF3B1266),
      Color(0xFF511591),
    ],
  );
}
