import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:grub_genie/Api%20code/service/chatbot_service.dart';
import 'package:grub_genie/message.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import 'foodcard.dart';

class NearFoodProvider extends ChangeNotifier {
  late List<FoodCard> totalCardList;
  late List<FoodCard> cardList;

  NearFoodProvider(this.totalCardList) {
    cardList = List.from(totalCardList);
  }

  void searched(String query) {
    // if (query == '') {
    //   cardList = List.from(totalCardList);
    //   notifyListeners();
    //   return;
    // } may work without
    cardList.clear();
    for (var result in totalCardList) {
      if (result.item.toLowerCase().contains(query.toLowerCase())) {
        cardList.add(result);
      }
    }
    notifyListeners();
  }
}

class ChatbotProvider extends ChangeNotifier {
  List<Message> messages = [];

  Future<void> sendMessage(String message, String userId) async {
    messages.add(Message(
        content: Text(message,
            style: GoogleFonts.josefinSans(
              color: Colors.black87,
              fontSize: 16,
            )),
        sentByMe: true));
    messages.add(Message(
        content: LoadingAnimationWidget.twistingDots(
            leftDotColor: Colors.cyan, rightDotColor: Colors.cyan, size: 20),
        sentByMe: false));
    notifyListeners();
    var chatbotResponse = await ChatbotService().getChatbot(message, userId);
    messages.removeLast();
    messages.add(Message(
        content: Text(chatbotResponse!.response,
            style: GoogleFonts.josefinSans(
              color: Colors.black87,
              fontSize: 16,
            )),
        sentByMe: false));
    notifyListeners();
  }
}
