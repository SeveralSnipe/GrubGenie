import 'dart:convert';

Chatbot chatbotFromJson(String str) => Chatbot.fromJson(json.decode(str));

String chatbotToJson(Chatbot data) => json.encode(data.toJson());

class Chatbot {
  String response;

  Chatbot({
    required this.response,
  });

  factory Chatbot.fromJson(Map<String, dynamic> json) => Chatbot(
        response: json["response"],
      );

  Map<String, dynamic> toJson() => {
        "response": response,
      };
}
