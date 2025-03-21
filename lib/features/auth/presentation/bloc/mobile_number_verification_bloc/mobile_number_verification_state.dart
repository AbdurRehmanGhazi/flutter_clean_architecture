part of 'mobile_number_verification_bloc.dart';

@immutable
sealed class MobileNumberVerificationState {
  const MobileNumberVerificationState();
}

final class AuthInitial extends MobileNumberVerificationState {}

final class AuthLoading extends MobileNumberVerificationState {
  final bool isLoading;

  const AuthLoading({
    this.isLoading = false,
  });
}

final class AuthFailure extends MobileNumberVerificationState {
  final String message;

  const AuthFailure(this.message);
}

final class MobileNumberVerified extends MobileNumberVerificationState {
  final MobileNumberVerificationResponse response;

  const MobileNumberVerified(this.response);
}