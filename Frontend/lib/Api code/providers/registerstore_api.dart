import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:grub_genie/Api code/models/registerstore.dart';

class RegisterStoreApi {
  Future<RegisterStore?> registerStore({
    required String storeName,
    required String gst,
    required String email,
    required String location,
    required String phoneNumber,
    required String password,
  }) async {
    Map data = {
      "StoreName": storeName,
      "GST": gst,
      "Email": email,
      "Location": location,
      "PhoneNumber": phoneNumber,
      "Password": password,
    };

    var body = jsonEncode(data);
    var uri = Uri.parse('http://10.0.2.2:5000/RegisterRouter/registerStore');
    var client = http.Client();

    var response = await client.post(
      uri,
      body: body,
      headers: {"Content-Type": "application/json"},
    );

    print('Got response');
    if (response.statusCode == 200) {
      print('Got successful response');
      return registerStoreFromJson(
          const Utf8Decoder().convert(response.bodyBytes));
    }
    return null;
  }
}
