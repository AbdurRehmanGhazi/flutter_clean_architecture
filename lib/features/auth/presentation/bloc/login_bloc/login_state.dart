part of 'login_bloc.dart';

@immutable
sealed class LoginState {}

final class LoginInitial extends LoginState {}


final class LoginLoading extends LoginState {
  final bool isLoading;

  LoginLoading({this.isLoading = false});
}

final class LoginFailure extends LoginState {
  final String message;

  LoginFailure(this.message);
}

final class LoginSuccess extends LoginState {
  final LoginResponse loginResponse;

  LoginSuccess(this.loginResponse);
}