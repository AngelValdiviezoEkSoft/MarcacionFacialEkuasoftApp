
import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:marcacion_facial_ekuasoft_app/config/config.dart';
import 'package:marcacion_facial_ekuasoft_app/domain/domain.dart';
//import 'package:platform_device_id/platform_device_id.dart';
import 'package:shared_preferences/shared_preferences.dart';

const storageProspecto = FlutterSecureStorage();
MensajesAlertas objMensajesProspectoService = MensajesAlertas();
ResponseValidation objResponseValidationService = ResponseValidation();

class ProspectoTypeService extends ChangeNotifier{

  final String endPoint = CadenaConexion().apiEndpoint;

  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  ProspectoType? objRspProsp;
  ProspectoTypeResponse? varObjTipoRsp;
  ClientTypeResponse? varObjRspRegistro;
  String varPassWordActual = '';
  String varPassWord = '';
  String varPassWordConfirm = '';

  bool isOscuredConfirm = true;
  bool get varIsOscuredConfirm => isOscuredConfirm;
  set varIsOscuredConfirm (bool value){
    isOscuredConfirm = value;
    notifyListeners();
  }

  bool tieneUbicacion = false;
  bool get varTieneUbicacion => tieneUbicacion;
  set varTieneUbicacion(bool value){
    tieneUbicacion = value;
    notifyListeners();
  }
  
  String varDireccion = '';
  String varCorreo = '';
  String varUbicacionLat = '';
  String varUbicacionLong = '';

  String cedulaSelect = 'assets/BtnCedula_Gris.png';
  String pasaporteSelect = 'assets/BtnPasaporte_Blanco.png';

  String get varCedulaSelect => cedulaSelect;
  set varCedulaSelect (String value){
    cedulaSelect = value;
    notifyListeners();
  }

  String get varPasaporteSelect => pasaporteSelect;
  set varPasaporteSelect (String value){
    pasaporteSelect = value;
    notifyListeners();
  }

  String varCedula = '';
  String varPasaporte = '';

  bool isOscuredAntigua = true;
  bool get varIsOscuredAntigua => isOscuredAntigua;
  set varIsOscuredAntigua (bool value){
    isOscuredAntigua = value;
    notifyListeners();
  }

  bool isOscured = true;
  bool get varIsOscured => isOscured;
  set varIsOscured (bool value){
    isOscured = value;
    notifyListeners();
  }

  //ProspectoTypeService(String tipoIdent, String numIdent){
  ProspectoTypeService(){
    //getProspecto(tipoIdent, numIdent);
  }


  bool isValidFormPasword(){
    if(varPassWord == '' || varPassWordConfirm == ''){
      return false;
    }
    else{
      if(varPassWord != varPassWordConfirm){
        return false;
      }
      else {
        return true;
      }
    }
  }

  bool isValidForm(){
    return formKey.currentState?.validate() ?? false;
  }

  bool isParamsForm(){
    String pattern = r'^(?=.*\d)(?=.*[\u0021-\u002b\u003c-\u0040])(?=.*[A-Z])(?=.*[a-z])\S{10,20}$';
    RegExp regExp  = RegExp(pattern);
    return regExp.hasMatch(varPassWord) ? true : false;
  }

  String mensajeError(){
    String pattern = r'^(?=.*\d)(?=.*[\u0021-\u002b\u003c-\u0040])(?=.*[A-Z])(?=.*[a-z])\S{10,20}$';
    RegExp regExp  = RegExp(pattern);
    String varMensajeValidacion = regExp.hasMatch(varPassWord) ? '' : 'Clave no cumple con los parámetros solicitados';
    
    if(varPassWord != varPassWordConfirm){
      varMensajeValidacion = ' Las contraseñas deben coincidir';
    }
    return varMensajeValidacion;
  }


