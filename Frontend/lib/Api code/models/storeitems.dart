import 'dart:convert';

StoreItems storeItemsFromJson(String str) =>
    StoreItems.fromJson(json.decode(str));

String storeItemsToJson(StoreItems data) => json.encode(data.toJson());

class StoreItems {
  List<Result> results;

  StoreItems({
    required this.results,
  });

  factory StoreItems.fromJson(Map<String, dynamic> json) => StoreItems(
        results:
            List<Result>.from(json["results"].map((x) => Result.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "results": List<dynamic>.from(results.map((x) => x.toJson())),
      };
}

class Result {
  ExpiryDate expiryDate;
  int itemMrp;
  int itemSp;
  int stockQuantity;
  String itemName;
  String itemId;
  String storeId;

  Result({
    required this.expiryDate,
    required this.itemMrp,
    required this.itemSp,
    required this.stockQuantity,
    required this.itemName,
    required this.itemId,
    required this.storeId,
  });

  factory Result.fromJson(Map<String, dynamic> json) => Result(
        expiryDate: ExpiryDate.fromJson(json["ExpiryDate"]),
        itemMrp: json["ItemMRP"],
        itemSp: json["ItemSP"],
        stockQuantity: json["StockQuantity"],
        itemName: json["ItemName"],
        itemId: json["ItemId"],
        storeId: json["StoreId"],
      );

  Map<String, dynamic> toJson() => {
        "ExpiryDate": expiryDate.toJson(),
        "ItemMRP": itemMrp,
        "ItemSP": itemSp,
        "StockQuantity": stockQuantity,
        "ItemName": itemName,
        "ItemId": itemId,
        "StoreId": storeId,
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
