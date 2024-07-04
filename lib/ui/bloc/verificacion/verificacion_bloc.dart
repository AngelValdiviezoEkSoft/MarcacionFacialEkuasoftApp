
import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
//import 'package:local_auth/local_auth.dart';
//import 'package:connectivity_plus/connectivity_plus.dart';

part 'verificacion_event.dart';
part 'verificacion_state.dart';

const storage = FlutterSecureStorage();

class VerificacionBloc extends Bloc<VerificacionEvent, VerificacionState> {
  int obtieneToken = 0;

  bool tieneFeatureNotificacion = false;

  VerificacionBloc() : super(VerificacionState(varObtieneToken: 0)) {
    on<OnNewAutenticacionEvent>(_onReInitPosition);
    on<GetNewAutenticacionEvent>(_onNewUser);
  }

  void _onReInitPosition( OnNewAutenticacionEvent event, Emitter<VerificacionState> emit ) {
    emit( state.copyWith( getToken: obtieneToken ) );
  }

  void _onNewUser( GetNewAutenticacionEvent event, Emitter<VerificacionState> emit ) {
    emit( state.copyWith( getToken: obtieneToken ) );
  }

  void getPosicion() {
    //PosicionInicial 
    add(OnNewAutenticacionEvent(obtieneToken));
  }

  void setInicicaSesion(int obtuvoToken) {
    obtieneToken = obtuvoToken;
    add(OnNewAutenticacionEvent(obtuvoToken));
  }

}
