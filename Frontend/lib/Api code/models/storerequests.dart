// To parse this JSON data, do
//
//     final storeRequests = storeRequestsFromJson(jsonString);

import 'dart:convert';

StoreRequests storeRequestsFromJson(String str) =>
    StoreRequests.fromJson(json.decode(str));

String storeRequestsToJson(StoreRequests data) => json.encode(data.toJson());

class StoreRequests {
  List<Result> result;

  StoreRequests({
    required this.result,
  });

  factory StoreRequests.fromJson(Map<String, dynamic> json) => StoreRequests(
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
        orders: json["Orders"],
        costPrice: json["CostPrice"],
        discountPrice: json["DiscountPrice"],
      );

  Map<String, dynamic> toJson() => {
        "Status": status,
        "RequestId": requestId,
        "Location": location.toJson(),
        "AdditionalNotes": List<dynamic>.from(additionalNotes.map((x) => x)),
        "UserId": userId,
        "Orders": orders,
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
