import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:marcacion_facial_ekuasoft_app/common/common.dart';
import 'package:marcacion_facial_ekuasoft_app/config/config.dart';

class EnrutadorColaborador extends ChangeNotifier {
  final env = EnvironmentsProd();
  final AuthType authType = AuthType();
  final ContType contType = ContType();

  Future getDatosColaborador(String identificador) async {

    final body = {
      "jsonrpc": "2.0",
      "params": {
        "db": "local_test_17",
        "login": "user_api@odoo.com",
        "password": "admin",
        "identification": identificador
      }
    };

    String rutaCompuesta = '${env.apiEndpoint}ek_hr_facial_recognition/employee';

    final rutaCompleta = GenericUri().buildUri(rutaCompuesta);

    final resp = await GenericServices().consumoRutas(
      ReqType.POST,
      rutaCompleta,
      {
        ...authType.authBasic,
        ...contType.contentType,
      },
      json.encode(body)
    );

    return resp;
  }

  Future saveDatosColaborador(String identificador, String foto) async {

    final body = {
      "jsonrpc": "2.0",
      "params": {
        "db": "local_test_17",
        "login": "user_api@odoo.com",
        "password": "admin",
        "identification": identificador,
        "image": foto 
      }
    };
    
    String rutaCompuesta = '${env.apiEndpoint}ek_hr_facial_recognition/register_user';

    final rutaCompleta = GenericUri().buildUri(rutaCompuesta);

    final resp = await GenericServices().consumoRutas(
      ReqType.POST,
      rutaCompleta,
      {
        ...authType.authBasic,
        ...contType.contentType,
      },
      json.encode(body)
    );
    
    return resp;
  }

}