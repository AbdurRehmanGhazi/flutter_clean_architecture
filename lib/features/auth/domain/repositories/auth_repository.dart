import 'package:fpdart/fpdart.dart';
import '../entities/login_response.dart';
import '../entities/mobile_number_verification_response.dart';
import '../entities/otp_resend_response.dart';
import '../entities/registration_response.dart';
import '../../../../core/error/failures.dart';

abstract interface class AuthRepository {
  Future<Either<Failure, MobileNumberVerificationResponse>> mobileNumberVerificationRequest({
    required String phone,
  });

  Future<Either<Failure, String>> otpVerificationRequest({
    required String phone,
    required String otp,
  });

  Future<Either<Failure, OtpResendResponse>> otpResendRequest({
    required String phone,
  });

  Future<Either<Failure, RegistrationResponse>> registrationRequest({
    required String name,
    required String phone,
    required String code,
  });

  Future<Either<Failure, LoginResponse>> loginRequest({
    required String phone,
    required String code,
  });

}