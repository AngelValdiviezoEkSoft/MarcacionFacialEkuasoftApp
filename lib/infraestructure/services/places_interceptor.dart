import 'package:dio/dio.dart';


class PlacesInterceptor extends Interceptor {
  
  //final accessToken = 'pk.eyJ1Ijoia2xlcml0aCIsImEiOiJja3gzdGVoNmMxdjBpMnVxM251ejcwdXhpIn0.KvaIQqpWzyGy2Nt3C4QUgg';
  final accessToken = 'pk.eyJ1IjoiYXZhbGRpdmllem85NCIsImEiOiJjbDhrczc1MTIwODdmM3dwajdrMnpwb3hmIn0.HueI_qyGT-wAhhaY0DF0cA';
  //pk.eyJ1IjoiYXZhbGRpdmllem85NCIsImEiOiJjbDhrczc1MTIwODdmM3dwajdrMnpwb3hmIn0.HueI_qyGT-wAhhaY0DF0cA
  //pk.eyJ1IjoiYXZhbGRpdmllem85NCIsImEiOiJjbDhrczc1MTIwODdmM3dwajdrMnpwb3hmIn0.HueI_qyGT-wAhhaY0DF0cA

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    options.queryParameters.addAll({
      'access_token': accessToken,
      'language': 'es',
    });
    
    super.onRequest(options, handler);
  }

}
