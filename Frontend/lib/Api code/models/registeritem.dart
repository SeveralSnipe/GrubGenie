// To parse this JSON data, do
//
//     final registerItem = registerItemFromJson(jsonString);

import 'dart:convert';

RegisterItem registerItemFromJson(String str) =>
    RegisterItem.fromJson(json.decode(str));

String registerItemToJson(RegisterItem data) => json.encode(data.toJson());

class RegisterItem {
  String message;
  String itemId;

  RegisterItem({
    required this.message,
    required this.itemId,
  });

  factory RegisterItem.fromJson(Map<String, dynamic> json) => RegisterItem(
        message: json["message"],
        itemId: json["ItemId"],
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "ItemId": itemId,
      };
}
