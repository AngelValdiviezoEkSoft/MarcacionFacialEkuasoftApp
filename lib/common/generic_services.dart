import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:marcacion_facial_ekuasoft_app/config/config.dart';

class GenericServices {
  
  final storage = const FlutterSecureStorage();
  
  consumoRuta(
    String tipoMetodo,
    Uri ruta,
    Map<String, String>? header,
    Object? body,
  ) async {
    if (tipoMetodo == ReqType.GET) {
      final resp = await http.get(ruta, headers: header!);
      var rsp = resp.body;
      return rsp;
    } else if (tipoMetodo == ReqType.POST) {
      final resp = await http.post(ruta, headers: header, body: body);
      var rsp = resp.body;
      return rsp;
    }
  }

  Future<String> consumoRutas(
    String tipoMetodo, 
    Uri ruta,
    Map<String, String>? header, 
    Object? body) async {
    
    final http.Response resp;

    if(header != null) {
      if (tipoMetodo == ReqType.GET) {
        resp = await http.get(ruta, headers: header);
      } else {
        resp = await http.post(ruta, headers: header, body: body);
      }
    }
    else {
      if (tipoMetodo == ReqType.GET) {
        resp = await http.get(ruta);
      } else {
        resp = await http.post(ruta, body: body);
      }
    }
    
    final decodedResp = json.decode(utf8.decode(resp.bodyBytes));
    
    return jsonEncode(decodedResp);

  }

}
