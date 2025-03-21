import 'dart:convert';

class LoginResponse {
  String? name;
  String? phone;
  String? token;

  LoginResponse({
    this.name,
    this.phone,
    this.token,
  });
}
