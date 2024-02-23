import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:grub_genie/Api code/models/registeruser.dart';

class RegisterUserApi {
  Future<RegisterUser?> registerUser({
    required String userName,
    required String dob,
    required String email,
    required String phoneNumber,
    required String password,
  }) async {
    Map data = {
      "UserName": userName,
      "DOB": dob,
      "Email": email,
      "PhoneNumber": phoneNumber,
      "Password": password,
    };

    var body = jsonEncode(data);
    var uri = Uri.parse('http://10.0.2.2:5000/RegisterRouter/registerUser');
    var client = http.Client();

    var response = await client.post(
      uri,
      body: body,
      headers: {"Content-Type": "application/json"},
    );

    print('Got response');
    if (response.statusCode == 200) {
      print('Got successful response');
      return registerUserFromJson(
          const Utf8Decoder().convert(response.bodyBytes));
    }
    return null;
  }
}
