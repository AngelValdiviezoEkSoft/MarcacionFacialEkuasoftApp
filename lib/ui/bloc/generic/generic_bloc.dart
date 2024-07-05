import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'generic_event.dart';
part 'generic_state.dart';

class GenericBloc extends Bloc<GenericEvent, GenericState> { 
  int positionMenu = 0;
  int positionFormaPago = 0;
  double coordenadasMapa = 0;
  double radioMarcacion = 0;
  String formaPago = '';
  String localidadId = '';
  String idFormaPago = '';


  GenericBloc() : super(const GenericState(positionMenu: 0, positionFormaPago: 0, coordenadasMapa: 0.0, radioMarcacion: 0.0,formaPago: '',localidadId: '', idFormaPago: '')) {
    on<OnNewPositionEvent>(_onReInitPosition);
    on<OnNewCoordenadasPositionEvent>(_onReInitPositionMapa);
    on<OnNewFormaPagoEvent>(_onCambioFormaPago);
    on<OnNewRadioMarcacionEvent>(_onCambioRadio);//_onCambioLocalidad
    on<OnNewLocalidadMarcacionEvent>(_onCambioLocalidad);//_onCambioLocalidad
    on<OnNewIdFormaPagoEvent>(_onCambioIdFormaPago);//_onCambioLocalidad  _onInitPositionFormaPago
    on<OnNewPositionFormaPagoEvent>(_onInitPositionFormaPago);//_onCambioLocalidad  
    //_init();
  }

  Future<void> init() async {
    add( OnNewPositionEvent(
       positionMenu
    ));
    add( OnNewCoordenadasPositionEvent(
       coordenadasMapa
    ));
    add(OnNewFormaPagoEvent(
      formaPago
    ));
    add(OnNewRadioMarcacionEvent(
      radioMarcacion
    ));
    add(OnNewLocalidadMarcacionEvent(
      localidadId
    ));
    add(OnNewIdFormaPagoEvent(
      idFormaPago
    ));
    add(OnNewPositionFormaPagoEvent(
      positionFormaPago
    ));
  }

  void _onReInitPosition( OnNewPositionEvent event, Emitter<GenericState> emit ) {
    emit( state.copyWith( positionMenu: positionMenu ) );

  }

  void _onReInitPositionMapa( OnNewCoordenadasPositionEvent event, Emitter<GenericState> emit ) {
    emit( state.copyWith( coordenadasMapa: coordenadasMapa ) );
  }

  void _onCambioFormaPago( OnNewFormaPagoEvent event, Emitter<GenericState> emit ) {
    emit( state.copyWith( formaPago: formaPago ) );
  }

  void _onCambioRadio( OnNewRadioMarcacionEvent event, Emitter<GenericState> emit ) {
    emit( state.copyWith( radioMarcacion: radioMarcacion ) );
  }

  void _onCambioIdFormaPago( OnNewIdFormaPagoEvent event, Emitter<GenericState> emit ) {
    emit( state.copyWith( idFormaPago: idFormaPago ) );
  }

  void _onCambioLocalidad( OnNewLocalidadMarcacionEvent event, Emitter<GenericState> emit ) {
    emit( state.copyWith( localidadId: localidadId ) );
  }

  void _onInitPositionFormaPago( OnNewPositionFormaPagoEvent event, Emitter<GenericState> emit ) {
    emit( state.copyWith( positionFormaPago: positionFormaPago ) );
  }

  void setPosicionFormaPago(int varPositionFormaPago) {
    positionFormaPago = varPositionFormaPago;
    add(OnNewPositionFormaPagoEvent(varPositionFormaPago));
  }

  void getPosicion() {
    add(OnNewPositionEvent(positionMenu));
  }

  void setPosicion(int posicionMenu) {
    positionMenu = posicionMenu;
    add(OnNewPositionEvent(posicionMenu));
  }

  void setPosicionMapa(double coordenadasMapas) {
    coordenadasMapa = coordenadasMapas;
    add(OnNewCoordenadasPositionEvent(coordenadasMapas));
  }

  void setFormaPago(String formaPagos) {
    formaPago = formaPagos;
    add(OnNewFormaPagoEvent(formaPagos));
  }

  void setRadioMarcacion(double radioMarcaciones) {
    radioMarcacion = radioMarcaciones;
    add(OnNewRadioMarcacionEvent(radioMarcaciones));
  }

  //OnNewLocalidadMarcacionEvent
  void setLocalidadId(String localidadIdCambiable) {
    localidadId = localidadIdCambiable;
    add(OnNewLocalidadMarcacionEvent(localidadIdCambiable));
  }

  void setIdFormaPago(String idFormaPagos) {
    idFormaPago = idFormaPagos;
    add(OnNewIdFormaPagoEvent(idFormaPagos));
  }

  @override
  //ignore: unnecessary_overrides
  Future<void> close() {
    return super.close();
  }

}

 