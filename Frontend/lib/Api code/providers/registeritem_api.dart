import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:grub_genie/Api code/models/registeritem.dart';

class RegisterItemApi {
  Future<RegisterItem?> registerItem({
    required String expiryDate,
    required double itemMRP,
    required double itemSP,
    required String itemName,
    required int stockQuantity,
    required String storeId,
  }) async {
    Map data = {
      "ExpiryDate": expiryDate,
      "ItemMRP": itemMRP,
      "ItemSP": itemSP,
      "ItemName": itemName,
      "StockQuantity": stockQuantity,
      "StoreId": storeId,
    };

    var body = jsonEncode(data);
    var uri = Uri.parse('http://10.0.2.2:5000/VendorRouter/registerItem');
    var client = http.Client();

    var response = await client.post(
      uri,
      body: body,
      headers: {"Content-Type": "application/json"},
    );
    print('Got response');
    if (response.statusCode == 200) {
      print('Got successful response');
      return registerItemFromJson(
          const Utf8Decoder().convert(response.bodyBytes));
    }
    return null;
  }
}
