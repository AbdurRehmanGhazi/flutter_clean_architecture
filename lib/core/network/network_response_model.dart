import 'dart:convert';

class NetworkResponseModel {
  int? responseCode;
  String? message;
  dynamic data;

  NetworkResponseModel({
    this.responseCode,
    this.message,
    this.data,
  });

  factory NetworkResponseModel.fromRawJson(String str) => NetworkResponseModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory NetworkResponseModel.fromJson(Map<String, dynamic> json) => NetworkResponseModel(
    responseCode: json["responseCode"],
    message: json["message"],
    data: json["data"],
  );

  Map<String, dynamic> toJson() => {
    "responseCode": responseCode,
    "message": message,
    "data": data?.toJson(),
  };
}
