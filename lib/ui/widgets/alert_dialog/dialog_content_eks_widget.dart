import 'package:flutter/material.dart';
import 'package:marcacion_facial_ekuasoft_app/config/config.dart';
import 'package:marcacion_facial_ekuasoft_app/ui/theme/theme.dart';
import 'package:marcacion_facial_ekuasoft_app/ui/widgets/buttons/buttons.dart';

class DialogContentEksWidget extends StatelessWidget {
  const DialogContentEksWidget({
    super.key,
    this.icon,
    this.colorIcon,
    required this.message,
    this.numMessageLines,
    this.title,
    this.numTitleLines,
    this.textPrimaryButton,
    this.onPressedPrimaryButton,
    this.hasTwoOptions,
    this.textSecondaryButton,
    this.onPressedSecondaryButton,
    this.widthCencelar,
    this.widthAceptar,
  });
  //Icon
  final IconData? icon;
  final Color? colorIcon;
  //Message
  final String message;
  final int? numMessageLines;
  //Title
  final String? title;
  final int? numTitleLines;
  //PrimaryButton
  final String? textPrimaryButton;
  final VoidCallback? onPressedPrimaryButton;
  //SecondaryButton
  final bool? hasTwoOptions;
  final String? textSecondaryButton;
  final VoidCallback? onPressedSecondaryButton;

  //Solo para cerrar sesión
  final double? widthCencelar;
  final double? widthAceptar;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return AlertDialog(
      titlePadding: const EdgeInsets.only(left: 24, right: 24, top: 16),
      backgroundColor: ColorsApp().blanco0Opacidad,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(32)),
      title: Container(
        color: Colors.transparent,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(
              icon ?? Icons.info,
              color: colorIcon ?? ColorsApp().morado,
            ),
            const SizedBox(
              width: 5,
            ),
            SizedBox(
              width: size.width * 0.5,
              child: Text(
                title ?? '', 
                /*
                ?? AppLocalizations.of(context)!.informacion,
                
                */
                style: AppTextStyles.h3Bold(
                  width: size.width,
                ),
                maxLines: numTitleLines ?? 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
      contentPadding:
          const EdgeInsets.only(top: 8, left: 24, bottom: 10, right: 24),
      content: Container(
        color: Colors.transparent,
        width: size.width,
        child: Text(
          message,
          
          style: AppTextStyles.bodyRegular(
            width: size.width,
          ),
          
          maxLines: numMessageLines ?? 2,
          overflow: TextOverflow.ellipsis,
        ),
      ),
      actionsAlignment: MainAxisAlignment.spaceBetween,
      actionsPadding:
          const EdgeInsets.only(left: 24, right: 24, bottom: 24, top: 0),
      actions: [
        hasTwoOptions ?? false
            ? Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Container(
                    color: Colors.transparent,
                    width: widthCencelar ?? size.width * 0.2,
                    height: size.height * 0.05,
                    child: GestureDetector(
                      onTap: () {
                        if (onPressedSecondaryButton != null) {
                          onPressedSecondaryButton!();
                        } else
                          //ignore: curly_braces_in_flow_control_structures
                          Navigator.pop(context);
                      },
                      child: TextButtonWidget(
                        null,
                        text: textSecondaryButton ?? 'Cancelar',
                        textStyle: AppTextStyles.h4Bold(
                            width: size.width,
                            color: AppLightColors().textButtonPrimary),
                      ),
                    ),
                  ),
                  /*
                  SizedBox(
                    width: size.width * 0.8
                  ),
                  */
                  Container(
                    color: Colors.transparent,
                    width: widthAceptar ?? size.width * 0.4,
                    height: size.height * 0.05,
                    child: GestureDetector(
                      onTap: () async {
                        if (onPressedPrimaryButton != null) {
                          onPressedPrimaryButton!();
                        } else
                          //ignore: curly_braces_in_flow_control_structures
                          Navigator.pop(context);
                      },
                      child: TextButtonWidget(
                        null,
                        text: textPrimaryButton ?? 'Aceptar',
                        textStyle: AppTextStyles.h4Bold(
                            width: size.width, color: AppLightColors().accentBtn),
                      ),
                    ),
                  ),
                ],
              )
            : Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                    color: Colors.transparent,
                    width: widthAceptar ?? size.width * 0.4,
                    height: size.height * 0.05,
                    alignment: Alignment.center,
                    child: GestureDetector(
                      onTap: () async {
                        if (onPressedPrimaryButton != null) {
                          onPressedPrimaryButton!();
                        } else
                          //ignore: curly_braces_in_flow_control_structures
                          Navigator.pop(context);
                      },
                      child: TextButtonWidget(
                        null,
                        text: textPrimaryButton ?? 'Aceptar',
                        textStyle: AppTextStyles.h4Bold(
                            width: size.width, color: AppLightColors().accentBtn),
                      ),
                    ),
                  ),
              ],
            ),
      ],
    );
  }
}
