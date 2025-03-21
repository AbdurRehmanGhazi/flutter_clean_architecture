import 'dart:convert';
import '../../../domain/entities/login_response.dart';

class LoginResponseModel extends LoginResponse {

  LoginResponseModel({
    super.name,
    super.phone,
    super.token,
  });

  factory LoginResponseModel.fromRawJson(String str) => LoginResponseModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory LoginResponseModel.fromJson(Map<String, dynamic> json) => LoginResponseModel(
    name: json["name"],
    phone: json["phone"],
    token: json["token"],
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "phone": phone,
    "token": token,
  };
}
