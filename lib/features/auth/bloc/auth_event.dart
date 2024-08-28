part of 'auth_bloc.dart';

@immutable
sealed class AuthEvent {}

class AuthenticationEvent extends AuthEvent {
  final AuthType authType;
  final String email;
  final String pass;

  AuthenticationEvent({required this.authType, required this.email, required this.pass});
}
