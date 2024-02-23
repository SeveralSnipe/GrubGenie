// To parse this JSON data, do
//
//     final userLogin = userLoginFromJson(jsonString);

import 'dart:convert';

UserLogin userLoginFromJson(String str) => UserLogin.fromJson(json.decode(str));

String userLoginToJson(UserLogin data) => json.encode(data.toJson());

class UserLogin {
  String message;
  String token;
  String userId;

  UserLogin({
    required this.message,
    required this.token,
    required this.userId,
  });

  factory UserLogin.fromJson(Map<String, dynamic> json) => UserLogin(
        message: json["message"],
        token: json["token"],
        userId: json["userId"],
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "token": token,
        "userId": userId,
      };
}
