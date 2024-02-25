// To parse this JSON data, do
//
//     final userRequests = userRequestsFromJson(jsonString);

import 'dart:convert';

UserRequests userRequestsFromJson(String str) =>
    UserRequests.fromJson(json.decode(str));

String userRequestsToJson(UserRequests data) => json.encode(data.toJson());

class UserRequests {
  List<Result> result;

  UserRequests({
    required this.result,
  });

  factory UserRequests.fromJson(Map<String, dynamic> json) => UserRequests(
        result:
            List<Result>.from(json["result"].map((x) => Result.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "result": List<dynamic>.from(result.map((x) => x.toJson())),
      };
}

class Result {
  String status;
  String requestId;
  Location location;
  List<String> additionalNotes;
  String userId;
  Map<String, Map<String, int>> orders;
  int costPrice;
  int discountPrice;

  Result({
    required this.status,
    required this.requestId,
    required this.location,
    required this.additionalNotes,
    required this.userId,
    required this.orders,
    required this.costPrice,
    required this.discountPrice,
  });

  factory Result.fromJson(Map<String, dynamic> json) => Result(
        status: json["Status"],
        requestId: json["RequestId"],
        location: Location.fromJson(json["Location"]),
        additionalNotes:
            List<String>.from(json["AdditionalNotes"].map((x) => x)),
        userId: json["UserId"],
        orders: Map.from(json["Orders"]).map((k, v) =>
            MapEntry<String, Map<String, int>>(
                k, Map.from(v).map((k, v) => MapEntry<String, int>(k, v)))),
        costPrice: json["CostPrice"],
        discountPrice: json["DiscountPrice"],
      );

  Map<String, dynamic> toJson() => {
        "Status": status,
        "RequestId": requestId,
        "Location": location.toJson(),
        "AdditionalNotes": List<dynamic>.from(additionalNotes.map((x) => x)),
        "UserId": userId,
        "Orders": Map.from(orders).map((k, v) => MapEntry<String, dynamic>(
            k, Map.from(v).map((k, v) => MapEntry<String, dynamic>(k, v)))),
        "CostPrice": costPrice,
        "DiscountPrice": discountPrice,
      };
}

class Location {
  double latitude;
  double longitude;

  Location({
    required this.latitude,
    required this.longitude,
  });

  factory Location.fromJson(Map<String, dynamic> json) => Location(
        latitude: json["_latitude"]?.toDouble(),
        longitude: json["_longitude"]?.toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "_latitude": latitude,
        "_longitude": longitude,
      };
}
