import 'dart:convert';
import 'package:grub_genie/Api code/models/chatbot.dart';
import 'package:http/http.dart' as http;

class ChatbotApi {
  Future<Chatbot?> getChatbot(String message, String userId) async {
    Map data = {"user": userId, "prompt": message};
    var body = jsonEncode(data);
    var client = http.Client();
    var uri = Uri.parse('http://10.0.2.2:6000/chatbot');
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
