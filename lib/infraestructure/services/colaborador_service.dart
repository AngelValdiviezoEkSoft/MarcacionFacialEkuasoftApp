import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:marcacion_facial_ekuasoft_app/config/enrutador/enrutador.dart';
import 'package:marcacion_facial_ekuasoft_app/domain/domain.dart';

const storageCol = FlutterSecureStorage();
 
class ColaboradorService {

  Future<EmpleadoResponseModel> datosColaborador(String identificacion) async {

    final resp = await EnrutadorColaborador().getDatosColaborador(identificacion);

    final oResp = EmpleadoResponseModel.fromJson(resp);

    return oResp;
  }

  Future<RegistroEmpleadoResponseModel?> registraColaborador(String identificacion, String foto) async {

    final resp = await EnrutadorColaborador().saveDatosColaborador(identificacion, foto);

    final oResp = RegistroEmpleadoResponseModel.fromJson(resp);

    return oResp;
  }

/*
  Future<String> registraMarcacion(String marcacion) async {
    String rsp = '';

    String conexionValida = await ValidaConexionService().validaConexionInternet();

    if(conexionValida == 'NI') {
      storageCol.write(key: KeysApp().registraAsistenciaKey, value: marcacion);
    }
    else {

    }

    return rsp;
  }

  Future<String> registraMarcacionMemory() async {
    String rsp = '';

    String conexionValida = await ValidaConexionService().validaConexionInternet();
    String dataMemory = await storageCol.read(key: KeysApp().registraAsistenciaKey) ?? '';

    if(conexionValida != 'NI' && dataMemory.isNotEmpty) {
      storageCol.write(key: KeysApp().registraAsistenciaKey, value: '');
    }

    return rsp;
  }
*/
}