import 'dart:convert';

StoresNearMe storesNearMeFromJson(String str) =>
    StoresNearMe.fromJson(json.decode(str));

String storesNearMeToJson(StoresNearMe data) => json.encode(data.toJson());

class StoresNearMe {
  List<Result> result;

  StoresNearMe({
    required this.result,
  });

  factory StoresNearMe.fromJson(Map<String, dynamic> json) => StoresNearMe(
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
        "distance": distance,
        "Email": email,
        "GST": gst,
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
