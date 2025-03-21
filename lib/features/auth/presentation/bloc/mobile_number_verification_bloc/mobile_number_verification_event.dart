part of 'mobile_number_verification_bloc.dart';

@immutable
sealed class MobileNumberVerificationEvent {}

class VerifyMobileNumberEvent extends MobileNumberVerificationEvent {
  final String mobileNumber;

  VerifyMobileNumberEvent({required this.mobileNumber});
}
