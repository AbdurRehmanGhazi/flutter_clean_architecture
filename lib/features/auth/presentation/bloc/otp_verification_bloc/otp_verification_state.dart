part of 'otp_verification_bloc.dart';

@immutable
sealed class OtpVerificationState {}

final class OtpVerificationInitial extends OtpVerificationState {}

final class OtpVerificationLoading extends OtpVerificationState {
  final bool isLoading;

  OtpVerificationLoading({
    this.isLoading = false,
  });
}

final class OtResendLoading extends OtpVerificationState {
  final bool isLoading;

  OtResendLoading({
    this.isLoading = false,
  });
}

final class OtpVerificationFailure extends OtpVerificationState {
  final String message;

  OtpVerificationFailure(this.message);
}

final class OtpVerificationSuccess extends OtpVerificationState {
  final dynamic response;

  OtpVerificationSuccess(this.response);
}

final class OtpResendSuccess extends OtpVerificationState {
  final OtpResendResponse model;

  OtpResendSuccess(this.model);
}