part of 'verificacion_bloc.dart';

//ignore: must_be_immutable
class VerificacionState extends Equatable {

  final int varObtieneToken;
  
  VerificacionState(
  {
    varObtieneToken = 0
  }) : varObtieneToken = varObtieneToken ?? 0;
  

  VerificacionState copyWith({
    int? getToken
  }) 
  => VerificacionState(
    varObtieneToken: getToken ?? varObtieneToken
  );

  Future<String> readToken() async {
    return '';
    /*
    try{
      
      var connectivityResult = await (Connectivity().checkConnectivity());
    
      if (connectivityResult != ConnectivityResult.mobile && connectivityResult != ConnectivityResult.wifi) {
        return 'NI';
      }

      return await storage.read(key: 'jwtEnrolApp') ?? ''; 
    }
    catch(ex) {
      return '';
    }
    */
  }

  @override
  List<Object> get props => [varObtieneToken];
}
