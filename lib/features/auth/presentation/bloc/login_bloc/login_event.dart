part of 'login_bloc.dart';

@immutable
sealed class LoginEvent {}


class UserLoginEvent extends LoginEvent {
  final String mobileNumber;
  final String pin;

  UserLoginEvent({required this.mobileNumber, required this.pin});
}
