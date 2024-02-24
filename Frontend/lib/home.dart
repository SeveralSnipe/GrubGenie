import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:grub_genie/apiplayground.dart';
import 'package:grub_genie/nearfood.dart';
import 'package:grub_genie/requestfood.dart';
import 'package:grub_genie/newhome.dart';
import 'package:page_transition/page_transition.dart';
import 'package:grub_genie/chatbot_button.dart';
import 'package:grub_genie/food_item_registration.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  bool isChatbotMinimized = false;
  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "GrubGenie",
              style: GoogleFonts.oswald(color: Colors.black, fontSize: 40),
            ),
            const Padding(padding: EdgeInsets.all(30)),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                    context,
                    PageTransition(
                        child: const FoodList(),
                        type: PageTransitionType.rightToLeft,
                        duration: const Duration(milliseconds: 700)));
              },
              style: ButtonStyle(
                backgroundColor: MaterialStatePropertyAll(Colors.red.shade300),
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
                backgroundColor: MaterialStatePropertyAll(Colors.red.shade300),
              ),
              child: Text(
                "Request Food",
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
                    child: const NewHome(),
                    type: PageTransitionType.rightToLeft,
                    duration: const Duration(milliseconds: 700),
                  ),
                );
              },
              style: ButtonStyle(
                backgroundColor: MaterialStatePropertyAll(Colors.red.shade300),
              ),
              child: Text(
                "New Home",
                style: GoogleFonts.josefinSans(
                  color: Colors.black87,
                  fontSize: 16,
                ),
              ),
            ),
            const Padding(padding: EdgeInsets.all(30)),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                    context,
                    PageTransition(
                        child: const ApiTest(),
                        type: PageTransitionType.rightToLeft,
                        duration: const Duration(milliseconds: 700)));
              },
              style: ButtonStyle(
                backgroundColor: MaterialStatePropertyAll(Colors.red.shade300),
              ),
              child: Text(
                "Test",
                style: GoogleFonts.josefinSans(
                  color: Colors.black87,
                  fontSize: 16,
                ),
              ),
            ),
            const Padding(padding: EdgeInsets.all(30)),
            // ... Existing buttons ...

            ElevatedButton(
              onPressed: () {
                // Navigate to FoodItemRegistration page
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
                backgroundColor: MaterialStatePropertyAll(Colors.red.shade300),
              ),
              child: Text(
                "Register Food Item",
                style: GoogleFonts.josefinSans(
                  color: Colors.black87,
                  fontSize: 16,
                ),
              ),
            ),
          ],
        ),
        ChatbotButton(
          onPressed: () {
            // Handle the chatbot button press
            // You can implement the logic to open/minimize the chatbot here
            setState(() {
              isChatbotMinimized = !isChatbotMinimized;
            });
          },
        ),
      ],
    );
  }
}
