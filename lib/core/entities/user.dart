import 'dart:convert';

class User {
  String? id;
  String? email;
  String? name;
  String? mobileNumber;
  String? password;

  User({
    this.id,
    this.email,
    this.name,
    this.mobileNumber,
    this.password,
  });

  User copyWith({
    String? id,
    String? email,
    String? name,
    String? mobileNumber,
    String? password,
  }) =>
      User(
        id: id ?? this.id,
        email: email ?? this.email,
        name: name ?? this.name,
        mobileNumber: mobileNumber ?? this.mobileNumber,
        password: password ?? this.password,
      );

  factory User.fromRawJson(String str) => User.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory User.fromJson(Map<String, dynamic> json) => User(
    id: json["id"],
    email: json["email"],
    name: json["name"],
    mobileNumber: json["mobileNumber"],
    password: json["password"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "email": email,
    "name": name,
    "mobileNumber": mobileNumber,
    "password": password,
  };
}
