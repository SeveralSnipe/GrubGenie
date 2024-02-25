// To parse this JSON data, do
//
//     final unmappedRequest = unmappedRequestFromJson(jsonString);

import 'dart:convert';

UnmappedRequest unmappedRequestFromJson(String str) =>
    UnmappedRequest.fromJson(json.decode(str));

String unmappedRequestToJson(UnmappedRequest data) =>
    json.encode(data.toJson());

class UnmappedRequest {
  String message;
  String requestId;

  UnmappedRequest({
    required this.message,
    required this.requestId,
  });

  factory UnmappedRequest.fromJson(Map<String, dynamic> json) =>
      UnmappedRequest(
        message: json["message"],
        requestId: json["requestId"],
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "requestId": requestId,
      };
}
