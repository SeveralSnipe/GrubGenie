// To parse this JSON data, do
//
//     final registerStore = registerStoreFromJson(jsonString);

import 'dart:convert';

RegisterStore registerStoreFromJson(String str) =>
    RegisterStore.fromJson(json.decode(str));

String registerStoreToJson(RegisterStore data) => json.encode(data.toJson());

class RegisterStore {
  String message;
  String storeId;

  RegisterStore({
    required this.message,
    required this.storeId,
  });

  factory RegisterStore.fromJson(Map<String, dynamic> json) => RegisterStore(
        message: json["message"],
        storeId: json["StoreId"],
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "StoreId": storeId,
      };
}
