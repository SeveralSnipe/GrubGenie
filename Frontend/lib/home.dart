import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:grub_genie/apiplayground.dart';
import 'package:grub_genie/nearfood.dart';
import 'package:grub_genie/requestfood.dart';
import 'package:grub_genie/login.dart';
import 'package:grub_genie/registration.dart';
import 'package:page_transition/page_transition.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Column(
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
                child: const Login(),
                type: PageTransitionType.rightToLeft,
                duration: const Duration(milliseconds: 700),
              ),
            );
          },
          style: ButtonStyle(
            backgroundColor: MaterialStatePropertyAll(Colors.red.shade300),
          ),
          child: Text(
            "Login",
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
                child: const Registration(),
                type: PageTransitionType.rightToLeft,
                duration: const Duration(milliseconds: 700),
              ),
            );
          },
          style: ButtonStyle(
            backgroundColor: MaterialStatePropertyAll(Colors.red.shade300),
          ),
          child: Text(
            "Registration",
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
      ],
    );
  }
}
