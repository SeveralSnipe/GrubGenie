import 'dart:convert';
import 'package:grub_genie/Api code/models/nearfood.dart';
import 'package:http/http.dart' as http;

class NearFoodApi {
  Future<NearFood?> getNearFood() async {
    Map data = {
      "location": [80, 80],
      "maxDist": 10000,
      "sorts": "dist"
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
      return nearFoodFromJson(const Utf8Decoder().convert(response.bodyBytes));
    }
    return null;
  }
}
