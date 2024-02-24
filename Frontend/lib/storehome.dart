import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:page_transition/page_transition.dart';
import 'package:grub_genie/chatbot_button.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:grub_genie/food_item_registration.dart';

class StoreHome extends StatefulWidget {
  const StoreHome({Key? key}) : super(key: key);

  @override
  _StoreHomeState createState() => _StoreHomeState();
}

class _StoreHomeState extends State<StoreHome> {
  bool isChatbotMinimized = false;
  String greetingMessage = '';
  String storeName = '';
  final FlutterSecureStorage _secureStorage = FlutterSecureStorage();

  @override
  void initState() {
    super.initState();
    _loadStoreName();
    _updateGreetingMessage();
  }

  void _loadStoreName() async {
    String? storedStoreName = await _secureStorage.read(key: 'storeName');
    setState(() {
      storeName = storedStoreName ?? 'Store';
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
    return Stack(
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
                  "$greetingMessage $storeName!",
                  style: GoogleFonts.oswald(color: Colors.black, fontSize: 40),
                ),
                const Padding(padding: EdgeInsets.all(30)),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      PageTransition(
                        child: const FoodItemRegistration(),
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
                    "Food Item Registration",
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
                    await _secureStorage.delete(key: 'storeId');
                    await _secureStorage.delete(key: 'storeName');
                    Navigator.pop(context);
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
    );
  }
}