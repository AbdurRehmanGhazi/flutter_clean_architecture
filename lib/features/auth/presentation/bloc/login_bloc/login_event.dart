part of 'login_bloc.dart';

@immutable
sealed class LoginEvent {}

class LoadRememberMe extends LoginEvent {}

class UserLoginEvent extends LoginEvent {
  final String mobileNumber;
  final String pin;

  UserLoginEvent({required this.mobileNumber, required this.pin});
}

class RememberToggle extends LoginEvent {
  final bool isRemember;

  RememberToggle({required this.isRemember});
}