 getProspecto(String tipoIdent,String numIdent) async {
    try{

      String tipoProspecto = await storageProspecto.read(key: 'tipoCliente') ?? '';
      final baseURL = '${endPoint}Prospectos/$tipoProspecto/$tipoIdent/$numIdent';

      final varResponse = await http.get(Uri.parse(baseURL));
      if(varResponse.statusCode != 200) return null;

      final prospRsp = ProspectoTypeResponse.fromJson(varResponse.body);
      varObjTipoRsp = prospRsp;
      if(prospRsp.succeeded && varObjTipoRsp!.data != null) {
        
        varObjTipoRsp!.data!.tipoCliente = tipoProspecto;

        if(prospRsp.statusCode == objResponseValidationService.responseExitoGet && prospRsp.succeeded){
          objRspProsp = prospRsp.data;
        }
      } else {
        prospRsp.succeeded = false;
        varObjTipoRsp!.succeeded = false;
      }

      
      notifyListeners();
    }
    on SocketException catch (_) {
      Fluttertoast.showToast(
        msg: objMensajesProspectoService.mensajeFallaInternet,
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.TOP,
        timeInSecForIosWeb: 5,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0
      );
          
    }
    /*
    
    Future.microtask(() => 
                        Navigator.of(context, rootNavigator: true).pushReplacement(
                          CupertinoPageRoute<bool>(
                            fullscreenDialog: true,
                            builder: (BuildContext context) => ConexionInternetScreen(),
                          ),
                        )
                      );
    
     */
  }

  Future<bool> llenaData(ProspectoType objPrpTp) async {
    bool frmValido = true;

    String pattern = r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regExp  = RegExp(pattern);
/*
    if(!regExp.hasMatch(objPrpTp.email)) {
      frmValido = false;
    }
    */
    
/*
    SharedPreferences prefs = await SharedPreferences.getInstance();

    final coordElegidas = prefs.getString("coordenadasIngreso");
    List<String> latLng = coordElegidas!.split(',');

    double latitude = double.parse(latLng[0]);
    double longitude = double.parse(latLng[1]);

    objPrpTp.latitud = latitude;
    objPrpTp.longitud = longitude;

    if(objPrpTp.fechaNacimiento.trim() == '' || objPrpTp.genero.trim() == null || objPrpTp.genero.trim() == 'S' || objPrpTp.direccion.trim() == null || objPrpTp.direccion.trim() == ''  || objPrpTp.email.trim() == '' || objPrpTp.longitud == 0 || objPrpTp.longitud == 0) {
      frmValido = false;
    }
    */

    if(objPrpTp.fechaNacimiento.trim() == '' || objPrpTp.genero.trim() == null || objPrpTp.genero.trim() == 'S' || objPrpTp.direccion.trim() == null || objPrpTp.direccion.trim() == '') {
      frmValido = false;
    }

    return frmValido;
  }

  registraProspecto(ProspectoType objLlenoProsp) async {
    String fechaNacimientoProsp = DateFormat('yyyy-MM-dd').format(objLlenoProsp.fechaNacDate);

    SharedPreferences prefs = await SharedPreferences.getInstance();
    final coordElegidas = prefs.getString("coordenadasIngreso");
    List<String> latLng = coordElegidas!.split(',');

    double latitude = double.parse(latLng[0]);
    double longitude = double.parse(latLng[1]);

    objLlenoProsp.latitud = latitude;
    objLlenoProsp.longitud = longitude;

    String? deviceId = '';//await PlatformDeviceId.getDeviceId;
    final baseURL = '${endPoint}Clientes/CreateCliente';

    String latitudString = objLlenoProsp.latitud.toString();
    String longitudString = objLlenoProsp.longitud.toString();

    final response = await http.post(
        Uri.parse(baseURL),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: jsonEncode(<String, dynamic>
          {
            "tipoidentificacion": objLlenoProsp.tipoIdentificacion,
            "identificacion": objLlenoProsp.identificacion,
            "genero": objLlenoProsp.genero,
            "latitud": latitudString,
            "longitud": longitudString,
            "direccion": objLlenoProsp.direccion,
            "fechaNacimiento": fechaNacimientoProsp,
            "correo": objLlenoProsp.email,
            "password": varPassWord,
            "dispositivoId": deviceId ?? '',
            "imagenPerfil": {
              "base64": objLlenoProsp.imagenPerfil?.base64 ?? '',
              "nombre": objLlenoProsp.imagenPerfil?.nombre ?? '',
              "extension": objLlenoProsp.imagenPerfil?.extension ?? '',
            },
            "tipoCliente": objLlenoProsp.tipoCliente,
          }
        ),
      );

      final prospRsp = ClientTypeResponse.fromJson(response.body);//aquí va a variar el objeto de respuesta cuando se cree el token por el api
      varObjRspRegistro = prospRsp;
    
    notifyListeners();
  }

}
