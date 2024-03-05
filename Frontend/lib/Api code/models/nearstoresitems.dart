// To parse this JSON data, do
//
//     final nearStoresItems = nearStoresItemsFromJson(jsonString);

import 'dart:convert';

NearStoresItems nearStoresItemsFromJson(String str) =>
    NearStoresItems.fromJson(json.decode(str));

String nearStoresItemsToJson(NearStoresItems data) =>
    json.encode(data.toJson());

class NearStoresItems {
  List<Result> result;

  NearStoresItems({
    required this.result,
  });

  factory NearStoresItems.fromJson(Map<String, dynamic> json) =>
      NearStoresItems(
        result:
            List<Result>.from(json["result"].map((x) => Result.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "result": List<dynamic>.from(result.map((x) => x.toJson())),
      };
}

class Result {
  String? password;
  String email;
  String storeId;
  String storeName;
  Location location;
  int gst;
  int phoneNumber;
  List<Item> items;
  double distance;

  Result({
    this.password,
    required this.email,
    required this.storeId,
    required this.storeName,
    required this.location,
    required this.gst,
    required this.phoneNumber,
    required this.items,
    required this.distance,
  });

  factory Result.fromJson(Map<String, dynamic> json) => Result(
        password: json["password"],
        email: json["Email"],
        storeId: json["StoreId"],
        storeName: json["StoreName"],
        location: Location.fromJson(json["Location"]),
        gst: json["GST"],
        phoneNumber: json["PhoneNumber"],
        items: List<Item>.from(json["items"].map((x) => Item.fromJson(x))),
        distance: json["distance"]?.toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "password": password,
        "Email": email,
        "StoreId": storeId,
        "StoreName": storeName,
        "Location": location.toJson(),
        "GST": gst,
        "PhoneNumber": phoneNumber,
        "items": List<dynamic>.from(items.map((x) => x.toJson())),
        "distance": distance,
      };
}

class Item {
  ExpiryDate expiryDate;
  int itemMrp;
  int itemSp;
  String storeId;
  int stockQuantity;
  String itemName;
  String itemId;

  Item({
    required this.expiryDate,
    required this.itemMrp,
    required this.itemSp,
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
