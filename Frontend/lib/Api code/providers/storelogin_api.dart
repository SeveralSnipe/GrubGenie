import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:grub_genie/Api code/models/storelogin.dart';

class StoreLoginApi {
  Future<StoreLogin?> storeLogin({
    required String identifier,
    required String password,
  }) async {
    Map data = {
      "Identifier": identifier,
      "Password": password,
    };

    var body = jsonEncode(data);
    var uri = Uri.parse('http://10.0.2.2:5000/LoginRouter/loginStore');
    var client = http.Client();

    var response = await client.post(
      uri,
      body: body,
      headers: {"Content-Type": "application/json"},
    );

    print('Got response');
    if (response.statusCode == 200) {
      print('Got successful response');
      return storeLoginFromJson(
          const Utf8Decoder().convert(response.bodyBytes));
    }
    return null;
  }
}
