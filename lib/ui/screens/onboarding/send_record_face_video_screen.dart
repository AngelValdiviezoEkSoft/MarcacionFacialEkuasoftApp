// import 'dart:convert';
// import 'dart:io';
// import 'package:chewie/chewie.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:intl/intl.dart';
// import 'package:marcacion_facial_ekuasoft_app/ui/ui.dart';
// import 'package:marcacion_facial_ekuasoft_app/ui/widgets/buttons/buttons.dart';
// import 'package:provider/provider.dart';
// import 'package:video_player/video_player.dart';

// class SendRecordFaceVideo extends StatefulWidget {
//   static const String routerName = 'sendRecordFaceVideo';
//   final String? videoPath;
//   const SendRecordFaceVideo({super.key, this.videoPath});

//   @override
//   State<SendRecordFaceVideo> createState() => _SendRecordFaceVideoState();
// }

// class _SendRecordFaceVideoState extends State<SendRecordFaceVideo> {
//   @override
//   Widget build(BuildContext context) {
//     String videoroute = widget.videoPath ?? '';
//     //*Registro
//  /*
//     String fetchDataRaw = Preferences.fetchResponseRegisterData;
//     RegisterModel fetchData = RegisterModel.fromJson(json.decode(fetchDataRaw));
//     String dataToSendRaw = Preferences.sendResponseRegisterData;
//     */
//     //Map<String, dynamic> dataToSend = jsonDecode(dataToSendRaw);
//     return WillPopScope(
//       onWillPop: () async => false,
//       child: Scaffold(
//         extendBody: false,
//         appBar: AppBarWidget(
//           null,
//           'Validación de identidad',
//           oColorLetra: AppLightColors().white,
//           backgorundAppBarColor:
//               AppLightColors().backgroundBlac.withOpacity(0.5),
//           arrowBackColor: AppLightColors().white,
//         ),
//         backgroundColor: AppLightColors().backgroundBlac.withOpacity(0.5),
//         body: SingleChildScrollView(
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               _RegisterForm(
//                 //fetchData: null,//fetchData,
//                 dataToSend: null,//dataToSend,
//                 videoPath: videoroute,
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

// class _RegisterForm extends StatefulWidget {
//   //final RegisterModel fetchData;
//   final String videoPath;
//   final Map<String, dynamic>? dataToSend;
//   const _RegisterForm({
//     //required this.fetchData,
//     required this.dataToSend,
//     required this.videoPath,
//   });

//   @override
//   State<_RegisterForm> createState() => _RegisterFormState();
// }

// class _RegisterFormState extends State<_RegisterForm>
//     with WidgetsBindingObserver {
//   late VideoPlayerController controller;
//   late ChewieController chewieController;
//   bool _isVideoInitialized = false;

//   Future<void> _initializeVideo() async {
//     try {
//       controller = VideoPlayerController.file(File(widget.videoPath));
//       await controller.initialize();
//       controller.setLooping(true);
//       controller.play();

//       chewieController = ChewieController(
//           videoPlayerController: controller,
//           aspectRatio: 0.65,
//           autoPlay: true,
//           looping: true,
//           showControls: true,
//           autoInitialize: true,
//           showControlsOnInitialize: false);

//       setState(() {
//         _isVideoInitialized = true;
//       });
//     } on Exception catch (_) {
//       //print('Error al inicializar el controlador de video: $e');
//     }
//   }

//   TextEditingController documentNumberController = TextEditingController();
//   TextEditingController dateBirthController = TextEditingController();
//   TextEditingController namesController = TextEditingController();
//   TextEditingController firstnameController = TextEditingController();
//   TextEditingController secondnameController = TextEditingController();
//   TextEditingController lastnamesController = TextEditingController();
//   TextEditingController firstLastnameController = TextEditingController();
//   TextEditingController secondLastnameController = TextEditingController();
//   String genero = '';
//   String codGenero = '';
//   String civilStatus = '';
//   String codCivilStatus = '';

//   @override
//   void initState() {
//     super.initState();
//     setControllers();
//     WidgetsBinding.instance.addObserver(this);
//     _initializeVideo();
//   }

//   @override
//   void dispose() {
//     //print("Dispose called");
//     controller.pause();
//     controller.dispose();
//     chewieController.dispose();
//     WidgetsBinding.instance.removeObserver(this);
//     super.dispose();
//   }

//   @override
//   void didChangeAppLifecycleState(AppLifecycleState state) {
//     if (state == AppLifecycleState.resumed) {
//       controller.play();
//     } else {
//       controller.pause();
//     }
//   }

//   setControllers() {
//     /*
//     documentNumberController.text = widget.fetchData.documentNumber!;
//     dateBirthController.text = widget.fetchData.dateOfBirth!;
//     */
//     //Cambio fecha
//     String fechaString = dateBirthController.text;
//     DateTime fecha = DateFormat('dd/MM/yyyy').parse(fechaString);
//     String fechaFormateada = DateFormat('MM/dd/yyyy').format(fecha);
//     dateBirthController.text = fechaFormateada;
//     //fin
//     //namesController.text = widget.fetchData.names!;
//     List names = [];//(widget.fetchData.names!).split(' ');
    
//     firstnameController.text = names[0];
//     secondnameController.text = (names.length >= 2) ? names[1] : '';
//     //lastnamesController.text = widget.fetchData.lastnames!;
//     List lastnames = [];//(widget.fetchData.lastnames!).split(' ');
//     firstLastnameController.text = lastnames[0];
//     secondLastnameController.text = (lastnames.length >= 2) ? lastnames[1] : '';
//     /*
//     if (widget.fetchData.genre == 'HOMBRE') {
//       genero = 'M';
//       codGenero = '577';
//     } else {
//       genero = 'F';
//       codGenero = '578';
//     }
//     if (widget.fetchData.civilStatus == 'SOLTERO' ||
//         widget.fetchData.civilStatus == 'SOLTERA') {
//       civilStatus = 'SOL';
//       codCivilStatus = '571';
//     } else if (widget.fetchData.civilStatus == 'CASADO' ||
//         widget.fetchData.civilStatus == 'CASADA') {
//       civilStatus = 'CAS';
//       codCivilStatus = '572';
//     } else if (widget.fetchData.civilStatus == 'DIVORCIADO' ||
//         widget.fetchData.civilStatus == 'DIVORCIADA') {
//       civilStatus = 'DIV';
//       codCivilStatus = '573';
//     } else if (widget.fetchData.civilStatus == 'VIUDO' ||
//         widget.fetchData.civilStatus == 'VIUDA') {
//       civilStatus = 'VIU';
//       codCivilStatus = '574';
//     } else {
//       civilStatus = 'UDH';
//       codCivilStatus = '575';
//     }
// */
//     setState(() {});
//   }

//   @override
//   Widget build(BuildContext context) {
//     final email = '';//Preferences.maiEemail;
//     final phone = '';//Preferences.userPhone;
//     final password = '';//Preferences.password;
//     final photo = '';//Preferences.photoCedulaFrente;
//     /*
//     final photoDorso = Preferences.photoCedulaDorso;
//     final videoOnBoarding = Preferences.videoOnBoarding;
//     */
//     // final photo = Preferences.videoCara;
//     // *

//     Map<String, dynamic> userToRegister = {
//       "documentType": "CI",
//       "documentNumber": documentNumberController.text,
//       "firstName": firstnameController.text,
//       "secondName": secondnameController.text,
//       "firstLastName": firstLastnameController.text,
//       "secondLastName": secondLastnameController.text,
//       "email": email,
//       "mobilePhone": phone,
//       "userName":
//           "${firstnameController.text.substring(0, 1)}${firstLastnameController.text.toUpperCase()}",
//       "userPasswordHash": password,
//       "pagoplux": false,
//       "genre": genero,
//       "genreCod": codGenero,
//       //*Civil status antes
//       //"civilStatus": signupService.civilStatus,
//       "civilStatus": civilStatus,
//       "civilStatusCod": codCivilStatus,
//       "dateOfBirth": dateBirthController.text,
//       "clientIp": "10.101.10.5",
//       "photo": photo,
//       ...widget.dataToSend!,
//     };

//     if (!_isVideoInitialized) {
//       return Center(
//         child: Padding(
//           padding: const EdgeInsets.only(top: 200),
//           child: Container(
//               color: Colors.transparent,
//               width: 200,
//               height: 200,
//               child: Image.asset(AppConfig().rutaGifXBlancos)),
//         ),
//       );
//     }
//     final size = MediaQuery.of(context).size;
//     //const double previewAspectRatio = 1;
//     return Container(
//       height: size.height * 0.85,
//       color: Colors.transparent,
//       child: Padding(
//         padding: const EdgeInsets.symmetric(horizontal: 16),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: [
//             Column(
//               children: [
//                 SizedBox(
//                   height: size.height * 0.1,
//                   child: Image.asset(
//                     'assets/ic_check.png',
//                     fit: BoxFit.cover,
//                   ),
//                 ),
//                 SizedBox(height: AppSpacing.space04()),
//                 Center(
//                   child: Container(
//                     width: size.width,
//                     color: Colors.transparent,
//                     child: Text(
//                       'Su video se grabó correctamente',
//                       style: AppTextStyles.h2Medium(
//                           width: size.width, color: AppLightColors().white),
//                       textAlign: TextAlign.center,
//                     ),
//                   ),
//                 ),
//                 SizedBox(height: AppSpacing.space05()),
//               ],
//             ),
//             Container(
//               height: size.width * 0.9,
//               width: size.width * 0.9,
//               decoration: BoxDecoration(
//                 color: Colors.black,
//                 borderRadius: BorderRadius.circular(size.width * 0.9),
//                 border: Border.all(color: AppLightColors().primary),
//               ),
//               child: Padding(
//                 padding: const EdgeInsets.all(10),
//                 child: AspectRatio(
//                   aspectRatio: controller.value.aspectRatio,
//                   child: ClipRRect(
//                     borderRadius: BorderRadius.circular(size.width * 0.9),
//                     child: _isVideoInitialized
//                         ? Chewie(
//                             controller: chewieController,
//                           )
//                         : Text(
//                             '',
//                             style:
//                                 AppTextStyles.captionRegular(width: size.width),
//                           ),
//                   ),
//                 ),
//               ),
//             ),
//             SizedBox(
//               height: size.height * 0.07,
//             ),
//             Column(
//               children: [
//                 GestureDetector(
//                     onTap: () async {
//                       /*
//                       try {
//                         Navigator.push(
//                           context,
//                           MaterialPageRoute(
//                             builder: (context) => const LoadingPluxScreen(
//                                 mensaje:
//                                     "Espere mientras registramos su usuario..."),
//                           ),
//                         );
//                         FocusScope.of(context).unfocus();
//                         final signupService =
//                             Provider.of<SignupService>(context, listen: false);
//                         RegisterModel createtUser =
//                             RegisterModel.fromMap(userToRegister);
//                         if (areTermsAccepted) {
//                           createtUser.termsLaFavorita = '1,2';
//                         }
//                         Preferences.password = createtUser.userPasswordHash!;
//                         RespuestaGenericaModel resp =
//                             await signupService.createMemberShip(createtUser);

//                         if (resp.code == 0) {
//                           Preferences.isFormRegisterComplete = true;
//                           signupService.isLoading = false;
//                           // ignore: use_build_context_synchronously
//                           Navigator.pushReplacement(
//                             context,
//                             CupertinoPageRoute(
//                                 builder: (context) => SuccessScreen(
//                                       usuario: createtUser,
//                                     )),
//                           );
//                         } else {
//                           Preferences.idUsuarioCognito = '';
//                           Preferences.isFormRegisterComplete = false;
//                           signupService.isLoading = false;
//                           // ignore: use_build_context_synchronously
//                           Navigator.pushReplacement(
//                               context,
//                               MaterialPageRoute(
//                                   builder: ((context) => ErrorScreen(
//                                         mensaje: resp.detail.response,
//                                       ))));
//                         }
//                         guardarCedulaFrente();
//                         guardarCedulaDorso();
//                         guardarVideoOnBoarding();
//                       } catch (e) {
//                         // ignore: use_build_context_synchronously
//                         Navigator.pop(context);
//                         // ignore: use_build_context_synchronously
//                         showDialog(
//                           context: context,
//                           barrierDismissible: false,
//                           builder: (BuildContext context) {
//                             return DialogPlux(
//                               message:
//                                   'Algo salió mal, por favor vuelve a intetnarlo más tarde',
//                               onPressedPrimaryButton: () {
//                                 Navigator.of(context).pop();
//                                 Navigator.pop(context);
//                               },
//                             );
//                           },
//                         );
//                       }
//                       */
//                     },
//                     child: AppButtonWidget(
//                       text: 'Enviar grabación',
//                       textStyle: AppTextStyles.h3Bold(
//                           width: size.width, color: AppLightColors().white),
//                     )),
//                 TextButtonWidget(
//                   null,
//                   text: 'Grabar de nuevo',
//                   textStyle: AppTextStyles.h3Bold(
//                       width: size.width, color: AppLightColors().white),
//                   onPress: () {
//                     Navigator.pop(context);
//                   },
//                 )
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   void guardarCedulaFrente() async {
//     try {
//       Map<String, dynamic> mediaFiletoSave = {
//         "identificationNumber": documentNumberController.text,
//         "file": '',//Preferences.photoCedulaFrente,
//         "type": "image",
//       };
//       /*
//       final signupService = Provider.of<SignupService>(context, listen: false);
//       SaveMediaFilesModel mediaFiles =
//           SaveMediaFilesModel.fromMap(mediaFiletoSave);
//       //RespuestaGenericaModel resp =
//       await signupService.saveMediaFiles(mediaFiles);
//       */
//       // print(resp.detail.response);
//     } catch (_) {
//       //print('Error Cedula frente: $e');
//     }
//   }

//   void guardarCedulaDorso() async {
//     try {
//       Map<String, dynamic> mediaFiletoSave = {
//         "identificationNumber": documentNumberController.text,
//         "file": '',//Preferences.photoCedulaDorso,
//         "type": "image",
//       };
//       /*
//       final signupService = Provider.of<SignupService>(context, listen: false);
//       SaveMediaFilesModel mediaFiles =
//           SaveMediaFilesModel.fromMap(mediaFiletoSave);
//       //RespuestaGenericaModel resp =
//       await signupService.saveMediaFiles(mediaFiles);
//       */
//       // print(resp.detail.response);
//     } catch (_) {
//       //print('Error Cedula dorso: $e');
//     }
//   }

//   void guardarVideoOnBoarding() async {
//     try {
//       Map<String, dynamic> mediaFiletoSave = {
//         "identificationNumber": documentNumberController.text,
//         "file": '',//Preferences.videoOnBoarding,
//         "type": "video",
//       };
//       /*
//       final signupService = Provider.of<SignupService>(context, listen: false);
//       SaveMediaFilesModel mediaFiles =
//           SaveMediaFilesModel.fromMap(mediaFiletoSave);
//       //RespuestaGenericaModel resp =
//       await signupService.saveMediaFiles(mediaFiles);
//       */
//       //print(resp.detail.response);
//     } catch (_) {
//       //print('Error Video: $e');
//     }
//   }
// }
