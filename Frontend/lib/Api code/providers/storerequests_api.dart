import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:grub_genie/Api code/models/storerequests.dart';

class StoreRequestsApi {
  Future<StoreRequests?> getStoreRequests(String storeId) async {
    var uri = Uri.parse(
        'http://10.0.2.2:5000/CommerceRequestRouter/requestStore/$storeId');
    var client = http.Client();

    try {
      var response = await client.get(
        uri,
        headers: {"Content-Type": "application/json"},
      );

      print('Got response');
      if (response.statusCode == 200) {
        print('Got successful response');
        print(
          storeRequestsFromJson(
              const Utf8Decoder().convert(response.bodyBytes)),
        );
        return storeRequestsFromJson(
          const Utf8Decoder().convert(response.bodyBytes),
        );
      } else {
        print('Error: ${response.statusCode}');
      }
    } catch (e) {
      print('Error: $e');
    } finally {
      client.close();
    }

    return null;
  }
}
