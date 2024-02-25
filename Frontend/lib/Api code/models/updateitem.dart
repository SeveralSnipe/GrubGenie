// To parse this JSON data, do
//
//     final updateItem = updateItemFromJson(jsonString);

import 'dart:convert';

UpdateItem updateItemFromJson(String str) =>
    UpdateItem.fromJson(json.decode(str));

String updateItemToJson(UpdateItem data) => json.encode(data.toJson());

class UpdateItem {
  String message;

  UpdateItem({
    required this.message,
  });

  factory UpdateItem.fromJson(Map<String, dynamic> json) => UpdateItem(
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "message": message,
      };
}
