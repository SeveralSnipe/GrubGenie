import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import 'models.dart';

class Chatbot extends StatefulWidget {
  const Chatbot({super.key});

  @override
  State<Chatbot> createState() => _ChatbotState();
}

class _ChatbotState extends State<Chatbot> {
  TextEditingController questionController = TextEditingController();
  final FlutterSecureStorage _secureStorage = const FlutterSecureStorage();
  late String username;

  @override
  void dispose() {
    // TODO: implement dispose
    questionController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadUser();
  }

  void loadUser() async {
    String? storedUsername = await _secureStorage.read(key: 'userName');
    setState(() {
      username = storedUsername ?? 'User';
    });
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (context) => ChatbotProvider(),
        child: Consumer<ChatbotProvider>(
            builder: (context, myChatbotProvider, child) {
          return Scaffold(
            appBar: AppBar(
              title: Text(
                "GrubHelper",
                style: GoogleFonts.josefinSans(
                  color: Colors.black87,
                  fontSize: 16,
                ),
              ),
              backgroundColor: Colors.white,
              foregroundColor: Colors.grey,
            ),
            body: Container(
              alignment: Alignment.topCenter,
              color: Colors.lightBlue,
              child: Column(
                children: [
                  Expanded(
                      child: ListView.builder(
                    padding: const EdgeInsets.only(top: 10),
                    itemCount: myChatbotProvider.messages.length,
                    itemBuilder: (context, index) {
                      return Align(
                        alignment: myChatbotProvider.messages[index].sentByMe
                            ? Alignment.centerRight
                            : Alignment.centerLeft,
                        child: myChatbotProvider.messages[index],
                      );
                    },
                  )),
                  Container(
                    color: Colors.grey.shade300,
                    child: TextField(
                      decoration: const InputDecoration(
                          contentPadding: EdgeInsets.all(12),
                          hintText: 'How can I help you?'),
                      controller: questionController,
                      onSubmitted: (value) {
                        myChatbotProvider.sendMessage(value, username);
                        questionController.clear();
                      },
                    ),
                  )
                ],
              ),
            ),
          );
        }));
  }
}
