import 'dart:convert';
import 'package:grub_genie/Api code/models/nearstoresitems.dart';
import 'package:http/http.dart' as http;

class NearStoresItemsApi {
  Future<NearStoresItems?> getNearStoresItems(
      double latitude, double longitude) async {
    Map data = {
      "sorts": "dist",
      "location": [latitude, longitude],
      "maxDist": 100000
    };
    var body = jsonEncode(data);
    var client = http.Client();
    var uri = Uri.parse(
        'http://10.0.2.2:5000/CommerceNearMeRouter/StoreNearMeWithItemNames');
    var response = await client
        .post(uri, body: body, headers: {"Content-Type": "application/json"});
    print('Got response');
    if (response.statusCode == 200) {
      print('Got successful response');
      return nearStoresItemsFromJson(
          const Utf8Decoder().convert(response.bodyBytes));
    }
    return null;
  }
}
