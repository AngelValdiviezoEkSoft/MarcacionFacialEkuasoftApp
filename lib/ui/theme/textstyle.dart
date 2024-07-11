import 'package:flutter/material.dart';
import 'package:marcacion_facial_ekuasoft_app/ui/theme/app_color_light.dart';
//import 'package:marcacion_facial_ekuasoft_app/config/config.dart';
import 'package:marcacion_facial_ekuasoft_app/ui/ui.dart';

class AppTextStyles {
  static TextStyle h1ExtraBold({Color? color, required double width}) {
    return SafeGoogleFont(GoogleFontsApp().fontMulish,
        fontSize: width * 0.0025 * 32,
        fontWeight: FontWeight.w800,
        color: color ?? AppLightColors().gray900PrimaryText,
        letterSpacing: 0);
  }

  static TextStyle h1Bold({Color? color, required double width}) {
    return SafeGoogleFont(GoogleFontsApp().fontMulish,
        fontSize: width * 0.0025 * 32,
        fontWeight: FontWeight.w700,
        color: color ?? AppLightColors().gray900PrimaryText,
        letterSpacing: 0);
  }

  static TextStyle h1SemiBold({Color? color, required double width}) {
    return SafeGoogleFont(GoogleFontsApp().fontMulish,
        fontSize: width * 0.0025 * 32,
        fontWeight: FontWeight.w600,
        color: color ?? AppLightColors().gray900PrimaryText,
        letterSpacing: 0);
  }

  static TextStyle h1Medium({Color? color, required double width}) {
    return SafeGoogleFont(GoogleFontsApp().fontMulish,
        fontSize: width * 0.0025 * 32,
        fontWeight: FontWeight.w500,
        color: color ?? AppLightColors().gray900PrimaryText,
        letterSpacing: 0);
  }

  static TextStyle h1Regular({Color? color, required double width}) {
    return SafeGoogleFont(GoogleFontsApp().fontMulish,
        fontSize: width * 0.0025 * 32,
        fontWeight: FontWeight.w400,
        color: color ?? AppLightColors().gray900PrimaryText,
        letterSpacing: 0);
  }

  static TextStyle h2ExtraBold({Color? color, required double width}) {
    return SafeGoogleFont(GoogleFontsApp().fontMulish,
        fontSize: width * 0.0025 * 24,
        fontWeight: FontWeight.w800,
        color: color ?? AppLightColors().gray900PrimaryText,
        letterSpacing: 0.2);
  }

  static TextStyle h2Bold({Color? color, required double width}) {
    return SafeGoogleFont(GoogleFontsApp().fontMulish,
        fontSize: width * 0.0025 * 24,
        fontWeight: FontWeight.w700,
        color: color ?? AppLightColors().gray900PrimaryText,
        letterSpacing: 0.2);
  }

  static TextStyle h2SemiBold({Color? color, required double width}) {
    return SafeGoogleFont(GoogleFontsApp().fontMulish,
        fontSize: width * 0.0025 * 24,
        fontWeight: FontWeight.w600,
        color: color ?? AppLightColors().gray900PrimaryText,
        letterSpacing: 0.2);
  }

  static TextStyle h2Medium({Color? color, required double width}) {
    return SafeGoogleFont(GoogleFontsApp().fontMulish,
        fontSize: width * 0.0025 * 24,
        fontWeight: FontWeight.w500,
        color: color ?? AppLightColors().gray900PrimaryText,
        letterSpacing: 0.2);
  }

  static TextStyle h2Regular({Color? color, required double width}) {
    return SafeGoogleFont(GoogleFontsApp().fontMulish,
        fontSize: width * 0.0025 * 24,
        fontWeight: FontWeight.w400,
        color: color ?? AppLightColors().gray900PrimaryText,
        letterSpacing: 0.2);
  }

  static TextStyle h3ExtraBold({Color? color, required double width}) {
    return SafeGoogleFont(GoogleFontsApp().fontMulish,
        fontSize: width * 0.0025 * 22,
        fontWeight: FontWeight.w800,
        color: color ?? AppLightColors().gray900PrimaryText,
        letterSpacing: -0.5);
  }

  static TextStyle h3Bold({Color? color, required double width}) {
    return SafeGoogleFont(GoogleFontsApp().fontMulish,
        fontSize: width * 0.0025 * 22,
        fontWeight: FontWeight.w700,
        color: color ?? AppLightColors().gray900PrimaryText,
        letterSpacing: -0.5);
  }

