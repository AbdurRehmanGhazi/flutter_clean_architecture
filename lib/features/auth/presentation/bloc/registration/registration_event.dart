part of 'registration_bloc.dart';

@immutable
sealed class RegistrationEvent {}

class UserRegistrationEvent extends RegistrationEvent {
  final String phone;
  final String code;
  final String name;

  UserRegistrationEvent({
    required this.phone,
    required this.code,
    required this.name,
  });
}