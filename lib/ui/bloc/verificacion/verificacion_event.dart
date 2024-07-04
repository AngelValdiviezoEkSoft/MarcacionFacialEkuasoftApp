
part of 'verificacion_bloc.dart';

int obtieneTokenUsuario = 0;

abstract class VerificacionEvent extends Equatable {
  const VerificacionEvent();

  @override
  List<Object> get props => [];
}

class OnNewAutenticacionEvent extends VerificacionEvent {
  final int getTokenUser;
  const OnNewAutenticacionEvent(this.getTokenUser);
}

class GetNewAutenticacionEvent extends VerificacionEvent {
  //final UsuarioType objUsEv;
  const GetNewAutenticacionEvent();
}

setTokenAutenticacion(int value) {
  obtieneTokenUsuario = value;
}