  static TextStyle h3SemiBold({Color? color, required double width}) {
    return SafeGoogleFont(GoogleFontsApp().fontMulish,
        fontSize: width * 0.0025 * 22,
        fontWeight: FontWeight.w600,
        color: color ?? AppLightColors().gray900PrimaryText,
        letterSpacing: -0.5);
  }

  static TextStyle h3Medium({Color? color, required double width}) {
    return SafeGoogleFont(GoogleFontsApp().fontMulish,
        fontSize: width * 0.0025 * 22,
        fontWeight: FontWeight.w500,
        color: color ?? AppLightColors().gray900PrimaryText,
        letterSpacing: -0.5);
  }

  static TextStyle h3Regular({Color? color, required double width}) {
    return SafeGoogleFont(GoogleFontsApp().fontMulish,
        fontSize: width * 0.0025 * 22,
        fontWeight: FontWeight.w400,
        color: color ?? AppLightColors().gray900PrimaryText,
        letterSpacing: -0.5);
  }

  static TextStyle bodyExtraBold({Color? color, required double width}) {
    return SafeGoogleFont(GoogleFontsApp().fontMulish,
        fontSize: width * 0.0025 * 20,
        fontWeight: FontWeight.w800,
        color: color ?? AppLightColors().gray900PrimaryText,
        letterSpacing: 0);
  }

  static TextStyle bodyBold({Color? color, required double width}) {
    return SafeGoogleFont(GoogleFontsApp().fontMulish,
        fontSize: width * 0.0025 * 20,
        fontWeight: FontWeight.w700,
        color: color ?? AppLightColors().gray900PrimaryText,
        letterSpacing: 0);
  }

  static TextStyle bodySemiBold({Color? color, required double width}) {
    return SafeGoogleFont(GoogleFontsApp().fontMulish,
        fontSize: width * 0.0025 * 20,
        fontWeight: FontWeight.w600,
        color: color ?? AppLightColors().gray900PrimaryText,
        letterSpacing: 0);
  }

  static TextStyle bodyMedium({Color? color, required double width}) {
    return SafeGoogleFont(GoogleFontsApp().fontMulish,
        fontSize: width * 0.0025 * 20,
        fontWeight: FontWeight.w500,
        color: color ?? AppLightColors().gray900PrimaryText,
        letterSpacing: 0);
  }

  static TextStyle bodyRegular({Color? color, required double width}) {
    return SafeGoogleFont(GoogleFontsApp().fontMulish,
        fontSize: width * 0.0025 * 20,
        fontWeight: FontWeight.w400,
        color: color ?? AppLightColors().gray900PrimaryText,
        letterSpacing: 0);
  }

  static TextStyle h4ExtraBold({Color? color, required double width}) {
    return SafeGoogleFont(GoogleFontsApp().fontMulish,
        fontSize: width * 0.0025 * 18,
        fontWeight: FontWeight.w800,
        color: color ?? AppLightColors().gray900PrimaryText,
        letterSpacing: 0.2);
  }

  static TextStyle h4Bold({Color? color, required double width}) {
    return SafeGoogleFont(GoogleFontsApp().fontMulish,
        fontSize: width * 0.0025 * 18,
        fontWeight: FontWeight.w700,
        color: color ?? AppLightColors().gray900PrimaryText,
        letterSpacing: 0.2);
  }

  static TextStyle h4SemiBold({Color? color, required double width}) {
    return SafeGoogleFont(GoogleFontsApp().fontMulish,
        fontSize: width * 0.0025 * 18,
        fontWeight: FontWeight.w600,
        color: color ?? AppLightColors().gray900PrimaryText,
        letterSpacing: 0.2);
  }

  static TextStyle h4Medium({Color? color, required double width}) {
    return SafeGoogleFont(GoogleFontsApp().fontMulish,
        fontSize: width * 0.0025 * 18,
        fontWeight: FontWeight.w500,
        color: color ?? AppLightColors().gray900PrimaryText,
        letterSpacing: 0.2);
  }

  static TextStyle h4Regular({Color? color, required double width}) {
    return SafeGoogleFont(GoogleFontsApp().fontMulish,
        fontSize: width * 0.0025 * 18,
        fontWeight: FontWeight.w400,
        color: color ?? AppLightColors().gray900PrimaryText,
        letterSpacing: 0.2);
  }

  static TextStyle h5ExtraBold({Color? color, required double width}) {
    return SafeGoogleFont(GoogleFontsApp().fontMulish,
        fontSize: width * 0.0025 * 16,
        fontWeight: FontWeight.w800,
        color: color ?? AppLightColors().gray900PrimaryText,
        letterSpacing: 0.2);
  }

