
part of 'suscripcion_bloc.dart';

class SuscripcionState extends Equatable {

  final String direccionUser;
  final String rutaFotoUser;
  final String rutaFotoUserTmp;

  const SuscripcionState(
    {
      direccionUser = '',
      rutaFotoUser = '',
      rutaFotoUserTmp = '',
    } 
  ) : direccionUser = direccionUser ?? '',
      rutaFotoUser = rutaFotoUser ?? '',
      rutaFotoUserTmp = rutaFotoUserTmp ?? '';
  

  SuscripcionState copyWith({
    String? direccionUser,
    String? rutaFotoUser,
    String? rutaFotoUserTmp
  }) 
  => SuscripcionState(
    direccionUser: direccionUser ?? this.direccionUser,
    rutaFotoUser: rutaFotoUser ?? this.rutaFotoUser,
    rutaFotoUserTmp: rutaFotoUserTmp ?? this.rutaFotoUserTmp
  );

  @override
  List<Object> get props => [direccionUser,rutaFotoUser,rutaFotoUserTmp];

  Future<String> waitCarga() async {
    
    return await Future.delayed(
      const Duration(milliseconds: 2500), 
        () => 'ok'
      ); 
  }
}

