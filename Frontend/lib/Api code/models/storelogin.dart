// To parse this JSON data, do
//
//     final storeLogin = storeLoginFromJson(jsonString);

import 'dart:convert';

StoreLogin storeLoginFromJson(String str) =>
    StoreLogin.fromJson(json.decode(str));

String storeLoginToJson(StoreLogin data) => json.encode(data.toJson());

class StoreLogin {
  String message;
  String token;
  String storeId;

  StoreLogin({
    required this.message,
    required this.token,
    required this.storeId,
  });

  factory StoreLogin.fromJson(Map<String, dynamic> json) => StoreLogin(
        message: json["message"],
        token: json["token"],
        storeId: json["StoreId"],
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "token": token,
        "StoreId": storeId,
      };
}
