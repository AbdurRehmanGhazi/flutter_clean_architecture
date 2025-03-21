import 'dart:convert';
import '../../../domain/entities/mobile_number_verification_response.dart';

class MobileNumberVerificationResponseModel extends MobileNumberVerificationResponse{

  MobileNumberVerificationResponseModel({
    super.id,
    super.otp,
    super.phone,
  });

  factory MobileNumberVerificationResponseModel.fromRawJson(String str) => MobileNumberVerificationResponseModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory MobileNumberVerificationResponseModel.fromJson(Map<String, dynamic> json) => MobileNumberVerificationResponseModel(
    id: json["id"],
    otp: json["otp"],
    phone: json["phone"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "otp": otp,
    "phone": phone,
  };
}
