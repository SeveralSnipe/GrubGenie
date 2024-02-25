import 'dart:convert';

RequestFood requestFoodFromJson(String str) =>
    RequestFood.fromJson(json.decode(str));

String requestFoodToJson(RequestFood data) => json.encode(data.toJson());

class RequestFood {
  String message;
  String requestId;

  RequestFood({
    required this.message,
    required this.requestId,
  });

  factory RequestFood.fromJson(Map<String, dynamic> json) => RequestFood(
        message: json["message"],
        requestId: json["requestId"],
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "requestId": requestId,
      };
}