  static TextStyle h5Bold({Color? color, required double width}) {
    return SafeGoogleFont(GoogleFontsApp().fontMulish,
        fontSize: width * 0.0025 * 16,
        fontWeight: FontWeight.w700,
        color: color ?? AppLightColors().gray900PrimaryText,
        letterSpacing: 0.2);
  }

  static TextStyle h5SemiBold({Color? color, required double width}) {
    return SafeGoogleFont(GoogleFontsApp().fontMulish,
        fontSize: width * 0.0025 * 16,
        fontWeight: FontWeight.w600,
        color: color ?? AppLightColors().gray900PrimaryText,
        letterSpacing: 0.2);
  }

  static TextStyle h5Medium({Color? color, required double width}) {
    return SafeGoogleFont(GoogleFontsApp().fontMulish,
        fontSize: width * 0.0025 * 16,
        fontWeight: FontWeight.w500,
        color: color ?? AppLightColors().gray900PrimaryText,
        letterSpacing: 0.2);
  }

  static TextStyle h5Regular({Color? color, required double width}) {
    return SafeGoogleFont(GoogleFontsApp().fontMulish,
        fontSize: width * 0.0025 * 16,
        fontWeight: FontWeight.w400,
        color: color ?? AppLightColors().gray900PrimaryText,
        letterSpacing: 0.2);
  }

  static TextStyle h6ExtraBold({Color? color, required double width}) {
    return SafeGoogleFont(GoogleFontsApp().fontMulish,
        fontSize: width * 0.0025 * 14,
        fontWeight: FontWeight.w800,
        color: color ?? AppLightColors().gray900PrimaryText,
        letterSpacing: 0.2);
  }

  static TextStyle h6Bold({Color? color, required double width}) {
    return SafeGoogleFont(GoogleFontsApp().fontMulish,
        fontSize: width * 0.0025 * 14,
        fontWeight: FontWeight.w700,
        color: color ?? AppLightColors().gray900PrimaryText,
        letterSpacing: 0.2);
  }

  static TextStyle h6SemiBold({Color? color, required double width}) {
    return SafeGoogleFont(GoogleFontsApp().fontMulish,
        fontSize: width * 0.0025 * 14,
        fontWeight: FontWeight.w600,
        color: color ?? AppLightColors().gray900PrimaryText,
        letterSpacing: 0.2);
  }

  static TextStyle h6Medium({Color? color, required double width}) {
    return SafeGoogleFont(GoogleFontsApp().fontMulish,
        fontSize: width * 0.0025 * 14,
        fontWeight: FontWeight.w500,
        color: color ?? AppLightColors().gray900PrimaryText,
        letterSpacing: 0.2);
  }

  static TextStyle h6Regular({Color? color, required double width}) {
    return SafeGoogleFont(GoogleFontsApp().fontMulish,
        fontSize: width * 0.0025 * 14,
        fontWeight: FontWeight.w400,
        color: color ?? AppLightColors().gray900PrimaryText,
        letterSpacing: 0.2);
  }

  static TextStyle captionExtraBold({Color? color, required double width}) {
    return SafeGoogleFont(GoogleFontsApp().fontMulish,
        fontSize: width * 0.0025 * 14,
        fontWeight: FontWeight.w800,
        color: color ?? AppLightColors().gray900PrimaryText,
        letterSpacing: 0.2);
  }

  static TextStyle captionBold({Color? color, required double width}) {
    return SafeGoogleFont(GoogleFontsApp().fontMulish,
        fontSize: width * 0.0025 * 14,
        fontWeight: FontWeight.w700,
        color: color ?? AppLightColors().gray900PrimaryText,
        letterSpacing: 0.2);
  }

  static TextStyle captionSemiBold({Color? color, required double width}) {
    return SafeGoogleFont(GoogleFontsApp().fontMulish,
        fontSize: width * 0.0025 * 14,
        fontWeight: FontWeight.w600,
        color: color ?? AppLightColors().gray900PrimaryText,
        letterSpacing: 0.2);
  }

  static TextStyle captionMedium({Color? color, required double width}) {
    return SafeGoogleFont(GoogleFontsApp().fontMulish,
        fontSize: width * 0.0025 * 14,
        fontWeight: FontWeight.w500,
        color: color ?? AppLightColors().gray900PrimaryText,
        letterSpacing: 0.2);
  }

  static TextStyle captionRegular({Color? color, required double width}) {
    return SafeGoogleFont(GoogleFontsApp().fontMulish,
        fontSize: width * 0.0025 * 14,
        fontWeight: FontWeight.w400,
        color: color ?? AppLightColors().gray900PrimaryText,
        letterSpacing: 0.2);
  }
}
