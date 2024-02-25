import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:grub_genie/Api code/models/storeitems.dart';

class StoreItemsApi {
  Future<StoreItems?> getStoreItems(String storeId) async {
    var uri = Uri.parse(
        'http://10.0.2.2:5000/CommerceNearMeRouter/StoreItems/$storeId');
    var client = http.Client();

    var response = await client.get(
      uri,
      headers: {"Content-Type": "application/json"},
    );

    print('Got response');
    if (response.statusCode == 200) {
      print('Got successful response');
      print(
          storeItemsFromJson(const Utf8Decoder().convert(response.bodyBytes)));
      return storeItemsFromJson(
          const Utf8Decoder().convert(response.bodyBytes));
    } else {
      print('Error: ${response.statusCode}');
    }
    return null;
  }
}
