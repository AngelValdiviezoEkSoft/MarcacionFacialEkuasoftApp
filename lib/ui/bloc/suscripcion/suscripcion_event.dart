part of 'suscripcion_bloc.dart';

abstract class SuscripcionEvent extends Equatable {
  const SuscripcionEvent();

  @override
  List<Object> get props => [];
}

class OnNewSucripcionDireccion extends SuscripcionEvent {
  final String direccionUsuario;
  const OnNewSucripcionDireccion(this.direccionUsuario);
}

class OnNewSucripcionRutaFoto extends SuscripcionEvent {
  final String rutaFotoUser;
  const OnNewSucripcionRutaFoto(this.rutaFotoUser);
}

class OnNewSucripcionRutaFotoTmp extends SuscripcionEvent {
  final String rutaFotoUserTmp;
  const OnNewSucripcionRutaFotoTmp(this.rutaFotoUserTmp);
}