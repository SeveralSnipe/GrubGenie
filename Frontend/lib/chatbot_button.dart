import 'package:flutter/material.dart';
import 'package:grub_genie/chatbot.dart';
import 'package:page_transition/page_transition.dart';

class ChatbotButton extends StatelessWidget {
  final Function onPressed;

  const ChatbotButton({Key? key, required this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: const Alignment(0.9, 0.9),
      child: FloatingActionButton(
        onPressed: () => Navigator.push(
            context,
            PageTransition(
                child: const Chatbot(),
                type: PageTransitionType.rightToLeft,
                duration: const Duration(milliseconds: 700))),
        child: const Icon(Icons.chat),
      ),
    );
  }
}
