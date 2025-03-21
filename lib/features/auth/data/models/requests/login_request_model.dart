import 'dart:convert';

class LoginRequestModel {
  String? phone;
  String? code;

  LoginRequestModel({
    this.phone,
    this.code,
  });

  factory LoginRequestModel.fromRawJson(String str) => LoginRequestModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory LoginRequestModel.fromJson(Map<String, dynamic> json) => LoginRequestModel(
    phone: json["phone"],
    code: json["code"],
  );

  Map<String, dynamic> toJson() => {
    "phone": phone,
    "code": code,
  };
}
