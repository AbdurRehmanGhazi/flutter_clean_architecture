import 'dart:convert';

class OTPResendRequestModel {
  String phone;

  OTPResendRequestModel({
    required this.phone,
  });

  factory OTPResendRequestModel.fromRawJson(String str) => OTPResendRequestModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory OTPResendRequestModel.fromJson(Map<String, dynamic> json) => OTPResendRequestModel(
    phone: json["phone"],
  );

  Map<String, dynamic> toJson() => {
    "phone": phone,
  };
}
