import 'dart:convert';

class RegistrationRequestModel {
  String? phone;
  String? code;
  String? name;

  RegistrationRequestModel({
    this.phone,
    this.code,
    this.name,
  });

  factory RegistrationRequestModel.fromRawJson(String str) => RegistrationRequestModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory RegistrationRequestModel.fromJson(Map<String, dynamic> json) => RegistrationRequestModel(
    phone: json["phone"],
    code: json["code"],
    name: json["name"],
  );

  Map<String, dynamic> toJson() => {
    "phone": phone,
    "code": code,
    "name": name,
  };
}
