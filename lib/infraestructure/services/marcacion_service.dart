
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:marcacion_facial_ekuasoft_app/config/config.dart';

const storage = FlutterSecureStorage();

class MarcacionService {

  Environments objEnvironments = Environments();

  Future<String> registraMarcacion(String marcacion) async {
    String rsp = '';

    String conexionValida = await ValidaConexionService().validaConexionInternet();

    if(conexionValida == 'NI') {
      storage.write(key: KeysApp().registraAsistenciaKey, value: marcacion);
    }
    else {

    }

    return rsp;
  }

  Future<String> registraMarcacionMemory() async {
    String rsp = '';

    String conexionValida = await ValidaConexionService().validaConexionInternet();
    String dataMemory = await storage.read(key: KeysApp().registraAsistenciaKey) ?? '';

    if(conexionValida != 'NI' && dataMemory.isNotEmpty) {
      storage.write(key: KeysApp().registraAsistenciaKey, value: '');
    }

    return rsp;
  }

}