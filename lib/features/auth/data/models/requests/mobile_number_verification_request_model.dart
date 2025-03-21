import 'dart:convert';

class MobileNumberVerificationRequestModel {
  String phone;

  MobileNumberVerificationRequestModel({
    required this.phone,
  });

  factory MobileNumberVerificationRequestModel.fromRawJson(String str) => MobileNumberVerificationRequestModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory MobileNumberVerificationRequestModel.fromJson(Map<String, dynamic> json) => MobileNumberVerificationRequestModel(
    phone: json["phone"],
  );

  Map<String, dynamic> toJson() => {
    "phone": phone,
  };
}