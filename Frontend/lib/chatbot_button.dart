import 'package:flutter/material.dart';

class ChatbotButton extends StatelessWidget {
  final Function onPressed;

  const ChatbotButton({Key? key, required this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 16.0,
      right: 16.0,
      child: FloatingActionButton(
        onPressed: () => onPressed(),
        child: const Icon(Icons.chat),
      ),
    );
  }
}
