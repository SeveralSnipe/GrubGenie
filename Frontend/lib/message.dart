import 'package:flutter/material.dart';

class Message extends StatefulWidget {
  final Widget content;
  final bool sentByMe;

  const Message({super.key, required this.content, required this.sentByMe});

  @override
  State<Message> createState() => _MessageState();
}

class _MessageState extends State<Message> {
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(8),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          bottomLeft: const Radius.circular(30),
          bottomRight: const Radius.circular(30),
          topLeft: widget.sentByMe ? const Radius.circular(30) : Radius.zero,
          topRight: !widget.sentByMe ? const Radius.circular(30) : Radius.zero,
        ),
      ),
      color: Colors.white60,
      shadowColor: Colors.grey,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: widget.content,
      ),
    );
  }
}
