import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:grub_genie/Api%20code/models/userrequests.dart';

class UserRequestsApi {
  Future<UserRequests?> getUserRequests(String userId) async {
    var uri = Uri.parse(
        'http://10.0.2.2:5000/CommerceRequestRouter/requestUser/$userId');
    var client = http.Client();

    var response = await client.get(
      uri,
      headers: {"Content-Type": "application/json"},
    );

    print('Got response');
    if (response.statusCode == 200) {
      print('Got successful response');
      print(response.body);
      return userRequestsFromJson(
        const Utf8Decoder().convert(response.bodyBytes),
      );
    } else {
      print('Error: ${response.statusCode}');
    }

    return null;
  }
}
