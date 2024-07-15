import 'package:flutter/material.dart';
import 'package:marcacion_facial_ekuasoft_app/ui/ui.dart';
//import 'package:provider/provider.dart';

class AppBarWidget extends StatelessWidget implements PreferredSizeWidget {
  final bool? goToHome;
  final bool? isLeadingButonShowed;
  final String? text;
  final VoidCallback? onPressed; // Nuevo parámetro opcional
  final Color? oColorLetra;
  final FontWeight? tipoFontWeight;
  final bool? goToLogin;
  final Widget? action;
  final Color? backgorundAppBarColor;
  final Color? arrowBackColor;
  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  const AppBarWidget(
    Key? key,
    this.text, {
    
    this.goToHome = false,
    this.goToLogin = false,
    this.isLeadingButonShowed = true,
    this.onPressed,
    this.oColorLetra,
    this.tipoFontWeight,
    this.action,
    this.backgorundAppBarColor,
    this.arrowBackColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final sizeScreenLst = MediaQuery.of(context).size;
    final oCorpColorsGen = ColorsApp();
    final color = ColorsApp();
    final oGoogleFonts = GoogleFontsApp();

    //final loginForm = Provider.of<AuthService>(context);

    return AppBar(
      titleSpacing: -AppSpacing.space01(),
      title: Text(
        text ?? '',
        style: SafeGoogleFont(
          oGoogleFonts.fontMulish,
          fontSize: sizeScreenLst.width * 0.05,
          fontWeight: tipoFontWeight ?? FontWeight.w600,
          color: oColorLetra ?? AppLightColors().gray800SecondaryText,
        ),
      ),
      leading: !isLeadingButonShowed!
          ? Container()
          : IconButton(
              icon: Icon(
                Icons.arrow_back,
                size: MediaQuery.of(context).size.width * 0.08,
                color: arrowBackColor ?? AppLightColors().primary,
              ),
              onPressed: () async {
                if (onPressed != null) {
                  // Si se proporciona onPressed, úsalo
                  onPressed!();
                } else if (goToHome!) {
                  /*
                  Navigator.of(context)
                      .pushReplacementNamed(PrincipalScreen.routerName);
                      */
                } else if (goToLogin!) {
                  //await loginForm.logOut();
/*
                  //ignore: use_build_context_synchronously
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (_) {
                        return const IntroductionScreen();
                      },
                    ),
                  );
                  */
                } else {
                  Navigator.of(context).pop();
                }
              },
            ),
      actions: action != null ? [action!] : [],
      elevation: 0,
      foregroundColor: color.morado,
      backgroundColor: backgorundAppBarColor ?? Colors.white,
      centerTitle: false,
    );
  }
}
