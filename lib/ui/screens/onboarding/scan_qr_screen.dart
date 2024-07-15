import 'package:ai_barcode_scanner/ai_barcode_scanner.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:marcacion_facial_ekuasoft_app/ui/ui.dart';

//UsuarioType? objUserGeneralEscanearQr;
bool isLoadingScreenQr = false;
const storageQr = FlutterSecureStorage();

//ignore: must_be_immutable
class ScanQrScreen extends StatefulWidget {

  const ScanQrScreen(Key? key) : super(key: key);

  @override
  ScanQrScreenState createState() => ScanQrScreenState();
}

class ScanQrScreenState extends State<ScanQrScreen> {
  @override
  Widget build(BuildContext context) {
    final sizeScreen = MediaQuery.of(context).size;

    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        appBar: AppBarWidget(
          null,
          isLoadingScreenQr ? '' : 'Escanear QR',
          oColorLetra:
              isLoadingScreenQr ? ColorsApp().morado : Colors.white,
          backgorundAppBarColor: isLoadingScreenQr
              ? ColorsApp().morado
              : Colors.black.withOpacity(0.5),
          arrowBackColor:
              isLoadingScreenQr ? ColorsApp().morado : Colors.white,
          onPressed: () async {
            String cantNav =
                await storageQr.read(key: 'conteoNavegacionTransf') ?? '';

            int contNav = int.parse(cantNav);

            for (int i = 0; i < contNav; i++) {
              //ignore: use_build_context_synchronously
              Navigator.of(context).pop();
            }
          },
        ),
        backgroundColor: isLoadingScreenQr
            ? ColorsApp().morado
            : Colors.black.withOpacity(0.5),
/*
        appBar: PluxAppBar(
          'Transferir',
          
          oColorLetra: Colors.black,
          onPressed: () => Navigator.pushReplacement(
            context,
            CupertinoPageRoute(
                builder: (context) => FrmMontoTransferirScreen()),
          ),
        ),
        */

        body: isLoadingScreenQr
            ? Container(
                color: ColorsApp().morado, //Colors.transparent, //const Color(0xfff6f6f6),
                width: sizeScreen.width,
                height: sizeScreen.height * 0.99,
                //child: Image.asset(AppConfig().rutaGifXMorado),
                child: Image.asset(AppConfig().rutaGifPluxMorado),
              )
            : SingleChildScrollView(
                child: SizedBox(
                  height: sizeScreen.height * 0.85,
                  child: Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: AppSpacing.space02()),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        /*
                        Text(
                          'Escanear código QR',
                          style: AppTextStyles.h2Bold(
                              width: sizeScreen.width,
                              color: AppLightColors().white),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Image.asset(
                              'assets/images/scan_qr_img.png',
                              width: sizeScreen.width * 0.07,
                              fit: BoxFit.contain,
                            ),
                            SizedBox(
                              width: AppSpacing.space03(),
                            ),
                            SizedBox(
                              width: sizeScreen.width * 0.8,
                              child: Text(
                                'Encuadra el código QR dentro del marco violeta',
                                style: AppTextStyles.h6Bold(
                                    width: sizeScreen.width,
                                    color: AppLightColors().white),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                        
                        SizedBox(
                          height: AppSpacing.space02(),
                        ),
                        */
                        Container(
                          color: Colors.transparent,
                          height: sizeScreen.height * 0.75,
                          alignment: Alignment.center,
                          child: AiBarcodeScanner(
                            placeholderBuilder: (p0, p1) {
                              return Container(
                                color: Colors.red,
                              );
                            },
                            appBarBuilder: (context, controller) {
                              return AppBar(                                
                                title: const Text(' '),
                                backgroundColor: Colors.transparent,
                                leading: Container(color: Colors.transparent,),
                              );
                            },
                            galleryButtonAlignment: Alignment.center,
                            onDetect: (value) async {

                            },
                            onDispose: () {
                              //debugPrint("Barcode scanner disposed!");
                            },
                            controller: MobileScannerController(
                              detectionSpeed: DetectionSpeed.normal,
                              autoStart: true,
                            ),
                            borderColor: AppLightColors().primary,
                            borderRadius: 16,
                            hideGalleryButton: true,
                            hideGalleryIcon: true,
                            hideSheetDragHandler: true,
                            hideSheetTitle: false,
                            successColor: Colors.green,
                            sheetTitle: 'Escanear código QR',
                            fit: BoxFit.cover,
                          ),
                        ),
                        SizedBox(
                          height: AppSpacing.space02(),
                        ),
                        GestureDetector(
                          onTap: () {
                            /*
                                    Navigator.pushReplacement(
                                      context,
                                      CupertinoPageRoute(
                                          builder: (context) => PrincipalScreen()),
                                    );
                                    */
                            //ignore: use_build_context_synchronously
                            Navigator.of(context).pop();
                          },
                          child: AppButtonWidget(
                            text: 'Cancelar',
                            textStyle: AppTextStyles.h3Bold(
                                width: sizeScreen.width,
                                color: AppLightColors().white),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
      ),
    );
  }
}
