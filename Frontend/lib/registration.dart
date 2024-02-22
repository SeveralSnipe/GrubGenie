import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Registration extends StatefulWidget {
  const Registration({Key? key}) : super(key: key);

  @override
  _RegistrationState createState() => _RegistrationState();
}

class _RegistrationState extends State<Registration> {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Form controllers
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  // User registration specific fields
  final TextEditingController dobController = TextEditingController();
  final TextEditingController phoneNumberController = TextEditingController();
  final TextEditingController userNameController = TextEditingController();

  // Store registration specific fields
  final TextEditingController gstController = TextEditingController();
  final TextEditingController locationController = TextEditingController();
  final TextEditingController storePhoneNumberController =
      TextEditingController();
  final TextEditingController storeNameController = TextEditingController();

  // Radio button group value
  int registrationType = 1; // 1 for user, 2 for store

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
              // Radio buttons for user and store registration
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Radio(
                    value: 1,
                    groupValue: registrationType,
                    onChanged: (value) {
                      setState(() {
                        registrationType = value as int;
                      });
                    },
                  ),
                  Text(
                    'User',
                    style: GoogleFonts.josefinSans(
                      color: Colors.black87,
                      fontSize: 16,
                    ),
                  ),
                  Radio(
                    value: 2,
                    groupValue: registrationType,
                    onChanged: (value) {
                      setState(() {
                        registrationType = value as int;
                      });
                    },
                  ),
                  Text(
                    'Store',
                    style: GoogleFonts.josefinSans(
                      color: Colors.black87,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
              // Email and password fields
              TextFormField(
                controller: emailController,
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
                controller: passwordController,
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
              const Padding(padding: EdgeInsets.all(10)),
              // User registration fields
              if (registrationType == 1) ...[
                TextFormField(
                  controller: dobController,
                  decoration: InputDecoration(
                    labelText: 'DOB',
                    labelStyle: GoogleFonts.josefinSans(
                      color: Colors.black87,
                      fontSize: 16,
                    ),
                    filled: true,
                    fillColor: Colors.white.withOpacity(0.5),
                  ),
                  keyboardType: TextInputType.text,
                ),
                const Padding(padding: EdgeInsets.all(10)),
                TextFormField(
                  controller: phoneNumberController,
                  decoration: InputDecoration(
                    labelText: 'PhoneNumber',
                    labelStyle: GoogleFonts.josefinSans(
                      color: Colors.black87,
                      fontSize: 16,
                    ),
                    filled: true,
                    fillColor: Colors.white.withOpacity(0.5),
                  ),
                  keyboardType: TextInputType.number,
                ),
                const Padding(padding: EdgeInsets.all(10)),
                TextFormField(
                  controller: userNameController,
                  decoration: InputDecoration(
                    labelText: 'UserName',
                    labelStyle: GoogleFonts.josefinSans(
                      color: Colors.black87,
                      fontSize: 16,
                    ),
                    filled: true,
                    fillColor: Colors.white.withOpacity(0.5),
                  ),
                  keyboardType: TextInputType.text,
                ),
              ],
              // Store registration fields
              if (registrationType == 2) ...[
                TextFormField(
                  controller: gstController,
                  decoration: InputDecoration(
                    labelText: 'GST',
                    labelStyle: GoogleFonts.josefinSans(
                      color: Colors.black87,
                      fontSize: 16,
                    ),
                    filled: true,
                    fillColor: Colors.white.withOpacity(0.5),
                  ),
                  keyboardType: TextInputType.number,
                ),
                const Padding(padding: EdgeInsets.all(10)),
                TextFormField(
                  controller: locationController,
                  decoration: InputDecoration(
                    labelText: 'Location',
                    labelStyle: GoogleFonts.josefinSans(
                      color: Colors.black87,
                      fontSize: 16,
                    ),
                    filled: true,
                    fillColor: Colors.white.withOpacity(0.5),
                  ),
                  keyboardType: TextInputType.text,
                ),
                const Padding(padding: EdgeInsets.all(10)),
                TextFormField(
                  controller: storePhoneNumberController,
                  decoration: InputDecoration(
                    labelText: 'PhoneNumber',
                    labelStyle: GoogleFonts.josefinSans(
                      color: Colors.black87,
                      fontSize: 16,
                    ),
                    filled: true,
                    fillColor: Colors.white.withOpacity(0.5),
                  ),
                  keyboardType: TextInputType.number,
                ),
                const Padding(padding: EdgeInsets.all(10)),
                TextFormField(
                  controller: storeNameController,
                  decoration: InputDecoration(
                    labelText: 'StoreName',
                    labelStyle: GoogleFonts.josefinSans(
                      color: Colors.black87,
                      fontSize: 16,
                    ),
                    filled: true,
                    fillColor: Colors.white.withOpacity(0.5),
                  ),
                  keyboardType: TextInputType.text,
                ),
              ],
              const Padding(padding: EdgeInsets.all(20)),
              ElevatedButton(
                onPressed: () async {
                  try {
                    if (registrationType == 1) {
                      // User registration logic
                      final credential = await FirebaseAuth.instance
                          .createUserWithEmailAndPassword(
                        email: emailController.text,
                        password: passwordController.text,
                      );

                      // Additional user registration logic with dob, phoneNumber, userName
                      // Access values from dobController.text, phoneNumberController.text, userNameController.text
                    } else if (registrationType == 2) {
                      // Store registration logic
                      final credential = await FirebaseAuth.instance
                          .createUserWithEmailAndPassword(
                        email: emailController.text,
                        password: passwordController.text,
                      );

                      // Additional store registration logic with gst, location, storePhoneNumber, storeName
                      // Access values from gstController.text, locationController.text, storePhoneNumberController.text, storeNameController.text
                    }

                    // Successful registration, you can navigate to another screen or perform additional actions.
                  } on FirebaseAuthException catch (e) {
                    if (e.code == 'weak-password') {
                      print('The password provided is too weak.');
                    } else if (e.code == 'email-already-in-use') {
                      print('The account already exists for that email.');
                    } else {
                      print('Error: $e');
                    }
                  } catch (e) {
                    print('Error: $e');
                  }
                },
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
            ],
          ),
        ),
      ),
    );
  }
}
