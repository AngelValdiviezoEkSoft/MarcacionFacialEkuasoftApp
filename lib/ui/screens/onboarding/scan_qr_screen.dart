import 'package:ai_barcode_scanner/ai_barcode_scanner.dart';
import 'package:flutter/material.dart';
//import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
//import 'package:fluttertoast/fluttertoast.dart';
import 'package:go_router/go_router.dart';
import 'package:marcacion_facial_ekuasoft_app/ui/ui.dart';

//UsuarioType? objUserGeneralEscanearQr;
bool isLoadingScreenQr = false;
const storageQr = FlutterSecureStorage();
String valorQr = '';

//ignore: must_be_immutable
class ScanQrScreen extends StatefulWidget {

  const ScanQrScreen(Key? key) : super(key: key);

  @override
  ScanQrScreenState createState() => ScanQrScreenState();
}

class ScanQrScreenState extends State<ScanQrScreen> {

  late final MobileScannerController _scannerController;

  @override
  void initState() {
    super.initState();
    _scannerController = MobileScannerController(
      detectionSpeed: DetectionSpeed.normal,
      autoStart: true,
      torchEnabled: false
    );
  }

  @override
  void dispose() {
    _scannerController.stop();
    _scannerController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final sizeScreen = MediaQuery.of(context).size;

    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        appBar: AppBarWidget(
          null,
          isLoadingScreenQr ? '' : 'Escanear QR',
          oColorLetra: isLoadingScreenQr ? ColorsApp().morado : Colors.white,
          backgorundAppBarColor: Colors.black.withOpacity(0.5),
          /*
          isLoadingScreenQr
              ? ColorsApp().morado
              : 
              */
          arrowBackColor: isLoadingScreenQr ? ColorsApp().morado : Colors.white,
          onPressed: () async {
            context.pop();
          },
        ),
        backgroundColor: Colors.black.withOpacity(0.5),
        /*
        isLoadingScreenQr
            ? ColorsApp().morado
            : 
            */
            
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

        body: 
        /*
        isLoadingScreenQr
            ? Container(
                color: ColorsApp().morado, //Colors.transparent, //const Color(0xfff6f6f6),
                width: sizeScreen.width,
                height: sizeScreen.height * 0.99,
                //child: Image.asset(AppConfig().rutaGifXMorado),
                child: Image.asset(AppConfig().rutaGifPluxMorado),
              )
            :
            */ 
        SizedBox(
          height: sizeScreen.height * 0.95,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: AppSpacing.space02()),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    !isLoadingScreenQr ? 'Escanear código QR' : 'Código escaneado',
                    style: AppTextStyles.h2Bold(
                        width: sizeScreen.width,
                        color: AppLightColors().white),
                  ),
                          
                  SizedBox(
                    height: AppSpacing.space02(),
                  ),
                  
                  if(!isLoadingScreenQr)
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
                  
                  if(!isLoadingScreenQr)
                  SizedBox(
                    height: AppSpacing.space02(),
                  ),

