part of 'otp_verification_bloc.dart';

@immutable
sealed class OtpVerificationEvent {}

class OTPVerificationEvent extends OtpVerificationEvent {
  final String otp;

  OTPVerificationEvent({required this.otp});
}

class OTPResendEvent extends OtpVerificationEvent {
  final String phone;

  OTPResendEvent({required this.phone});
}