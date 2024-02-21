import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:grub_genie/chatbot_button.dart';

class Registration extends StatefulWidget {
  const Registration({Key? key}) : super(key: key);

  @override
  _RegistrationState createState() => _RegistrationState();
}

class _RegistrationState extends State<Registration> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  bool isChatbotMinimized = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.blue, Colors.lightBlue],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                "Registration",
                style: GoogleFonts.oswald(color: Colors.black, fontSize: 40),
                textAlign: TextAlign.center,
              ),
              const Padding(padding: EdgeInsets.all(20)),
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Email',
                  labelStyle: GoogleFonts.josefinSans(
                    color: Colors.black87,
                    fontSize: 16,
                  ),
                  filled: true,
                  fillColor: Colors.white.withOpacity(0.5),
                ),
                keyboardType: TextInputType.emailAddress,
              ),
              const Padding(padding: EdgeInsets.all(10)),
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Password',
                  labelStyle: GoogleFonts.josefinSans(
                    color: Colors.black87,
                    fontSize: 16,
                  ),
                  filled: true,
                  fillColor: Colors.white.withOpacity(0.5),
                ),
                obscureText: true,
              ),
              const Padding(padding: EdgeInsets.all(20)),
              ElevatedButton(
                onPressed: () {},
                style: ButtonStyle(
                  backgroundColor:
                      MaterialStatePropertyAll(Colors.green.shade300),
                ),
                child: Text(
                  "Register",
                  style: GoogleFonts.josefinSans(
                    color: Colors.black87,
                    fontSize: 16,
                  ),
                ),
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
          ),
        ),
      ),
    );
  }
}
