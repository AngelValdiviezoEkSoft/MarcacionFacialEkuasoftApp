import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'suscripcion_event.dart';
part 'suscripcion_state.dart';

class SuscripcionBloc extends Bloc<SuscripcionEvent, SuscripcionState> {

  String direccionUser = '';
  String rutaFotoUser = '';
  String rutaFotoUserTmp = '';

  SuscripcionBloc() : super(const SuscripcionState(direccionUser: '', rutaFotoUser: '')) {
    on<OnNewSucripcionDireccion>(_onReInitPosition);
    on<OnNewSucripcionRutaFoto>(_onReInitRutaFoto);
    on<OnNewSucripcionRutaFotoTmp>(_onReInitRutaFotoTmp);
  }

  Future<void> init() async {
    add(OnNewSucripcionDireccion(
      direccionUser
    ));
    add(OnNewSucripcionRutaFoto(
      rutaFotoUser
    ));
    add(OnNewSucripcionRutaFotoTmp(
      rutaFotoUserTmp
    ));
  }

  void _onReInitPosition( OnNewSucripcionDireccion event, Emitter<SuscripcionState> emit ) {
    emit( state.copyWith(direccionUser: direccionUser ) );
  }

  void _onReInitRutaFoto( OnNewSucripcionRutaFoto event, Emitter<SuscripcionState> emit ) {
    emit( state.copyWith(rutaFotoUser: rutaFotoUser ) );
  }

  void _onReInitRutaFotoTmp( OnNewSucripcionRutaFotoTmp event, Emitter<SuscripcionState> emit ) {
    emit( state.copyWith(rutaFotoUserTmp: rutaFotoUserTmp ) );
  }

  void setDireccionUsuario(String varDireccionUser) {
    direccionUser = varDireccionUser;
    add(OnNewSucripcionDireccion(direccionUser));
  }

  void setRutaFoto(String varRutaFotoUser) {
    rutaFotoUser = varRutaFotoUser;
    add(OnNewSucripcionRutaFoto(rutaFotoUser));
  }

  void setRutaFotoTmp(String varRutaFotoUserTmp) {
    rutaFotoUserTmp = varRutaFotoUserTmp;
    add(OnNewSucripcionRutaFotoTmp(rutaFotoUserTmp));
  }

  @override
  //ignore: unnecessary_overrides
  Future<void> close() {
    return super.close();
  }
}