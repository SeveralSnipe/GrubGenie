import 'package:grub_genie/Api code/providers/chatbot_api.dart';
import 'package:grub_genie/Api%20code/models/chatbot.dart';

class ChatbotService {
  final _api = ChatbotApi();
  Future<Chatbot?> getChatbot(String message, String userId) async {
    return _api.getChatbot(message, userId);
  }
}
