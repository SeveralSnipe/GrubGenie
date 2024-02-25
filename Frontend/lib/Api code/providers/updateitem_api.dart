import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:grub_genie/Api code/models/updateitem.dart';

class UpdateItemApi {
  Future<UpdateItem?> updateItem({
    required String itemId,
    required String expiryDate,
    String? itemName,
    int? stockQuantity,
    double? itemMRP,
    double? itemSP,
  }) async {
    Map<String, dynamic> data = {
      "ExpiryDate": expiryDate,
      if (itemName != null) "ItemName": itemName,
      if (stockQuantity != null) "StockQuantity": stockQuantity,
      if (itemMRP != null) "ItemMRP": itemMRP,
      if (itemSP != null) "ItemSP": itemSP,
    };

    var body = jsonEncode(data);
    var uri = Uri.parse('http://10.0.2.2:5000/VendorRouter/updateItem/$itemId');
    var client = http.Client();

    var response = await client.patch(
      uri,
      body: body,
      headers: {"Content-Type": "application/json"},
    );
    print('Got response');
    if (response.statusCode == 200) {
      print('Got successful response');
      return updateItemFromJson(
          const Utf8Decoder().convert(response.bodyBytes));
    }
    return null;
  }
}
