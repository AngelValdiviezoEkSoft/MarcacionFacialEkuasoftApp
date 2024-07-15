import 'package:flutter/material.dart';
import 'package:marcacion_facial_ekuasoft_app/ui/ui.dart';


class RecordFaceVideoExampleScreen extends StatelessWidget {
  static const String routerName = 'recordFaceVideoExampleScreen';
  const RecordFaceVideoExampleScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        appBar: AppBarWidget(
          null,
          'Validación de identidad',
          oColorLetra: AppLightColors().white,
          backgorundAppBarColor:
              AppLightColors().backgroundBlac.withOpacity(0.5),
          arrowBackColor: AppLightColors().white,
        ),
        backgroundColor: AppLightColors().backgroundBlac.withOpacity(0.5),
        body: const SingleChildScrollView(
          child: Stack(
            children: [_recordFaceVideoExampleBody()],
          ),
        ),
      ),
    );
  }
}

//ignore: camel_case_types
class _recordFaceVideoExampleBody extends StatelessWidget {
  const _recordFaceVideoExampleBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      height: size.height * 0.85,
      color: Colors.transparent,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Grabar video con su cara',
                  style: AppTextStyles.h1Bold(
                    width: size.width,
                    color: AppLightColors().white,
                  ),
                ),
                SizedBox(height: AppSpacing.space05()),
                Container(
                  color: Colors.transparent,
                  child: Text(
                    'Gire su cabeza en sentido horario.',
                    style: AppTextStyles.h2Medium(
                      width: size.width,
                      color: AppLightColors().white,
                    ),
                  ),
                ),
              ],
            ),
            Container(
              height: size.height * 0.3,
              width: size.width * 0.7,
              decoration: BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: AppLightColors().primary),
              ),
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Image.asset(
                  'assets/img_faceEjemplo.jpeg',
                  fit: BoxFit.cover,
                ),
              ),
            ),
            GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: ((context) =>
                              const RecordFaceVideoScreen())));
                },
                child: AppButtonWidget(
                  text: '¡Estoy listo!',
                  textStyle: AppTextStyles.h3Bold(
                      width: size.width, color: AppLightColors().white),
                )),
          ],
        ),
      ),
    );
  }
}
