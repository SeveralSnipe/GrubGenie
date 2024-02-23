// To parse this JSON data, do
//
//     final registerUser = registerUserFromJson(jsonString);

import 'dart:convert';

RegisterUser registerUserFromJson(String str) =>
    RegisterUser.fromJson(json.decode(str));

String registerUserToJson(RegisterUser data) => json.encode(data.toJson());

class RegisterUser {
  String message;
  String userId;

  RegisterUser({
    required this.message,
    required this.userId,
  });

  factory RegisterUser.fromJson(Map<String, dynamic> json) => RegisterUser(
        message: json["message"],
        userId: json["UserId"],
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "UserId": userId,
      };
}
