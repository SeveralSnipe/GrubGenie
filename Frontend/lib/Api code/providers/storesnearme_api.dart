import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:grub_genie/Api code/models/storesnearme.dart';

class StoreNearMeDistApi {
  Future<List<StoresNearMe>?> getStoresNearMe({
    required List<double> location,
    required String sorts,
    required double maxDist,
  }) async {
    Map<String, dynamic> data = {
      "sorts": sorts,
      "location": location,
      "maxDist": maxDist,
    };

    var body = jsonEncode(data);
    var uri =
        Uri.parse('http://10.0.2.2:5000/CommerceNearMeRouter/StoreNearMeDist');
    var client = http.Client();

    var response = await client.post(
      uri,
      body: body,
      headers: {"Content-Type": "application/json"},
    );

    print('Got response');
    if (response.statusCode == 200) {
      print('Got successful response');
      List<dynamic> jsonList = [
        jsonDecode(const Utf8Decoder().convert(response.bodyBytes))
      ];

      List<StoresNearMe> storesNearMe =
          jsonList.map((store) => StoresNearMe.fromJson(store)).toList();

      return storesNearMe;
    }
    return null;
  }
}
