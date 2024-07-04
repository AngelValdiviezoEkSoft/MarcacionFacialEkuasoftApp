//import 'package:connectivity_plus/connectivity_plus.dart';

class ValidaConexionService {
  
  Future<String> validaConexionInternet() async {
    String rsp = '';
    /*
    try{
      
      var connectivityResult = await (Connectivity().checkConnectivity());
    
      if (connectivityResult != ConnectivityResult.mobile && connectivityResult != ConnectivityResult.wifi) {
        rsp = 'NI';
      }
    }
    catch(_){

    }
    */
    return rsp;
  }
}