import 'dart:convert';
import '../../../domain/entities/otp_resend_response.dart';

class OTPResendResponseModel extends OtpResendResponse{

  OTPResendResponseModel({
    super.otp,
    super.phone,
  });

  factory OTPResendResponseModel.fromRawJson(String str) => OTPResendResponseModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory OTPResendResponseModel.fromJson(Map<String, dynamic> json) => OTPResendResponseModel(
    otp: json["otp"],
    phone: json["phone"],
  );

  Map<String, dynamic> toJson() => {
    "otp": otp,
    "phone": phone,
  };
}
