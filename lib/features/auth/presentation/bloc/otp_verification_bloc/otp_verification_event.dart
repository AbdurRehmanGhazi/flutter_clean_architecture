part of 'otp_verification_bloc.dart';

enum OtpVerificationType { registration, resetPassword, twoStep }

@immutable
sealed class OtpVerificationEvent {}

class OTPVerificationEvent extends OtpVerificationEvent {
  final String otp;
  final OtpVerificationType type;

  OTPVerificationEvent({required this.otp, required this.type});
}

class OTPResendEvent extends OtpVerificationEvent {
  final String phone;
  final OtpVerificationType type;

  OTPResendEvent({required this.phone, required this.type});
}