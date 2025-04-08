part of 'login_bloc.dart';

class LoginState {
  final bool isRemember;
  LoginState({required this.isRemember});
}

final class LoginInitial extends LoginState {
  LoginInitial({required super.isRemember});
}


final class LoginLoading extends LoginState {
  final bool isLoading;

  LoginLoading({this.isLoading = false, required super.isRemember});
}

final class LoginFailure extends LoginState {
  final String message;

  LoginFailure(this.message, {required super.isRemember});
}

final class LoginSuccess extends LoginState {
  final LoginResponse loginResponse;

  LoginSuccess(this.loginResponse, {required super.isRemember});
}
