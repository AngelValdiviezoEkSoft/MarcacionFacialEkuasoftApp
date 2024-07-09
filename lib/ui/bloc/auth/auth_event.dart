part of 'auth_bloc.dart';

/*
sealed class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object> get props => [];
}
*/

abstract class AuthEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class AppStarted extends AuthEvent {}

class SubmitLicenseKey extends AuthEvent {
  final String licenseKey;

  SubmitLicenseKey(this.licenseKey);

  @override
  List<Object> get props => [licenseKey];
}

class SubmitPin extends AuthEvent {
  final String pin;

  SubmitPin(this.pin);

  @override
  List<Object> get props => [pin];
}

class ConfirmPin extends AuthEvent {
  final String pin;

  ConfirmPin(this.pin);

  @override
  List<Object> get props => [pin];
}

class SubmitUsername extends AuthEvent {
  final String username;

  SubmitUsername(this.username);

  @override
  List<Object> get props => [username];
}
