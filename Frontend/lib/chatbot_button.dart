import 'package:flutter/material.dart';

class ChatbotButton extends StatelessWidget {
  final Function onPressed;

  const ChatbotButton({Key? key, required this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: const Alignment(0.9, 0.9),
      child: FloatingActionButton(
        onPressed: () => onPressed(),
        child: const Icon(Icons.chat),
      ),
    );
  }
}
