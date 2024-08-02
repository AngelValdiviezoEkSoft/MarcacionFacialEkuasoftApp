import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:go_router/go_router.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:marcacion_facial_ekuasoft_app/infraestructure/infraestructure.dart';
import 'package:marcacion_facial_ekuasoft_app/ui/ui.dart';
import 'package:marcacion_facial_ekuasoft_app/domain/domain.dart';

bool validandoFoto = false;
String tipoClienteDatosPersonales = '';
bool varCoordenadasRes = false;
String direccionProspecto = '';
String fechaNacimiento = '';
String numIdentificacionColab = '';
String imgBase64 = '';

TextEditingController cedulaTxt = TextEditingController();

EmpleadoResponseModel objEmpleadoResponseModel = EmpleadoResponseModel(
  code: 0,
  data: EmpleadoModel (
    birthday: '',//DateTime.now(),
    gender: '',
    id: 0,
    name: '',
    privateStreet2: '',
    privateStreet: ''
  ),
  message: '',
  status: '',
  success: false
);

ProspectoType objPrspValido = ProspectoType(
  alias: '',
  apellidos: '',
  area: '',
  autorizadoPor: '',
  celular: '',
  codigoEmpresa: '',
  departamento: '',
  email: '',
  empresa: '',
  fechaNacDate: DateTime.now(),
  fechaNacimiento: '',
  grupoEmpresarial: '',
  id: '',
  identificacion: '',
  imagenPerfil: FotoPerfilModel(
    base64: '',
    extension: '',
    nombre: ''
  ),
  latitud: 0,
  longitud: 0,
  nombres: '',
  password: '',
  tipoCliente: '',
  tipoIdentificacion: '',
  direccion: '',
  genero: ''
);

String rutaNuevaFotoPerfil = '';
ProspectoType? varObjetoProspectoFunc;

Fuentes objFuentesDatPers = Fuentes();
String apiKey = '';
ProspectoType? varObjProspecto;
String varCoordenadasGen = '';

MemoryImage? nuevaFotoPerfilGen;

FeatureApp objFeatureAppFrmDatosPersonales = FeatureApp();

//ignore: must_be_immutable
class RegistroDatosPersonalesScreen extends StatefulWidget {
  
  const RegistroDatosPersonalesScreen(Key? key) : super (key: key);

  @override
  RegistroDatosPersonalesScreenState createState() => RegistroDatosPersonalesScreenState();
}

class RegistroDatosPersonalesScreenState extends State<RegistroDatosPersonalesScreen> with TickerProviderStateMixin {
  
  bool varMostrarDatosCorreo = false;
  
  /*
  RegistroDatosPersonalesScreenState() {
    varObjProspecto = objPrspValido;
    varObjetoProspectoFunc = objPrspValido; 
    if (varCoordenadasRes) {
      varMostrarDatosCorreo = true;
    }
  }
  */

  AnimationController? _scaleController;
  AnimationController? _scale2Controller;
  AnimationController? _widthController;
  AnimationController? _positionController;

  Animation<double>? _scaleAnimation;
  Animation<double>? _scale2Animation;
  Animation<double>? _widthAnimation;
  Animation<double>? _positionAnimation;

  bool hideIcon = false;

  late StreamSubscription<ConnectivityResult> connectivitySubscription;
  //ConnectivityResult _connectionStatus = ConnectivityResult.none;
  //final Connectivity _connectivity = Connectivity();

  ColorsApp objColorsApp = ColorsApp();

  final GlobalKey<FormState> _frmState = GlobalKey<FormState>();

  @override
  void initState() {
    llenaFotoPerfil();
    super.initState();

    final direccionBusca = BlocProvider.of<SuscripcionBloc>(context);
    direccionBusca.setDireccionUsuario('');

    final gpsBloc = BlocProvider.of<GpsBloc>(context);
    gpsBloc.vuelveUbicacionNormal(false);

    _scaleController = AnimationController(vsync: this, duration: const Duration(milliseconds: 300));
    _widthController = AnimationController(vsync: this, duration: const Duration(milliseconds: 600));
    _positionController = AnimationController(vsync: this, duration: const Duration(milliseconds: 1000));
    _scale2Controller = AnimationController(vsync: this, duration: const Duration(milliseconds: 300));
    
    _scaleAnimation = Tween<double>(begin: 1.0, end: 0.8).animate(_scaleController!)
          ..addStatusListener((status) {
            if (status == AnimationStatus.completed) {
              _widthController!.forward();
            }
          });

    _widthAnimation = Tween<double>(begin: 80.0, end: 300.0).animate(_widthController!)
      ..addStatusListener((status) {
          if (status == AnimationStatus.completed) {
            _positionController!.forward();
          }
        }
      );    

    _positionAnimation = Tween<double>(begin: 0.0, end: 215.0).animate(_positionController!)
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          setState(() {
            hideIcon = true;
          });
          _scale2Controller!.forward();
        }
      });

    _scale2Animation = Tween<double>(begin: 1.0, end: 32.0)
      .animate(_scale2Controller!)
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          FocusScope.of(context).unfocus(); //para cerrar teclado del celular
          //Evento del botón siguiente
        }
      }
    );

    //connectivitySubscription = _connectivity.onConnectivityChanged.listen(_updateConnectionStatus); 

    if(Platform.isAndroid) {
      apiKey = objFeatureAppFrmDatosPersonales.apiKeyAndroid;
    }
    if(Platform.isIOS) {
      apiKey = objFeatureAppFrmDatosPersonales.apiKeyIos;
    }

    objPrspValido = ProspectoType(
      alias: '',
      apellidos: '',
      area: '',
      autorizadoPor: '',
      celular: '',
      codigoEmpresa: '',
      departamento: '',
      email: '',
      empresa: '',
      fechaNacDate: DateTime.now(),
      fechaNacimiento: '',
      grupoEmpresarial: '',
      id: '',
      identificacion: '',
      imagenPerfil: FotoPerfilModel(
        base64: '',
        extension: '',
        nombre: ''
      ),
      latitud: 0,
      longitud: 0,
      nombres: '',
      password: '',
      tipoCliente: '',
      tipoIdentificacion: '',
      direccion: '',
      genero: ''
    );
 
  }

  @override
  void dispose() {
    //controllerRecorte.dispose();
    super.dispose();
  }
