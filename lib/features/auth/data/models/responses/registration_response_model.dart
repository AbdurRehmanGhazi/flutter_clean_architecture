import 'dart:convert';
import '../../../domain/entities/registration_response.dart';

class RegistrationResponseModel extends RegistrationResponse{

  RegistrationResponseModel({
    super.name,
    super.phone,
  });

  factory RegistrationResponseModel.fromRawJson(String str) => RegistrationResponseModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory RegistrationResponseModel.fromJson(Map<String, dynamic> json) => RegistrationResponseModel(
    name: json["name"],
    phone: json["phone"],
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "phone": phone,
  };
}
