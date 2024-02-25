import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:grub_genie/home.dart';
import 'package:grub_genie/nearfood.dart';
import 'package:grub_genie/requestfood.dart';
import 'package:page_transition/page_transition.dart';
import 'package:grub_genie/chatbot_button.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class UserHome extends StatefulWidget {
  const UserHome({super.key});

  @override
  State<UserHome> createState() => _UserHomeState();
}

class _UserHomeState extends State<UserHome> {
  bool isChatbotMinimized = false;
  String greetingMessage = '';
  String username = '';
  final FlutterSecureStorage _secureStorage = FlutterSecureStorage();

  @override
  void initState() {
    super.initState();
    _loadUsername();
    _updateGreetingMessage();
  }

  void _loadUsername() async {
    String? storedUsername = await _secureStorage.read(key: 'userName');
    setState(() {
      username = storedUsername ?? 'User';
    });
  }

  void _updateGreetingMessage() {
    DateTime now = DateTime.now();
    int hour = now.hour;

    setState(() {
      if (hour < 12) {
        greetingMessage = 'Good morning';
      } else if (hour < 18) {
        greetingMessage = 'Good afternoon';
      } else {
        greetingMessage = 'Good evening';
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        alignment: Alignment.center,
        children: [
          Container(
            alignment: Alignment.center,
            color: Colors.lightBlue,
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    greetingMessage,
                    style:
                        GoogleFonts.oswald(color: Colors.black, fontSize: 40),
                  ),
                  Text(
                    username,
                    style: GoogleFonts.oswald(
                        color: Colors.red.shade300, fontSize: 40),
                  ),
                  const Padding(padding: EdgeInsets.all(30)),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        PageTransition(
                          child: const FoodList(),
                          type: PageTransitionType.rightToLeft,
                          duration: const Duration(milliseconds: 700),
                        ),
                      );
                    },
                    style: ButtonStyle(
                      backgroundColor:
                          MaterialStatePropertyAll(Colors.green.shade300),
                    ),
                    child: Text(
                      "Food Near Me",
                      style: GoogleFonts.josefinSans(
                        color: Colors.black87,
                        fontSize: 16,
                      ),
                    ),
                  ),
                  const Padding(padding: EdgeInsets.all(5)),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        PageTransition(
                          child: const RequestFood(),
                          type: PageTransitionType.rightToLeft,
                          duration: const Duration(milliseconds: 700),
                        ),
                      );
                    },
                    style: ButtonStyle(
                      backgroundColor:
                          MaterialStatePropertyAll(Colors.green.shade300),
                    ),
                    child: Text(
                      "Request Food",
                      style: GoogleFonts.josefinSans(
                        color: Colors.black87,
                        fontSize: 16,
                      ),
                    ),
                  ),
                  const Padding(padding: EdgeInsets.all(30)),
                  ElevatedButton(
                    onPressed: () async {
                      await _secureStorage.delete(key: 'token');
                      await _secureStorage.delete(key: 'userId');
                      await _secureStorage.delete(key: 'userName');
                      Navigator.pushReplacement(
                        context,
                        PageTransition(
                          child: const NewHome(),
                          type: PageTransitionType.rightToLeft,
                          duration: const Duration(milliseconds: 700),
                        ),
                      );
                    },
                    style: ButtonStyle(
                      backgroundColor:
                          MaterialStatePropertyAll(Colors.red.shade300),
                    ),
                    child: Text(
                      "Sign Out",
                      style: GoogleFonts.josefinSans(
                        color: Colors.black87,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          ChatbotButton(
            onPressed: () {
              setState(() {
                isChatbotMinimized = !isChatbotMinimized;
              });
            },
          ),
        ],
      ),
    );
  }
}
