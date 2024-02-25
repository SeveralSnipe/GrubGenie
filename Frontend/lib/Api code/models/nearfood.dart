// To parse this JSON data, do
//
//     final nearFood = nearFoodFromJson(jsonString);

import 'dart:convert';

NearFood nearFoodFromJson(String str) => NearFood.fromJson(json.decode(str));

String nearFoodToJson(NearFood data) => json.encode(data.toJson());

class NearFood {
  List<Result> result;

  NearFood({
    required this.result,
  });

  factory NearFood.fromJson(Map<String, dynamic> json) => NearFood(
        result:
            List<Result>.from(json["result"].map((x) => Result.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "result": List<dynamic>.from(result.map((x) => x.toJson())),
      };
}

class Result {
  String storeId;
  String storeName;
  int? gstNo;
  int? phoneNumber;
  String? resultEmail;
  Location location;
  List<Item> items;
  double distance;
  String? email;
  int? gst;

  Result({
    required this.storeId,
    required this.storeName,
    this.gstNo,
    this.phoneNumber,
    this.resultEmail,
    required this.location,
    required this.items,
    required this.distance,
    this.email,
    this.gst,
  });

  factory Result.fromJson(Map<String, dynamic> json) => Result(
        storeId: json["StoreId"],
        storeName: json["StoreName"],
        gstNo: json["GSTNo"],
        phoneNumber: json["PhoneNumber"],
        resultEmail: json["email"],
        location: Location.fromJson(json["Location"]),
        items: List<Item>.from(json["items"].map((x) => Item.fromJson(x))),
        distance: json["distance"]?.toDouble(),
        email: json["Email"],
        gst: json["GST"],
      );

  Map<String, dynamic> toJson() => {
        "StoreId": storeId,
        "StoreName": storeName,
        "GSTNo": gstNo,
        "PhoneNumber": phoneNumber,
        "email": resultEmail,
        "Location": location.toJson(),
        "items": List<dynamic>.from(items.map((x) => x.toJson())),
        "distance": distance,
        "Email": email,
        "GST": gst,
      };
}

class Item {
  ExpiryDate expiryDate;
  int itemMrp;
  int? itemSp;
  String storeId;
  int stockQuantity;
  String itemName;
  String itemId;

  Item({
    required this.expiryDate,
    required this.itemMrp,
    this.itemSp,
    required this.storeId,
    required this.stockQuantity,
    required this.itemName,
    required this.itemId,
  });

  factory Item.fromJson(Map<String, dynamic> json) => Item(
        expiryDate: ExpiryDate.fromJson(json["ExpiryDate"]),
        itemMrp: json["ItemMRP"],
        itemSp: json["ItemSP"],
        storeId: json["StoreId"],
        stockQuantity: json["StockQuantity"],
        itemName: json["ItemName"],
        itemId: json["ItemId"],
      );

  Map<String, dynamic> toJson() => {
        "ExpiryDate": expiryDate.toJson(),
        "ItemMRP": itemMrp,
        "ItemSP": itemSp,
        "StoreId": storeId,
        "StockQuantity": stockQuantity,
        "ItemName": itemName,
        "ItemId": itemId,
      };
}

class ExpiryDate {
  int seconds;
  int nanoseconds;

  ExpiryDate({
    required this.seconds,
    required this.nanoseconds,
  });

  factory ExpiryDate.fromJson(Map<String, dynamic> json) => ExpiryDate(
        seconds: json["_seconds"],
        nanoseconds: json["_nanoseconds"],
      );

  Map<String, dynamic> toJson() => {
        "_seconds": seconds,
        "_nanoseconds": nanoseconds,
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
