import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:marcacion_facial_ekuasoft_app/domain/domain.dart';
import 'package:marcacion_facial_ekuasoft_app/ui/ui.dart';

const storageLocalidad = FlutterSecureStorage();
MensajesAlertas objMensajesLocalidadService = MensajesAlertas();

class LocalidadService extends ChangeNotifier {

  final String endPointEvalCore = CadenaConexion().apiEndPointEvalCore;

  List<LocalidadType> lstLocalidades = [];
  List<LocalidadType> get listaLocalidades => lstLocalidades;
  set listaLocalidades(List<LocalidadType> valor) {
    lstLocalidades = valor;
    notifyListeners();
  }

  Future<List<LocalidadType>> obtenerLocalidadMarcacion(String numIdentificacion) async {
    try {
      var url = Uri.parse("${endPointEvalCore}Localidad/GetLocalidad?Identificacion=$numIdentificacion");
      String tokenUser = await storageLocalidad.read(key: 'jwtEnrolApp') ?? '';
      final response = await http.get(
        url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $tokenUser',
        },
      );
      final objLocalidades = LocalidadTypeResponse.fromJson(response.body);
      listaLocalidades = objLocalidades.data;
      //notifyListeners();
      return objLocalidades.data;
    } on TimeoutException catch (_) {
      Fluttertoast.showToast(
          msg: objMensajesLocalidadService.mensajeTiempoEspera,
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.TOP,
          timeInSecForIosWeb: 5,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
    } on SocketException catch (_) {
      Fluttertoast.showToast(
          msg: objMensajesLocalidadService.mensajeFallaInternet,
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.TOP,
          timeInSecForIosWeb: 5,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
    } on HttpException catch (_) {
      Fluttertoast.showToast(
          msg: objMensajesLocalidadService.mensajePeticion,
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.TOP,
          timeInSecForIosWeb: 5,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
    } on FormatException catch (_) {
      Fluttertoast.showToast(
          msg: objMensajesLocalidadService.mensajeErrorFormato,
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.TOP,
          timeInSecForIosWeb: 5,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
    }
    return [];
  }


}