                  if(!isLoadingScreenQr)// && !_scannerController.)// .isDisposed)
                  Container(
                    color: Colors.transparent,
                    height: sizeScreen.height * 0.71,
                    alignment: Alignment.center,
                    child: AiBarcodeScanner(
                      placeholderBuilder: (p0, p1) {
                        return Container(
                          color: Colors.transparent,
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
                        if (value.raw != null) {
                          setState(() {
                            valorQr = value.barcodes[0].rawValue ?? '';
                            isLoadingScreenQr = true;
                          });

                          final List<Barcode> barcodes = value.barcodes;
                          String keyRegUs = "";

                          for (final barcode in barcodes) {
                            keyRegUs = barcode.rawValue ?? '';
                          }

                          await storageQr.write(key: KeysApp().keyRegistroUser, value: keyRegUs);

                          /*

                          Fluttertoast.showToast(
                            msg: "Cliente registrado pero no tiene permisos.",
                            toastLength: Toast.LENGTH_LONG,
                            gravity: ToastGravity.TOP,
                            timeInSecForIosWeb: 5,
                            backgroundColor: Colors.red,
                            textColor: Colors.white,
                            fontSize: 16.0
                          );
                          */

                          showDialog(
                            barrierDismissible: false,
                            //ignore: use_build_context_synchronously
                            context: context,
                            builder: (BuildContext context) {
                              return DialogContentEksWidget(
                                title: 'Atención',
                                textPrimaryButton: 'Sí',
                                textSecondaryButton: 'No',
                                colorIcon: Colors.blue,
                                message: '¿Desea registrar usuario?',
                                numMessageLines: 1,
                                hasTwoOptions: true,
                                onPressedPrimaryButton: () async {

                                  _scannerController.stop();
                                  _scannerController.dispose();

                                  //ignore: use_build_context_synchronously
                                  Navigator.of(context).pop();

                                  //ignore: use_build_context_synchronously
                                  Navigator.of(context).pop();

                                  context.push(Rutas().rutaDatosPersonalesOnBoarding);

                                  /*
                                  setState(() {
                                    valorQr = '';
                                    isLoadingScreenQr = false;
                                  });
                                  */

                                  valorQr = '';
                                  isLoadingScreenQr = false;

                                },
                                onPressedSecondaryButton: () async {

                                  
                                  //String initApp = await storageQr.read(key: KeysApp().keyInitApp) ?? '';

                                  _scannerController.stop();
                                  _scannerController.dispose();

                                  //ignore: use_build_context_synchronously
                                  context.pop();

                                  //ignore: use_build_context_synchronously
                                  context.pop();

                                  //ignore: use_build_context_synchronously
                                  context.push(Rutas().rutaTomaFoto);

                                  /*

                                  if(initApp.isEmpty) {
                                    await storageQr.write(key: KeysApp().keyInitApp, value: 'N');

                                    //ignore: use_build_context_synchronously
                                    context.push(Rutas().rutaCarga);
                                  } else {
                                    
                                    //ignore: use_build_context_synchronously
                                    context.push(Rutas().rutaTomaFoto);
                                  }
                                  */

/*
                                  setState(() {
                                    valorQr = '';
                                    isLoadingScreenQr = false;
                                  });
                                  */

                                  valorQr = '';
                                  isLoadingScreenQr = false;

                                },
                              );
                            },
                          );
                        }
                      },
                      
                      onDispose: () {
                        _scannerController.stop();
                        _scannerController.dispose();
                        //debugPrint("Barcode scanner disposed!");
                      },
                      controller: _scannerController,
                      borderColor: AppLightColors().primary,
                      borderRadius: 16,
                      hideGalleryButton: true,
                      hideGalleryIcon: true,
                      hideSheetDragHandler: true,
                      hideSheetTitle: true,
                      successColor: Colors.green,
                      sheetTitle: 'Escanear código QR',
                      fit: BoxFit.cover,
                      validator: (p0) {
                        
                        if(p0.barcodes.isEmpty) {
                          _scannerController.stop();
                          _scannerController.dispose();
                        }

                        return false;
                      },
                    ),
                  ),
                  
                  if(isLoadingScreenQr)
                  SizedBox(
                    height: AppSpacing.space04(),
                  ),
                          
                  if(isLoadingScreenQr)
                  Text(
                    valorQr,
                    style: AppTextStyles.h2Bold(
                      width: sizeScreen.width,
                      color: AppLightColors().white
                    ),
                  ),

                  if(isLoadingScreenQr)
                  SizedBox(
                    height: AppSpacing.space04(),
                  ),

                  if(isLoadingScreenQr)
                  GestureDetector(
                    onTap: () {

                      setState(() {
                        valorQr = '';
                        isLoadingScreenQr = !isLoadingScreenQr;                            
                      });

                    },
                    child: AppButtonWidget(
                      text: 'Volver a escanear.',
                      textStyle: AppTextStyles.h3Bold(
                        width: sizeScreen.width,
                        color: AppLightColors().white
                      ),
                    ),
                  ),

                  if(isLoadingScreenQr)
                  SizedBox(
                    height: AppSpacing.space04(),
                  ),

                  GestureDetector(
                    onTap: () {
                      context.pop();
                    },
                    child: AppButtonWidget(
                      text: 'Cancelar',
                      textStyle: AppTextStyles.h3Bold(
                        width: sizeScreen.width,
                        color: AppLightColors().white,
                      ),
                    ),
                  ),
                
                  SizedBox(
                    height: AppSpacing.space06(),
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
