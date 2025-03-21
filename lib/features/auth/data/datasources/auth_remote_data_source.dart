import '../models/requests/login_request_model.dart';
import '../models/requests/mobile_number_verification_request_model.dart';
import '../models/requests/otp_resend_request_model.dart';
import '../models/requests/otp_verification_request_model.dart';
import '../models/requests/registration_request_model.dart';
import '../models/responses/login_response_model.dart';
import '../models/responses/mobile_number_verification_response_model.dart';
import '../models/responses/otp_resend_response_model.dart';
import '../models/responses/registration_response_model.dart';

abstract interface class AuthRemoteDataSource {
  Future<MobileNumberVerificationResponseModel> mobileNumberVerificationRequest({
    required MobileNumberVerificationRequestModel payload,
  });

  Future<String> otpVerificationRequest({
    required OtpVerificationRequestModel payload,
  });

  Future<OTPResendResponseModel> otpResendRequest({
    required OTPResendRequestModel payload,
  });

  Future<RegistrationResponseModel> registrationRequest({
      required RegistrationRequestModel payload,
    });

  Future<LoginResponseModel> loginRequest({
      required LoginRequestModel payload,
    });
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  @override
  Future<MobileNumberVerificationResponseModel> mobileNumberVerificationRequest({
    required MobileNumberVerificationRequestModel payload,
  }) async {
    // final res = await NetworkRequest.sendHTTPRequest(
    //   API.login,
    //   method: HttpMethod.POST,
    //   payload: payload.toJson(),
    // );

    await Future.delayed(const Duration(seconds: 2));
    if (payload.phone.contains('111')) throw 'Invalid Mobile Number!';

    return MobileNumberVerificationResponseModel(id : 'lsdkjfskd232kl32jk', otp: '12345', phone: '03351234567');
    // return MobileNumberVerificationResponseModel.fromJson(res.data);
  }

  @override
  Future<String> otpVerificationRequest({required OtpVerificationRequestModel payload}) async {
    await Future.delayed(const Duration(seconds: 2));
    if (payload.otp.contains('111')) throw 'Invalid otp code!';
    return 'OTP Verified Successfully!';
  }

  @override
  Future<OTPResendResponseModel> otpResendRequest({required OTPResendRequestModel payload}) async {
    await Future.delayed(const Duration(seconds: 2));
    return OTPResendResponseModel(otp: '12345', phone: '03351234567');
  }

  @override
  Future<RegistrationResponseModel> registrationRequest({required RegistrationRequestModel payload}) async {
    await Future.delayed(const Duration(seconds: 2));
    return RegistrationResponseModel(name: 'Abdur Rehman', phone: '03351234567');
  }

  @override
  Future<LoginResponseModel> loginRequest({required LoginRequestModel payload}) async {
    await Future.delayed(const Duration(seconds: 2));
    return LoginResponseModel(name: 'Abdur Rehman', phone: '03351234567', token: 'alsdjfdasfkasdjkfsd;fjk');
  }

}
