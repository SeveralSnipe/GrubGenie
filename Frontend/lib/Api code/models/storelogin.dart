import 'dart:convert';

StoreLogin storeLoginFromJson(String str) =>
    StoreLogin.fromJson(json.decode(str));

String storeLoginToJson(StoreLogin data) => json.encode(data.toJson());

class StoreLogin {
  String message;
  String token;
  String storeId;
  String storeName;

  StoreLogin({
    required this.message,
    required this.token,
    required this.storeId,
    required this.storeName,
  });

  factory StoreLogin.fromJson(Map<String, dynamic> json) => StoreLogin(
        message: json["message"],
        token: json["token"],
        storeId: json["StoreId"],
        storeName: json["StoreName"],
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "token": token,
        "StoreId": storeId,
        "StoreName": storeName,
      };
}
