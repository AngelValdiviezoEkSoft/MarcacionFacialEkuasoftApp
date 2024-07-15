part of 'auth_bloc.dart';

/*
sealed class AuthState extends Equatable {
  const AuthState();
  
  @override
  List<Object> get props => [];
}

final class AuthInitial extends AuthState {}
*/


abstract class AuthState extends Equatable {
  @override
  List<Object> get props => [];
}

class AuthInitial extends AuthState {}

class AuthAuthenticated extends AuthState {}

class AuthUnauthenticated extends AuthState {}

class AuthNoInternet extends AuthState {}

class AuthGpsFake extends AuthState {}

class ValidLicenseKey extends AuthState {}

class InvalidLicenseKey extends AuthState {}

class PinCompleted extends AuthState {}

class PinSubmitted extends AuthState {}

class InvalidPin extends AuthState {}

class ValidPin extends AuthState {}

class AuthRegistered extends AuthState {}

class AuthError extends AuthState {
  final String message;

  AuthError(this.message);

  @override
  List<Object> get props => [message];
}
