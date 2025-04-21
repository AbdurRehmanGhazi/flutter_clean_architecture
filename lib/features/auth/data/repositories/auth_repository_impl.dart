import 'package:flutter_clean_architecture/core/entities/user.dart';
import 'package:flutter_clean_architecture/core/secrets/secure_storage.dart';
import 'package:flutter_clean_architecture/core/secrets/shared_preference.dart';
import 'package:fpdart/fpdart.dart';
import '../../../../core/error/failures.dart';
import '../../domain/repositories/auth_repository.dart';
import '../datasources/auth_remote_data_source.dart';
import '../models/requests/login_request_model.dart';
import '../models/requests/mobile_number_verification_request_model.dart';
import '../models/requests/otp_resend_request_model.dart';
import '../models/requests/otp_verification_request_model.dart';
import '../models/requests/registration_request_model.dart';
import '../models/responses/mobile_number_verification_response_model.dart';
import '../models/responses/otp_resend_response_model.dart';
import '../models/responses/registration_response_model.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource authRemoteDataSource;

  AuthRepositoryImpl(this.authRemoteDataSource);

  @override
  Future<Either<Failure, MobileNumberVerificationResponseModel>> mobileNumberVerificationRequest({required String phone}) async {
    try {
      final res = await authRemoteDataSource.mobileNumberVerificationRequest(
        payload: MobileNumberVerificationRequestModel(phone: phone),
      );
      await SecureStorage.saveUser(User(mobileNumber: phone));
      return right(res);
    } catch (e) {
    return left(Failure(e.toString()));
    }
  }


  @override
  Future<Either<Failure, String>> otpVerificationRequest({required String otp, required String phone}) async {
    try {
      final res = await authRemoteDataSource.otpVerificationRequest(
        payload: OtpVerificationRequestModel(otp: otp, phone: phone),
      );
      return right(res);
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, OTPResendResponseModel>> otpResendRequest({required String phone}) async {
    try {
      final res = await authRemoteDataSource.otpResendRequest(
        payload: OTPResendRequestModel(phone: phone),
      );
      return right(res);
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, RegistrationResponseModel>> registrationRequest({required String name, required String phone, required String code}) async {
    try {
      final res = await authRemoteDataSource.registrationRequest(
        payload: RegistrationRequestModel(name: name, phone: phone, code: code),
      );
      return right(res);
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, User>> loginRequest({required String phone, required String code, required bool isRemember}) async {
    try {
      final res = await authRemoteDataSource.loginRequest(
        payload: LoginRequestModel(phone: phone, code: code),
      );
      SecureStorage.saveUser(res);
      await SharedPreference.setRememberMe(isRemember);
      return right(res);
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }

}
