part of 'registration_bloc.dart';

@immutable
sealed class RegistrationState {}

final class RegistrationInitial extends RegistrationState {}

final class RegistrationLoading extends RegistrationState {
  final bool isLoading;

  RegistrationLoading({this.isLoading = false});
}

final class RegistrationFailure extends RegistrationState {
  final String message;

  RegistrationFailure(this.message);
}

final class RegistrationSuccess extends RegistrationState {
  final RegistrationResponse model;

  RegistrationSuccess(this.model);
}