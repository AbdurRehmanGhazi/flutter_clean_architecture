import 'dart:convert';

class OtpVerificationRequestModel {
  String phone;
  String otp;

  OtpVerificationRequestModel({
    required this.phone,
    required this.otp,
  });

  factory OtpVerificationRequestModel.fromRawJson(String str) => OtpVerificationRequestModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory OtpVerificationRequestModel.fromJson(Map<String, dynamic> json) => OtpVerificationRequestModel(
    phone: json["phone"],
    otp: json["otp"],
  );

  Map<String, dynamic> toJson() => {
    "phone": phone,
    "otp": otp,
  };
}
