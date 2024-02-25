import 'dart:convert';
import 'package:geolocator/geolocator.dart';
import 'package:grub_genie/Api code/models/chatbot.dart';
import 'package:http/http.dart' as http;

class ChatbotApi {
  Future<Chatbot?> getChatbot(String message, String userId) async {
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }
    Position currentPosition = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.best,
        forceAndroidLocationManager: true);
    Map data = {
      "longitude": currentPosition.longitude,
      "latitude": currentPosition.longitude,
      "user": userId,
      "prompt": message
    };
    var body = jsonEncode(data);
    var client = http.Client();
    var uri = Uri.parse('http://10.0.2.2:6000/calling');
    var response = await client
        .post(uri, body: body, headers: {"Content-Type": "application/json"});
    print('Got response');
    if (response.statusCode == 200) {
      print('Got successful response');
      return chatbotFromJson(const Utf8Decoder().convert(response.bodyBytes));
    }
    return null;
  }
}