/*
  Future<void> _updateConnectionStatus(ConnectivityResult result) async {
    setState(() {
      _connectionStatus = result;
    });
    
    if(_connectionStatus.name == ConnectivityResult.none.name) {
      Future.microtask(() => 
        Navigator.of(context, rootNavigator: true).pushReplacement(
          CupertinoPageRoute<bool>(
            fullscreenDialog: true,
            builder: (BuildContext context) => const ConexionInternetScreen(null),
          ),
        )
      );
      
      return;
    }
  }
*/

  Future<void> llenaFotoPerfil() async {
    if(nuevaFotoPerfilGen != null) {
      Uint8List bodyBytes = nuevaFotoPerfilGen!.bytes;
      //final objFoto = await File(rutaFotoPerfil).writeAsBytes(bodyBytes);
      final objFoto = await File('rutaFotoPerfil').writeAsBytes(bodyBytes);

      final bytes = File(objFoto.path).readAsBytesSync();
      String fotoTmp = base64Encode(bytes);

      String primerNombre = objPrspValido.nombres.split(' ')[0];
      
      rutaNuevaFotoPerfil = objFoto.path;
      
      FotoPerfilModel objFotoPerfilNueva = FotoPerfilModel(
        base64: fotoTmp,
        extension: 'png',//rutaFotoPerfil.split('.')[rutaFotoPerfil.split('.').length - 1],//'png',
        nombre: 'foto_perfil_$primerNombre'
      );

      varObjetoProspectoFunc!.imagenPerfil = objFotoPerfilNueva;
      varObjProspecto!.imagenPerfil = objFotoPerfilNueva;
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    //final clienteForm = Provider.of<ProspectoTypeService>(context);
    final sizeFrmDatosPers = MediaQuery.of(context).size;
    //clienteForm.tieneUbicacion = varCoordenadasRes;

    //ignore: unnecessary_string_escapes
    var regexToRemoveEmoji = '   /\uD83C\uDFF4\uDB40\uDC67\uDB40\uDC62(?:\uDB40\uDC77\uDB40\uDC6C\uDB40\uDC73|\uDB40\uDC73\uDB40\uDC63\uDB40\uDC74|\uDB40\uDC65\uDB40\uDC6E\uDB40\uDC67)\uDB40\uDC7F|\uD83D\uDC69\u200D\uD83D\uDC69\u200D(?:\uD83D\uDC66\u200D\uD83D\uDC66|\uD83D\uDC67\u200D(?:\uD83D[\uDC66\uDC67]))|\uD83D\uDC68(?:\uD83C\uDFFF\u200D(?:\uD83E\uDD1D\u200D\uD83D\uDC68(?:\uD83C[\uDFFB-\uDFFE])|\uD83C[\uDF3E\uDF73\uDF7C\uDF93\uDFA4\uDFA8\uDFEB\uDFED]|\uD83D[\uDCBB\uDCBC\uDD27\uDD2C\uDE80\uDE92]|\uD83E[\uDDAF-\uDDB3\uDDBC\uDDBD])|\uD83C\uDFFE\u200D(?:\uD83E\uDD1D\u200D\uD83D\uDC68(?:\uD83C[\uDFFB-\uDFFD\uDFFF])|\uD83C[\uDF3E\uDF73\uDF7C\uDF93\uDFA4\uDFA8\uDFEB\uDFED]|\uD83D[\uDCBB\uDCBC\uDD27\uDD2C\uDE80\uDE92]|\uD83E[\uDDAF-\uDDB3\uDDBC\uDDBD])|\uD83C\uDFFD\u200D(?:\uD83E\uDD1D\u200D\uD83D\uDC68(?:\uD83C[\uDFFB\uDFFC\uDFFE\uDFFF])|\uD83C[\uDF3E\uDF73\uDF7C\uDF93\uDFA4\uDFA8\uDFEB\uDFED]|\uD83D[\uDCBB\uDCBC\uDD27\uDD2C\uDE80\uDE92]|\uD83E[\uDDAF-\uDDB3\uDDBC\uDDBD])|\uD83C\uDFFC\u200D(?:\uD83E\uDD1D\u200D\uD83D\uDC68(?:\uD83C[\uDFFB\uDFFD-\uDFFF])|\uD83C[\uDF3E\uDF73\uDF7C\uDF93\uDFA4\uDFA8\uDFEB\uDFED]|\uD83D[\uDCBB\uDCBC\uDD27\uDD2C\uDE80\uDE92]|\uD83E[\uDDAF-\uDDB3\uDDBC\uDDBD])|\uD83C\uDFFB\u200D(?:\uD83E\uDD1D\u200D\uD83D\uDC68(?:\uD83C[\uDFFC-\uDFFF])|\uD83C[\uDF3E\uDF73\uDF7C\uDF93\uDFA4\uDFA8\uDFEB\uDFED]|\uD83D[\uDCBB\uDCBC\uDD27\uDD2C\uDE80\uDE92]|\uD83E[\uDDAF-\uDDB3\uDDBC\uDDBD])|\u200D(?:\u2764\uFE0F\u200D(?:\uD83D\uDC8B\u200D)?\uD83D\uDC68|(?:\uD83D[\uDC68\uDC69])\u200D(?:\uD83D\uDC66\u200D\uD83D\uDC66|\uD83D\uDC67\u200D(?:\uD83D[\uDC66\uDC67]))|\uD83D\uDC66\u200D\uD83D\uDC66|\uD83D\uDC67\u200D(?:\uD83D[\uDC66\uDC67])|(?:\uD83D[\uDC68\uDC69])\u200D(?:\uD83D[\uDC66\uDC67])|[\u2695\u2696\u2708]\uFE0F|\uD83D[\uDC66\uDC67]|\uD83C[\uDF3E\uDF73\uDF7C\uDF93\uDFA4\uDFA8\uDFEB\uDFED]|\uD83D[\uDCBB\uDCBC\uDD27\uDD2C\uDE80\uDE92]|\uD83E[\uDDAF-\uDDB3\uDDBC\uDDBD])|(?:\uD83C\uDFFF\u200D[\u2695\u2696\u2708]|\uD83C\uDFFE\u200D[\u2695\u2696\u2708]|\uD83C\uDFFD\u200D[\u2695\u2696\u2708]|\uD83C\uDFFC\u200D[\u2695\u2696\u2708]|\uD83C\uDFFB\u200D[\u2695\u2696\u2708])\uFE0F|\uD83C\uDFFF|\uD83C\uDFFE|\uD83C\uDFFD|\uD83C\uDFFC|\uD83C\uDFFB)?|\uD83E\uDDD1(?:(?:\uD83C[\uDFFB-\uDFFF])\u200D(?:\uD83E\uDD1D\u200D\uD83E\uDDD1(?:\uD83C[\uDFFB-\uDFFF])|\uD83C[\uDF3E\uDF73\uDF7C\uDF84\uDF93\uDFA4\uDFA8\uDFEB\uDFED]|\uD83D[\uDCBB\uDCBC\uDD27\uDD2C\uDE80\uDE92]|\uD83E[\uDDAF-\uDDB3\uDDBC\uDDBD])|\u200D(?:\uD83E\uDD1D\u200D\uD83E\uDDD1|\uD83C[\uDF3E\uDF73\uDF7C\uDF84\uDF93\uDFA4\uDFA8\uDFEB\uDFED]|\uD83D[\uDCBB\uDCBC\uDD27\uDD2C\uDE80\uDE92]|\uD83E[\uDDAF-\uDDB3\uDDBC\uDDBD]))|\uD83D\uDC69(?:\u200D(?:\u2764\uFE0F\u200D(?:\uD83D\uDC8B\u200D(?:\uD83D[\uDC68\uDC69])|\uD83D[\uDC68\uDC69])|\uD83C[\uDF3E\uDF73\uDF7C\uDF93\uDFA4\uDFA8\uDFEB\uDFED]|\uD83D[\uDCBB\uDCBC\uDD27\uDD2C\uDE80\uDE92]|\uD83E[\uDDAF-\uDDB3\uDDBC\uDDBD])|\uD83C\uDFFF\u200D(?:\uD83C[\uDF3E\uDF73\uDF7C\uDF93\uDFA4\uDFA8\uDFEB\uDFED]|\uD83D[\uDCBB\uDCBC\uDD27\uDD2C\uDE80\uDE92]|\uD83E[\uDDAF-\uDDB3\uDDBC\uDDBD])|\uD83C\uDFFE\u200D(?:\uD83C[\uDF3E\uDF73\uDF7C\uDF93\uDFA4\uDFA8\uDFEB\uDFED]|\uD83D[\uDCBB\uDCBC\uDD27\uDD2C\uDE80\uDE92]|\uD83E[\uDDAF-\uDDB3\uDDBC\uDDBD])|\uD83C\uDFFD\u200D(?:\uD83C[\uDF3E\uDF73\uDF7C\uDF93\uDFA4\uDFA8\uDFEB\uDFED]|\uD83D[\uDCBB\uDCBC\uDD27\uDD2C\uDE80\uDE92]|\uD83E[\uDDAF-\uDDB3\uDDBC\uDDBD])|\uD83C\uDFFC\u200D(?:\uD83C[\uDF3E\uDF73\uDF7C\uDF93\uDFA4\uDFA8\uDFEB\uDFED]|\uD83D[\uDCBB\uDCBC\uDD27\uDD2C\uDE80\uDE92]|\uD83E[\uDDAF-\uDDB3\uDDBC\uDDBD])|\uD83C\uDFFB\u200D(?:\uD83C[\uDF3E\uDF73\uDF7C\uDF93\uDFA4\uDFA8\uDFEB\uDFED]|\uD83D[\uDCBB\uDCBC\uDD27\uDD2C\uDE80\uDE92]|\uD83E[\uDDAF-\uDDB3\uDDBC\uDDBD]))|\uD83D\uDC69\uD83C\uDFFF\u200D\uD83E\uDD1D\u200D(?:\uD83D[\uDC68\uDC69])(?:\uD83C[\uDFFB-\uDFFE])|\uD83D\uDC69\uD83C\uDFFE\u200D\uD83E\uDD1D\u200D(?:\uD83D[\uDC68\uDC69])(?:\uD83C[\uDFFB-\uDFFD\uDFFF])|\uD83D\uDC69\uD83C\uDFFD\u200D\uD83E\uDD1D\u200D(?:\uD83D[\uDC68\uDC69])(?:\uD83C[\uDFFB\uDFFC\uDFFE\uDFFF])|\uD83D\uDC69\uD83C\uDFFC\u200D\uD83E\uDD1D\u200D(?:\uD83D[\uDC68\uDC69])(?:\uD83C[\uDFFB\uDFFD-\uDFFF])|\uD83D\uDC69\uD83C\uDFFB\u200D\uD83E\uDD1D\u200D(?:\uD83D[\uDC68\uDC69])(?:\uD83C[\uDFFC-\uDFFF])|\uD83D\uDC69\u200D\uD83D\uDC66\u200D\uD83D\uDC66|\uD83D\uDC69\u200D\uD83D\uDC69\u200D(?:\uD83D[\uDC66\uDC67])|(?:\uD83D\uDC41\uFE0F\u200D\uD83D\uDDE8|\uD83D\uDC69(?:\uD83C\uDFFF\u200D[\u2695\u2696\u2708]|\uD83C\uDFFE\u200D[\u2695\u2696\u2708]|\uD83C\uDFFD\u200D[\u2695\u2696\u2708]|\uD83C\uDFFC\u200D[\u2695\u2696\u2708]|\uD83C\uDFFB\u200D[\u2695\u2696\u2708]|\u200D[\u2695\u2696\u2708])|\uD83C\uDFF3\uFE0F\u200D\u26A7|\uD83E\uDDD1(?:(?:\uD83C[\uDFFB-\uDFFF])\u200D[\u2695\u2696\u2708]|\u200D[\u2695\u2696\u2708])|\uD83D\uDC3B\u200D\u2744|(?:(?:\uD83C[\uDFC3\uDFC4\uDFCA]|\uD83D[\uDC6E\uDC70\uDC71\uDC73\uDC77\uDC81\uDC82\uDC86\uDC87\uDE45-\uDE47\uDE4B\uDE4D\uDE4E\uDEA3\uDEB4-\uDEB6]|\uD83E[\uDD26\uDD35\uDD37-\uDD39\uDD3D\uDD3E\uDDB8\uDDB9\uDDCD-\uDDCF\uDDD6-\uDDDD])(?:\uD83C[\uDFFB-\uDFFF])|\uD83D\uDC6F|\uD83E[\uDD3C\uDDDE\uDDDF])\u200D[\u2640\u2642]|(?:\u26F9|\uD83C[\uDFCB\uDFCC]|\uD83D\uDD75)(?:\uFE0F|\uD83C[\uDFFB-\uDFFF])\u200D[\u2640\u2642]|\uD83C\uDFF4\u200D\u2620|(?:\uD83C[\uDFC3\uDFC4\uDFCA]|\uD83D[\uDC6E\uDC70\uDC71\uDC73\uDC77\uDC81\uDC82\uDC86\uDC87\uDE45-\uDE47\uDE4B\uDE4D\uDE4E\uDEA3\uDEB4-\uDEB6]|\uD83E[\uDD26\uDD35\uDD37-\uDD39\uDD3D\uDD3E\uDDB8\uDDB9\uDDCD-\uDDCF\uDDD6-\uDDDD])\u200D[\u2640\u2642]|[\xA9\xAE\u203C\u2049\u2122\u2139\u2194-\u2199\u21A9\u21AA\u2328\u23CF\u23ED-\u23EF\u23F1\u23F2\u23F8-\u23FA\u24C2\u25AA\u25AB\u25B6\u25C0\u25FB\u25FC\u2600-\u2604\u260E\u2611\u2618\u2620\u2622\u2623\u2626\u262A\u262E\u262F\u2638-\u263A\u2640\u2642\u265F\u2660\u2663\u2665\u2666\u2668\u267B\u267E\u2692\u2694-\u2697\u2699\u269B\u269C\u26A0\u26A7\u26B0\u26B1\u26C8\u26CF\u26D1\u26D3\u26E9\u26F0\u26F1\u26F4\u26F7\u26F8\u2702\u2708\u2709\u270F\u2712\u2714\u2716\u271D\u2721\u2733\u2734\u2744\u2747\u2763\u2764\u27A1\u2934\u2935\u2B05-\u2B07\u3030\u303D\u3297\u3299]|\uD83C[\uDD70\uDD71\uDD7E\uDD7F\uDE02\uDE37\uDF21\uDF24-\uDF2C\uDF36\uDF7D\uDF96\uDF97\uDF99-\uDF9B\uDF9E\uDF9F\uDFCD\uDFCE\uDFD4-\uDFDF\uDFF5\uDFF7]|\uD83D[\uDC3F\uDCFD\uDD49\uDD4A\uDD6F\uDD70\uDD73\uDD76-\uDD79\uDD87\uDD8A-\uDD8D\uDDA5\uDDA8\uDDB1\uDDB2\uDDBC\uDDC2-\uDDC4\uDDD1-\uDDD3\uDDDC-\uDDDE\uDDE1\uDDE3\uDDE8\uDDEF\uDDF3\uDDFA\uDECB\uDECD-\uDECF\uDEE0-\uDEE5\uDEE9\uDEF0\uDEF3])\uFE0F|\uD83D\uDC69\u200D\uD83D\uDC67\u200D(?:\uD83D[\uDC66\uDC67])|\uD83C\uDFF3\uFE0F\u200D\uD83C\uDF08|\uD83D\uDC69\u200D\uD83D\uDC67|\uD83D\uDC69\u200D\uD83D\uDC66|\uD83D\uDC15\u200D\uD83E\uDDBA|\uD83D\uDC69(?:\uD83C\uDFFF|\uD83C\uDFFE|\uD83C\uDFFD|\uD83C\uDFFC|\uD83C\uDFFB)?|\uD83C\uDDFD\uD83C\uDDF0|\uD83C\uDDF6\uD83C\uDDE6|\uD83C\uDDF4\uD83C\uDDF2|\uD83D\uDC08\u200D\u2B1B|\uD83D\uDC41\uFE0F|\uD83C\uDFF3\uFE0F|\uD83E\uDDD1(?:\uD83C[\uDFFB-\uDFFF])?|\uD83C\uDDFF(?:\uD83C[\uDDE6\uDDF2\uDDFC])|\uD83C\uDDFE(?:\uD83C[\uDDEA\uDDF9])|\uD83C\uDDFC(?:\uD83C[\uDDEB\uDDF8])|\uD83C\uDDFB(?:\uD83C[\uDDE6\uDDE8\uDDEA\uDDEC\uDDEE\uDDF3\uDDFA])|\uD83C\uDDFA(?:\uD83C[\uDDE6\uDDEC\uDDF2\uDDF3\uDDF8\uDDFE\uDDFF])|\uD83C\uDDF9(?:\uD83C[\uDDE6\uDDE8\uDDE9\uDDEB-\uDDED\uDDEF-\uDDF4\uDDF7\uDDF9\uDDFB\uDDFC\uDDFF])|\uD83C\uDDF8(?:\uD83C[\uDDE6-\uDDEA\uDDEC-\uDDF4\uDDF7-\uDDF9\uDDFB\uDDFD-\uDDFF])|\uD83C\uDDF7(?:\uD83C[\uDDEA\uDDF4\uDDF8\uDDFA\uDDFC])|\uD83C\uDDF5(?:\uD83C[\uDDE6\uDDEA-\uDDED\uDDF0-\uDDF3\uDDF7-\uDDF9\uDDFC\uDDFE])|\uD83C\uDDF3(?:\uD83C[\uDDE6\uDDE8\uDDEA-\uDDEC\uDDEE\uDDF1\uDDF4\uDDF5\uDDF7\uDDFA\uDDFF])|\uD83C\uDDF2(?:\uD83C[\uDDE6\uDDE8-\uDDED\uDDF0-\uDDFF])|\uD83C\uDDF1(?:\uD83C[\uDDE6-\uDDE8\uDDEE\uDDF0\uDDF7-\uDDFB\uDDFE])|\uD83C\uDDF0(?:\uD83C[\uDDEA\uDDEC-\uDDEE\uDDF2\uDDF3\uDDF5\uDDF7\uDDFC\uDDFE\uDDFF])|\uD83C\uDDEF(?:\uD83C[\uDDEA\uDDF2\uDDF4\uDDF5])|\uD83C\uDDEE(?:\uD83C[\uDDE8-\uDDEA\uDDF1-\uDDF4\uDDF6-\uDDF9])|\uD83C\uDDED(?:\uD83C[\uDDF0\uDDF2\uDDF3\uDDF7\uDDF9\uDDFA])|\uD83C\uDDEC(?:\uD83C[\uDDE6\uDDE7\uDDE9-\uDDEE\uDDF1-\uDDF3\uDDF5-\uDDFA\uDDFC\uDDFE])|\uD83C\uDDEB(?:\uD83C[\uDDEE-\uDDF0\uDDF2\uDDF4\uDDF7])|\uD83C\uDDEA(?:\uD83C[\uDDE6\uDDE8\uDDEA\uDDEC\uDDED\uDDF7-\uDDFA])|\uD83C\uDDE9(?:\uD83C[\uDDEA\uDDEC\uDDEF\uDDF0\uDDF2\uDDF4\uDDFF])|\uD83C\uDDE8(?:\uD83C[\uDDE6\uDDE8\uDDE9\uDDEB-\uDDEE\uDDF0-\uDDF5\uDDF7\uDDFA-\uDDFF])|\uD83C\uDDE7(?:\uD83C[\uDDE6\uDDE7\uDDE9-\uDDEF\uDDF1-\uDDF4\uDDF6-\uDDF9\uDDFB\uDDFC\uDDFE\uDDFF])|\uD83C\uDDE6(?:\uD83C[\uDDE8-\uDDEC\uDDEE\uDDF1\uDDF2\uDDF4\uDDF6-\uDDFA\uDDFC\uDDFD\uDDFF])|[#\*0-9]\uFE0F\u20E3|(?:\uD83C[\uDFC3\uDFC4\uDFCA]|\uD83D[\uDC6E\uDC70\uDC71\uDC73\uDC77\uDC81\uDC82\uDC86\uDC87\uDE45-\uDE47\uDE4B\uDE4D\uDE4E\uDEA3\uDEB4-\uDEB6]|\uD83E[\uDD26\uDD35\uDD37-\uDD39\uDD3D\uDD3E\uDDB8\uDDB9\uDDCD-\uDDCF\uDDD6-\uDDDD])(?:\uD83C[\uDFFB-\uDFFF])|(?:\u26F9|\uD83C[\uDFCB\uDFCC]|\uD83D\uDD75)(?:\uFE0F|\uD83C[\uDFFB-\uDFFF])|\uD83C\uDFF4|(?:[\u270A\u270B]|\uD83C[\uDF85\uDFC2\uDFC7]|\uD83D[\uDC42\uDC43\uDC46-\uDC50\uDC66\uDC67\uDC6B-\uDC6D\uDC72\uDC74-\uDC76\uDC78\uDC7C\uDC83\uDC85\uDCAA\uDD7A\uDD95\uDD96\uDE4C\uDE4F\uDEC0\uDECC]|\uD83E[\uDD0C\uDD0F\uDD18-\uDD1C\uDD1E\uDD1F\uDD30-\uDD34\uDD36\uDD77\uDDB5\uDDB6\uDDBB\uDDD2-\uDDD5])(?:\uD83C[\uDFFB-\uDFFF])|(?:[\u261D\u270C\u270D]|\uD83D[\uDD74\uDD90])(?:\uFE0F|\uD83C[\uDFFB-\uDFFF])|[\u270A\u270B]|\uD83C[\uDF85\uDFC2\uDFC7]|\uD83D[\uDC08\uDC15\uDC3B\uDC42\uDC43\uDC46-\uDC50\uDC66\uDC67\uDC6B-\uDC6D\uDC72\uDC74-\uDC76\uDC78\uDC7C\uDC83\uDC85\uDCAA\uDD7A\uDD95\uDD96\uDE4C\uDE4F\uDEC0\uDECC]|\uD83E[\uDD0C\uDD0F\uDD18-\uDD1C\uDD1E\uDD1F\uDD30-\uDD34\uDD36\uDD77\uDDB5\uDDB6\uDDBB\uDDD2-\uDDD5]|\uD83C[\uDFC3\uDFC4\uDFCA]|\uD83D[\uDC6E\uDC70\uDC71\uDC73\uDC77\uDC81\uDC82\uDC86\uDC87\uDE45-\uDE47\uDE4B\uDE4D\uDE4E\uDEA3\uDEB4-\uDEB6]|\uD83E[\uDD26\uDD35\uDD37-\uDD39\uDD3D\uDD3E\uDDB8\uDDB9\uDDCD-\uDDCF\uDDD6-\uDDDD]|\uD83D\uDC6F|\uD83E[\uDD3C\uDDDE\uDDDF]|[\u231A\u231B\u23E9-\u23EC\u23F0\u23F3\u25FD\u25FE\u2614\u2615\u2648-\u2653\u267F\u2693\u26A1\u26AA\u26AB\u26BD\u26BE\u26C4\u26C5\u26CE\u26D4\u26EA\u26F2\u26F3\u26F5\u26FA\u26FD\u2705\u2728\u274C\u274E\u2753-\u2755\u2757\u2795-\u2797\u27B0\u27BF\u2B1B\u2B1C\u2B50\u2B55]|\uD83C[\uDC04\uDCCF\uDD8E\uDD91-\uDD9A\uDE01\uDE1A\uDE2F\uDE32-\uDE36\uDE38-\uDE3A\uDE50\uDE51\uDF00-\uDF20\uDF2D-\uDF35\uDF37-\uDF7C\uDF7E-\uDF84\uDF86-\uDF93\uDFA0-\uDFC1\uDFC5\uDFC6\uDFC8\uDFC9\uDFCF-\uDFD3\uDFE0-\uDFF0\uDFF8-\uDFFF]|\uD83D[\uDC00-\uDC07\uDC09-\uDC14\uDC16-\uDC3A\uDC3C-\uDC3E\uDC40\uDC44\uDC45\uDC51-\uDC65\uDC6A\uDC79-\uDC7B\uDC7D-\uDC80\uDC84\uDC88-\uDCA9\uDCAB-\uDCFC\uDCFF-\uDD3D\uDD4B-\uDD4E\uDD50-\uDD67\uDDA4\uDDFB-\uDE44\uDE48-\uDE4A\uDE80-\uDEA2\uDEA4-\uDEB3\uDEB7-\uDEBF\uDEC1-\uDEC5\uDED0-\uDED2\uDED5-\uDED7\uDEEB\uDEEC\uDEF4-\uDEFC\uDFE0-\uDFEB]|\uD83E[\uDD0D\uDD0E\uDD10-\uDD17\uDD1D\uDD20-\uDD25\uDD27-\uDD2F\uDD3A\uDD3F-\uDD45\uDD47-\uDD76\uDD78\uDD7A-\uDDB4\uDDB7\uDDBA\uDDBC-\uDDCB\uDDD0\uDDE0-\uDDFF\uDE70-\uDE74\uDE78-\uDE7A\uDE80-\uDE86\uDE90-\uDEA8\uDEB0-\uDEB6\uDEC0-\uDEC2\uDED0-\uDED6]|(?:[\u231A\u231B\u23E9-\u23EC\u23F0\u23F3\u25FD\u25FE\u2614\u2615\u2648-\u2653\u267F\u2693\u26A1\u26AA\u26AB\u26BD\u26BE\u26C4\u26C5\u26CE\u26D4\u26EA\u26F2\u26F3\u26F5\u26FA\u26FD\u2705\u270A\u270B\u2728\u274C\u274E\u2753-\u2755\u2757\u2795-\u2797\u27B0\u27BF\u2B1B\u2B1C\u2B50\u2B55]|\uD83C[\uDC04\uDCCF\uDD8E\uDD91-\uDD9A\uDDE6-\uDDFF\uDE01\uDE1A\uDE2F\uDE32-\uDE36\uDE38-\uDE3A\uDE50\uDE51\uDF00-\uDF20\uDF2D-\uDF35\uDF37-\uDF7C\uDF7E-\uDF93\uDFA0-\uDFCA\uDFCF-\uDFD3\uDFE0-\uDFF0\uDFF4\uDFF8-\uDFFF]|\uD83D[\uDC00-\uDC3E\uDC40\uDC42-\uDCFC\uDCFF-\uDD3D\uDD4B-\uDD4E\uDD50-\uDD67\uDD7A\uDD95\uDD96\uDDA4\uDDFB-\uDE4F\uDE80-\uDEC5\uDECC\uDED0-\uDED2\uDED5-\uDED7\uDEEB\uDEEC\uDEF4-\uDEFC\uDFE0-\uDFEB]|\uD83E[\uDD0C-\uDD3A\uDD3C-\uDD45\uDD47-\uDD78\uDD7A-\uDDCB\uDDCD-\uDDFF\uDE70-\uDE74\uDE78-\uDE7A\uDE80-\uDE86\uDE90-\uDEA8\uDEB0-\uDEB6\uDEC0-\uDEC2\uDED0-\uDED6])|(?:[#\*0-9\xA9\xAE\u203C\u2049\u2122\u2139\u2194-\u2199\u21A9\u21AA\u231A\u231B\u2328\u23CF\u23E9-\u23F3\u23F8-\u23FA\u24C2\u25AA\u25AB\u25B6\u25C0\u25FB-\u25FE\u2600-\u2604\u260E\u2611\u2614\u2615\u2618\u261D\u2620\u2622\u2623\u2626\u262A\u262E\u262F\u2638-\u263A\u2640\u2642\u2648-\u2653\u265F\u2660\u2663\u2665\u2666\u2668\u267B\u267E\u267F\u2692-\u2697\u2699\u269B\u269C\u26A0\u26A1\u26A7\u26AA\u26AB\u26B0\u26B1\u26BD\u26BE\u26C4\u26C5\u26C8\u26CE\u26CF\u26D1\u26D3\u26D4\u26E9\u26EA\u26F0-\u26F5\u26F7-\u26FA\u26FD\u2702\u2705\u2708-\u270D\u270F\u2712\u2714\u2716\u271D\u2721\u2728\u2733\u2734\u2744\u2747\u274C\u274E\u2753-\u2755\u2757\u2763\u2764\u2795-\u2797\u27A1\u27B0\u27BF\u2934\u2935\u2B05-\u2B07\u2B1B\u2B1C\u2B50\u2B55\u3030\u303D\u3297\u3299]|\uD83C[\uDC04\uDCCF\uDD70\uDD71\uDD7E\uDD7F\uDD8E\uDD91-\uDD9A\uDDE6-\uDDFF\uDE01\uDE02\uDE1A\uDE2F\uDE32-\uDE3A\uDE50\uDE51\uDF00-\uDF21\uDF24-\uDF93\uDF96\uDF97\uDF99-\uDF9B\uDF9E-\uDFF0\uDFF3-\uDFF5\uDFF7-\uDFFF]|\uD83D[\uDC00-\uDCFD\uDCFF-\uDD3D\uDD49-\uDD4E\uDD50-\uDD67\uDD6F\uDD70\uDD73-\uDD7A\uDD87\uDD8A-\uDD8D\uDD90\uDD95\uDD96\uDDA4\uDDA5\uDDA8\uDDB1\uDDB2\uDDBC\uDDC2-\uDDC4\uDDD1-\uDDD3\uDDDC-\uDDDE\uDDE1\uDDE3\uDDE8\uDDEF\uDDF3\uDDFA-\uDE4F\uDE80-\uDEC5\uDECB-\uDED2\uDED5-\uDED7\uDEE0-\uDEE5\uDEE9\uDEEB\uDEEC\uDEF0\uDEF3-\uDEFC\uDFE0-\uDFEB]|\uD83E[\uDD0C-\uDD3A\uDD3C-\uDD45\uDD47-\uDD78\uDD7A-\uDDCB\uDDCD-\uDDFF\uDE70-\uDE74\uDE78-\uDE7A\uDE80-\uDE86\uDE90-\uDEA8\uDEB0-\uDEB6\uDEC0-\uDEC2\uDED0-\uDED6])\uFE0F|(?:[\u261D\u26F9\u270A-\u270D]|\uD83C[\uDF85\uDFC2-\uDFC4\uDFC7\uDFCA-\uDFCC]|\uD83D[\uDC42\uDC43\uDC46-\uDC50\uDC66-\uDC78\uDC7C\uDC81-\uDC83\uDC85-\uDC87\uDC8F\uDC91\uDCAA\uDD74\uDD75\uDD7A\uDD90\uDD95\uDD96\uDE45-\uDE47\uDE4B-\uDE4F\uDEA3\uDEB4-\uDEB6\uDEC0\uDECC]|\uD83E[\uDD0C\uDD0F\uDD18-\uDD1F\uDD26\uDD30-\uDD39\uDD3C-\uDD3E\uDD77\uDDB5\uDDB6\uDDB8\uDDB9\uDDBB\uDDCD-\uDDCF\uDDD1-\uDDDD])/';
    /*
    Color coloresTextoRepuesta;
    Color coloresFondoRepuesta;
    */

    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
          backgroundColor: Colors.transparent,
          body: BlocBuilder<GpsBloc, GpsState>(builder: (context, state) {

            return 
            /*
            !state.isScreenMapa
            ? 
            */

            BlocBuilder<SuscripcionBloc, SuscripcionState>(
              builder: (context, stateSuscripcion) {
                return Form(
                  key: _frmState,
                  //autovalidateMode: AutovalidateMode.onUserInteraction,
                  child: Container(
                    color: Colors.transparent,
                    width: sizeFrmDatosPers.width,
                    height: sizeFrmDatosPers.height,
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween, 
                        children: <Widget>[
                
                          SizedBox(height: sizeFrmDatosPers.height * 0.008,),
                
                          Container(
                            color: Colors.transparent,
                            width: sizeFrmDatosPers.width,
                            height: sizeFrmDatosPers.height * 0.1,
                            alignment: Alignment.bottomCenter,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                MaterialButton(
                                  shape: const CircleBorder(),
                                  disabledColor: Colors.white,
                                  elevation: 0,
                                  color: Colors.transparent,
                                  child: Container(
                                    color: Colors.transparent,
                                    child: const Icon(
                                      Icons.arrow_back_ios,
                                      color: Colors.white,
                                      size: 30,
                                    ),
                                  ),
                                  onPressed: () {
                                    rutaNuevaFotoPerfil = '';
                                    context.pop();
                                  }
                                ),
              
                                MaterialButton(
                                  shape: const CircleBorder(),
                                  disabledColor: Colors.white,
                                  elevation: 0,
                                  color: Colors.transparent,
                                  child: Container(
                                    color: Colors.transparent,
                                    child: const Icon(
                                      Icons.close,
                                      color: Colors.white,
                                      size: 30,
                                    ),
                                  ),
                                  onPressed: () => exit(0),
                                ),
                              ],
                            ),
                          ),
                
                          SizedBox(height: sizeFrmDatosPers.height * 0.01,),

                          Container(
                            color: Colors.transparent,
                            width: sizeFrmDatosPers.width * 0.85,
                            height: sizeFrmDatosPers.height * 0.05,
                            child: Center(
                              child: AutoSizeText(
                                'Registro de datos',
                                style: TextStyle(
                                  color: objColorsApp.naranjaIntenso,
                                  fontFamily: objFuentesDatPers.fuenteMonserate
                                ),
                                maxLines: 1,
                                presetFontSizes: const [20,18,16,14,12,10],
                              ),
                            ),
                          ),
                
                          SizedBox(height: sizeFrmDatosPers.height * 0.02,),
                
                          if(rutaNuevaFotoPerfil == '')
                          Container(
                            color: Colors.transparent,
                            height: sizeFrmDatosPers.height * 0.18,
                            width: sizeFrmDatosPers.width * 0.33,
                            child: GestureDetector(
                              onTap: () async {
                                /*
                                final pickedFile = await ImagePicker().pickImage(source: ImageSource.camera);
                
                                try {
                                  if (pickedFile != null) {
                                    final croppedFile = await ImageCropper().cropImage(                                        
                                      sourcePath: pickedFile.path,
                                      compressFormat: ImageCompressFormat.png,
                                      compressQuality: 100,
                                      uiSettings: [
                                        AndroidUiSettings(
                                          hideBottomControls: true,
                                          toolbarTitle: 'Recortando',
                                          toolbarColor: Colors.deepOrange,
                                          toolbarWidgetColor: Colors.white,
                                          initAspectRatio: CropAspectRatioPreset.square,
                                          lockAspectRatio: false
                                        ),
                                        IOSUiSettings(
                                          title: 'Recortando',
                                        ),
                
                                      ],
                                    );
                                    if (croppedFile != null) {
                                      final bytes = File(croppedFile.path).readAsBytesSync();
                                      String img64 = base64Encode(bytes);
                
                                      FotoPerfilModel objFotoPerfilNueva = FotoPerfilModel(
                                        base64: img64,
                                        extension: 'png',
                                        nombre: 'foto_perfil'
                                      );
                
                                      validandoFoto = true;
                
                                      setState(() {});
                
                                      validandoFoto = false;
                                      
                                      /*
                
                                      ClientTypeResponse objRspValidacionFoto = await UserFormService().verificacionFotoPerfil(null,objFotoPerfilNueva);
                
                                      if(objRspValidacionFoto.succeeded) {
                                        coloresTextoRepuesta = Colors.white;
                                        coloresFondoRepuesta = Colors.green;
                                      } else {
                                        coloresTextoRepuesta = Colors.white;
                                        coloresFondoRepuesta = Colors.red;
                                      }
                
                                      Fluttertoast.showToast(
                                        msg: !objRspValidacionFoto.succeeded ? 'Debe colocar su rostro para la foto de perfil.' : objRspValidacionFoto.message,
                                        toastLength: Toast.LENGTH_LONG,
                                        gravity: ToastGravity.TOP,
                                        timeInSecForIosWeb: 5,
                                        backgroundColor: coloresFondoRepuesta,
                                        textColor: coloresTextoRepuesta,
                                        fontSize: 16.0
                                      );
                
                                      if(!objRspValidacionFoto.succeeded) {
                                        validandoFoto = false;
                                        setState(() {});
                                        return;
                                      }
                                      */
                                      
                                      rutaNuevaFotoPerfil = croppedFile.path;
                
                                      varObjetoProspectoFunc!.imagenPerfil = objFotoPerfilNueva;
                                      varObjProspecto!.imagenPerfil = objFotoPerfilNueva;
                                      
                                      setState(() {});
                                    }
                                  }
                                } catch(_) {
                                  
                                }
                                */
                
                                context.push(Rutas().rutaDatosFotoOnBoarding);
                              },
                              child: Image.asset(
                                    'assets/images/btnAgregarFotoPerfil.png',
                                    height: sizeFrmDatosPers.height * 0.35,
                                  )
                                  
                              /*
                              AvatarGlow(
                                animate: true,
                                repeat: true,
                                showTwoGlows: false,
                                glowColor: objColorsApp.naranjaIntenso,
                                endRadius: sizeFrmDatosPers.width * 0.16,
                                child: !validandoFoto ? 
                                  Image.asset(
                                    'assets/btnAgregarFotoPerfil.png',
                                    height: sizeFrmDatosPers.height * 0.35,
                                  )
                                  :
                                  SpinKitFadingCircle(
                                    size: 35,
                                    itemBuilder: (BuildContext context, int index) {
                                      return DecoratedBox(
                                        decoration: BoxDecoration(
                                          color: index.isEven
                                            ? Colors.black12
                                            : Colors.white,
                                        ),
                                      );
                                    },
                                  ),
                              ),
                              */
                            ),
                          ),
                          
                          if(rutaNuevaFotoPerfil != '')
                          Container(
                            height: sizeFrmDatosPers.height * 0.165,
                            width: sizeFrmDatosPers.width * 0.33,
                            decoration: !validandoFoto ? 
                            BoxDecoration(
                              image: DecorationImage(
                                image: FileImage(File(rutaNuevaFotoPerfil)),
                                fit: BoxFit.cover,
                              ),
                              borderRadius: BorderRadius.circular(sizeFrmDatosPers.width * 0.2),
                              border: Border.all(
                                width: 3,
                                color: objColorsApp.naranjaIntenso,
                                style: BorderStyle.solid,
                              ),
                            )
                            :
                            BoxDecoration(
                              borderRadius: BorderRadius.circular(sizeFrmDatosPers.width * 0.2),
                              border: Border.all(
                                width: 3,
                                color: objColorsApp.naranjaIntenso,
                                style: BorderStyle.solid,
                              ),
                            ),
                            child: GestureDetector(
                              onTap: () async {
                                final pickedFile = await ImagePicker().pickImage(source: ImageSource.camera);
                
                                try {
                                  if (pickedFile != null) {
                                    final croppedFile = await ImageCropper().cropImage(                                        
                                      sourcePath: pickedFile.path,
                                      compressFormat: ImageCompressFormat.png,
                                      compressQuality: 100,
                                      uiSettings: [
                                        AndroidUiSettings(
                                          hideBottomControls: true,
                                          toolbarTitle: 'Recortando',
                                          toolbarColor: Colors.deepOrange,
                                          toolbarWidgetColor: Colors.white,
                                          initAspectRatio: CropAspectRatioPreset.square,
                                          lockAspectRatio: false
                                        ),
                                        IOSUiSettings(
                                          title: 'Recortando',
                                        ),
                                        //ignore: use_build_context_synchronously
                                      ],
                                    );
                                    if (croppedFile != null) {
                                      final bytes = File(croppedFile.path).readAsBytesSync();
                                      String img64 = base64Encode(bytes);
                
                                      FotoPerfilModel objFotoPerfilNueva = FotoPerfilModel(
                                        base64: img64,
                                        extension: 'png',
                                        nombre: 'foto_perfil'
                                      );
                
                                      validandoFoto = true;
                
                                      setState(() {});
                                      /*
                
                                      ClientTypeResponse objRspValidacionFoto = await UserFormService().verificacionFotoPerfil(null,objFotoPerfilNueva);
                
                                      if(objRspValidacionFoto.succeeded) {
                                        coloresTextoRepuesta = Colors.white;
                                        coloresFondoRepuesta = Colors.green;
                                      } else {
                                        coloresTextoRepuesta = Colors.white;
                                        coloresFondoRepuesta = Colors.red;
                                      }
                
                                      Fluttertoast.showToast(
                                        msg: !objRspValidacionFoto.succeeded ? 'Debe colocar su rostro para la foto de perfil.' : objRspValidacionFoto.message,
                                        toastLength: Toast.LENGTH_LONG,
                                        gravity: ToastGravity.TOP,
                                        timeInSecForIosWeb: 5,
                                        backgroundColor: coloresFondoRepuesta,
                                        textColor: coloresTextoRepuesta,
                                        fontSize: 16.0
                                      );
                
                                      if(!objRspValidacionFoto.succeeded) {
                                        validandoFoto = false;
                                        setState(() {});
                                        return;
                                      }
                                      */
                                      
                                      rutaNuevaFotoPerfil = croppedFile.path;
                
                                      varObjetoProspectoFunc!.imagenPerfil = objFotoPerfilNueva;
                                      varObjProspecto!.imagenPerfil = objFotoPerfilNueva;
                                      validandoFoto = false;
                                      setState(() {});
                                    }
                                  }
                                } catch(_) {
                                  
                                }
                              },
                              child: validandoFoto ? SpinKitFadingCircle(
                                size: 35,
                                itemBuilder: (BuildContext context, int index) {
                                  return DecoratedBox(
                                    decoration: BoxDecoration(
                                      color: index.isEven
                                        ? Colors.black12
                                        : Colors.white,
                                    ),
                                  );
                                },
                              )
                              :
                              null
                            )
                          ),
                
                          SizedBox(height: sizeFrmDatosPers.height * 0.02,),
                
                          Container(
                            color: Colors.transparent,
                            width: sizeFrmDatosPers.width * 0.85,
                            height: sizeFrmDatosPers.height * 0.1,
                            alignment: Alignment.center,
                            child: formItemsDesign(
                              Text(
                                '# Identificación',
                                style: TextStyle(color: Colors.white, fontFamily: objFuentesDatPers.fuenteMonserate, fontSize: 18),
                              ),
                              TextFormField(
                                controller: cedulaTxt,
                                keyboardType: TextInputType.number,
                                inputFormatters: [FilteringTextInputFormatter.deny(RegExp(regexToRemoveEmoji))],
                                style: const TextStyle(color: Colors.white),
                                maxLines: 1,
                                maxLength: 10,
                                decoration: InputDecorations.authInputDecoration(
                                  esEdicion: false,
                                  varEsContrasenia: false,
                                  colorBordes: Colors.white,
                                  colorTexto: Colors.white,
                                  varTamanioIcono: 35,
                                  hintText: '',
                                  labelText: '',
                                  varOnPress: () {}
                                ),
                                onChanged: (value) async {
                                  
                                  if(value.isNotEmpty && value.length == 10) {

                                    String rst = ValidacionesUtils().validaCedula(value);

                                    if(rst != 'Ok') {
                                      showDialog(
                                        barrierDismissible: false,
                                        //ignore: use_build_context_synchronously
                                        context: context,
                                        builder: (BuildContext context) {
                                          return DialogContentEksWidget(
                                            title: 'Atención',
                                            textPrimaryButton: 'Cerrar',
                                            colorIcon: Colors.blueGrey,
                                            message: 'Cédula incorrecta',
                                            numMessageLines: 1,                                                                                    
                                            hasTwoOptions: false,
                                            onPressedPrimaryButton: () => context.pop(),
                                          );
                                        },
                                      );

                                      return;
                                    }

                                    numIdentificacionColab = value;

                                    showDialog(
                                      barrierDismissible: false,
                                      //ignore: use_build_context_synchronously
                                      context: context,
                                      builder: (BuildContext context) {
                                        return const DialogCargandoContentEksWidget(
                                          title: 'Atención',
                                          textPrimaryButton: '',
                                          colorIcon: Colors.blueGrey,
                                          message: 'Consultando sus datos',
                                          numMessageLines: 1,                                                                                    
                                          hasTwoOptions: false,
                                        );
                                      },
                                    );

                                    objEmpleadoResponseModel = await ColaboradorService().datosColaborador(value);

                                    //ignore: use_build_context_synchronously
                                    context.pop();
                                    
                                    fechaNacimiento = objEmpleadoResponseModel.data.birthday;//DateFormat('dd-MM-yyyy', 'es').format(objEmpleadoResponseModel.data.birthday);
                                    
                                    setState(() {
                                      
                                    });
                                  }

                                },
                                validator: (value) {
                                  
                                  if(value == null || value.isEmpty) {
                                    return 'Ingrese número de identificación';
                                  }

                                  if(value.length == 10) {
                                    String rst = ValidacionesUtils().validaCedula(value);

                                    if(rst != 'Ok') {
                                      return rst == 'Ok' ? null : 'Cédula inválida.';
                                    }

                                  }
                
                                  return null;
                                },
                              ),
                              1,
                              null
                            ),                
                          ),

                          SizedBox(height: sizeFrmDatosPers.height * 0.02,),
                
                          Container(
                            color: Colors.transparent,
                            width: sizeFrmDatosPers.width * 0.85,
                            height: sizeFrmDatosPers.height * 0.07,
                            child: formItemsDesign(
                              Text('Nombres',style: TextStyle(color: Colors.white, fontFamily: objFuentesDatPers.fuenteMonserate, fontSize: 18),),                              
                              TextButton(
                                style: ButtonStyle(
                                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0), side: const BorderSide(color: Colors.white)))
                                ),
                                onPressed: () async {
                                },
                                child: Text(
                                      objEmpleadoResponseModel.data.name,
                                      style: const TextStyle(color: Colors.white, fontSize: 15),
                                    ),
                              ),
                              2,
                              null
                            ),
                          ),
                
                          SizedBox(height: sizeFrmDatosPers.height * 0.02,),
                
                          Container(
                            color: Colors.transparent,
                            width: sizeFrmDatosPers.width * 0.85,
                            height: sizeFrmDatosPers.height * 0.1,
                            alignment: Alignment.center,
                            child: formItemsDesign(
                              Text(
                                'Fecha de Nacimiento',
                                style: TextStyle(color: Colors.white, fontFamily: objFuentesDatPers.fuenteMonserate, fontSize: 18),
                              ),
                              TextButton(
                                style: ButtonStyle(
                                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0), side: const BorderSide(color: Colors.white)))
                                ),
                                onPressed: () async {
                                },
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    const Text(
                                      '',
                                      style: TextStyle(color: Colors.white),
                                    ),
                                    Text(
                                      fechaNacimiento,
                                      style: const TextStyle(color: Colors.white, fontSize: 15),
                                    ),
                                    const Icon(
                                      Icons.calendar_month_outlined,
                                      color: Colors.white,
                                      size: 20,
                                    ),
                                  ],
                                ),
                              ),
                              1,
                              null
                            ),
                
                          ),
                
                          SizedBox(height: sizeFrmDatosPers.height * 0.02,),
                
                          Container(
                            color: Colors.transparent,
                            width: sizeFrmDatosPers.width * 0.85,
                            height: sizeFrmDatosPers.height * 0.07,
                            child: formItemsDesign(
                              Text('Género',style: TextStyle(color: Colors.white, fontFamily: objFuentesDatPers.fuenteMonserate, fontSize: 18),),
                              /*
                              DropdownButtonFormField<String>(
                                borderRadius: const BorderRadius.all(Radius.circular(10.0)),
                                decoration: InputDecoration(
                                  enabledBorder: const OutlineInputBorder(
                                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                                    borderSide: BorderSide(color: Colors.white,),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                    borderSide: const BorderSide(color: Colors.white,),
                                  ),
                                  labelStyle: const TextStyle(color: Colors.grey),
                                ),
                                value: objPrspValido.genero == '' ? 'S' : objPrspValido.genero,
                                dropdownColor: Colors.grey,
                                style: const TextStyle(color: Colors.white),
                                items: const [
                                  DropdownMenuItem(value: 'S', child: Text('-- Seleccione --', style: TextStyle(color: Colors.white, fontSize: 13))),
                                  DropdownMenuItem(
                                      value: 'M',
                                      child: Text(
                                        'Masculino',
                                        style: TextStyle(color: Colors.white, fontSize: 13),
                                      )),
                                  DropdownMenuItem(value: 'F', child: Text('Femenino', style: TextStyle(color: Colors.white, fontSize: 13))),
                                ],
                                onChanged: (value) {
                                  objPrspValido.genero = value.toString();
                                },
                                validator: (value) {
                                  if(value == null || value.isEmpty || value == 'S') {
                                    return 'Ingrese su género.';
                                  }
                
                                return null;
                                },
                              ),
                              */
                              TextButton(
                                style: ButtonStyle(
                                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0), side: const BorderSide(color: Colors.white)))
                                ),
                                onPressed: () async {
                                },
                                child: Text(
                                      objEmpleadoResponseModel.data.gender,
                                      style: const TextStyle(color: Colors.white, fontSize: 15),
                                    ),
                              ),
                              2,
                              null
                            ),
                          ),
                          
                          SizedBox(height: sizeFrmDatosPers.height * 0.04,),
                
                          Container(
                            color: Colors.transparent,
                            width: sizeFrmDatosPers.width * 0.85,
                            height: sizeFrmDatosPers.height * 0.15,
                            child: formItemsDesign(
                              Text('Dirección',style: TextStyle(color: Colors.white, fontFamily: objFuentesDatPers.fuenteMonserate, fontSize: 18),),
                              Container(
                                color: Colors.transparent,
                                height: sizeFrmDatosPers.height * 0.22,
                                child: TextButton(
                                  style: ButtonStyle(
                                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0), side: const BorderSide(color: Colors.white)))
                                  ),
                                  onPressed: () async {
                                  },
                                  child: Text(
                                        objEmpleadoResponseModel.data.privateStreet,
                                        style: const TextStyle(color: Colors.white, fontSize: 15),
                                      ),
                                ),
                              ),
                              
                              3,
                              null
                            ),
                              
                          ),
                          
                          SizedBox(height: sizeFrmDatosPers.height * 0.03,),

                          Container(
                            width: _widthAnimation!.value,
                            height: 80,
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(50),
                              color: Colors.orange.withOpacity(.4)
                            ),
                            child: InkWell(
                              onTap: () async {
                
                                if(!_frmState.currentState!.validate()) {
                                  return;
                                }

                                FocusScope.of(context).unfocus();

                                showDialog(
                                  barrierDismissible: false,
                                  //ignore: use_build_context_synchronously
                                  context: context,
                                  builder: (BuildContext context) {
                                    return const DialogCargandoContentEksWidget(
                                      title: 'Atención',
                                      textPrimaryButton: '',
                                      colorIcon: Colors.blueGrey,
                                      message: 'Registrando sus datos',
                                      numMessageLines: 1,                                      
                                      hasTwoOptions: false,
                                    );
                                  },
                                );
                
                                String msmFinal = '';
                                
                                //bool rsp = await ProspectoTypeService().llenaData(objPrspValido);

                                final rspReg = await ColaboradorService().registraColaborador(numIdentificacionColab, imgBase64);
                
                                Color colorResp = Colors.transparent;

                                if(rspReg != null && rspReg.result != null){
                                  msmFinal = rspReg.result!.message;
                                  colorResp = Colors.green;
                                } else {
                                  msmFinal = 'Error al intentar grabar sus datos.';
                                  colorResp = Colors.red;
                                }
                                
                                /*
                                if(rsp)
                                {
                                  //await ProspectoTypeService().registraProspecto(objPrspValido);
                                  msmFinal = rspReg.result.message;//'Registro de datos correcto !!';
                                }
                                else {
                                  msmFinal = 'Falta ingresar datos !!';
                                }
                                */
                /*
                                if(rsp) {
                                  //ignore: use_build_context_synchronously
                                  context.pop();
                                }      
                                */        

                                //ignore: use_build_context_synchronously                  
                                context.pop();
                
                                rutaNuevaFotoPerfil = '';
                                numIdentificacionColab = '';
                                cedulaTxt = TextEditingController ();
                                cedulaTxt.text = '';
                                cedulaTxt.value = const TextEditingValue(
                                  text: ''
                                );
                                
                                objEmpleadoResponseModel = EmpleadoResponseModel(
                                  code: 0,
                                  data: EmpleadoModel(
                                    birthday: '',
                                    gender: '',
                                    id: 0,
                                    name: '',
                                    privateStreet2: '',
                                    privateStreet: ''
                                  ),
                                  message: '',
                                  status: '',
                                  success: false
                                );

                                showDialog(
                                  barrierDismissible: false,
                                  //ignore: use_build_context_synchronously
                                  context: context,
                                  builder: (BuildContext context) {
                                    return DialogContentEksWidget(
                                      title: 'Atención',
                                      textPrimaryButton: 'Aceptar',
                                      colorIcon: colorResp,
                                      message: msmFinal,
                                      numMessageLines: 1,
                                      onPressedPrimaryButton: () {
                                        context.pop();
                                        context.pop();
                                        //context.push(Rutas().rutaDefault);
                                      },
                                      hasTwoOptions: false,
                                    );
                                  },
                                );
                                
                              },
                              child: Stack(
                                children: <Widget>[
                                  AnimatedBuilder(
                                    animation: _positionController!,
                                    builder: (context, child) => Positioned(
                                      left: _positionAnimation!.value,
                                      child: AnimatedBuilder(
                                        animation: _scale2Controller!,
                                        builder: (context, child) => Transform.scale(
                                          scale: _scale2Animation!.value,
                                          child: Container(
                                              width: 60,
                                              height: 60,
                                              decoration: BoxDecoration(shape: BoxShape.circle, color: objColorsApp.naranjaIntenso),
                                              child: const Icon(
                                                Icons.arrow_forward_ios,
                                                color: Colors.white,
                                              )
                                            )
                                          ),
                                      ),
                                    ),
                                  ),
                                ]
                              ),
                            ),
                          ),
                          
                          SizedBox(height: sizeFrmDatosPers.height * 0.008,),
                        ],
                      ),
                    ),
                  ),
                );
              }
            );
            
            /*
            : 
            state.isGpsEnabled && state.isScreenMapa ?
            MarcacionMapScreen(null)
            :
            const GpsErrorScreen(null);
            */
          }
        )
      ),
    );
  }
}

formItemsDesign(label, item, idForm, subItem) {
  double paddingAplica = 0;
  //double heightRow = 0;

  if (idForm == 3) {
    paddingAplica = -9;
  }
  if (idForm == 4) {
    paddingAplica = -22;
  }

  return Container(
    color: Colors.transparent,
    //height: heightRow,
    child: Padding(
      padding: const EdgeInsets.symmetric(vertical: 1, horizontal: 1),
      child: ListTile(
        leading: label,
        title: item,
        contentPadding: const EdgeInsets.symmetric(vertical: 0.0, horizontal: 0.1),
        dense: true,
        minVerticalPadding: paddingAplica,
        trailing: idForm == 4 ? subItem : null,
      )
    ),
  );
}
