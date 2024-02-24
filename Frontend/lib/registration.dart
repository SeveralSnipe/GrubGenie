import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:grub_genie/Api code/service/registerstore_service.dart';
import 'package:grub_genie/Api code/service/registeruser_service.dart';
import 'package:jiffy/jiffy.dart';

class Registration extends StatefulWidget {
  const Registration({Key? key}) : super(key: key);

  @override
  _RegistrationState createState() => _RegistrationState();
}

class _RegistrationState extends State<Registration> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController phoneNumberController = TextEditingController();
  final TextEditingController userNameController = TextEditingController();
  final TextEditingController gstController = TextEditingController();
  final TextEditingController locationController = TextEditingController();
  final TextEditingController storePhoneNumberController =
      TextEditingController();
  final TextEditingController storeNameController = TextEditingController();
  int registrationType = 1; // 1 for user, 2 for store
  String? dob;
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      color: Colors.lightBlue,
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Registration",
              style:
                  GoogleFonts.josefinSans(color: Colors.black87, fontSize: 30),
            ),
            const Padding(padding: EdgeInsets.all(20)),
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
            const Padding(padding: EdgeInsets.all(10)),

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
                fillColor: const Color(0xfffb8e4fc),
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
                fillColor: const Color(0xfffb8e4fc),
              ),
              obscureText: true,
            ),
            const Padding(padding: EdgeInsets.all(10)),
            // User registration fields
            if (registrationType == 1) ...[
              ElevatedButton(
                onPressed: () async {
                  DateTime? pickedDate = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(1900),
                    lastDate: DateTime.now(),
                  );

                  if (pickedDate != null &&
                      pickedDate.toString().split(' ')[0] != dob) {
                    setState(() {
                      dob = pickedDate.toString().split(' ')[0];
                    });
                  }
                },
                style: ButtonStyle(
                  backgroundColor:
                      MaterialStatePropertyAll(Colors.red.shade300),
                ),
                child: Text(
                  dob != null
                      ? 'DOB: ${Jiffy.parse(dob!, pattern: 'yyyy-MM-dd').yMMMMd}'
                      : 'Select DOB',
                  style: GoogleFonts.josefinSans(
                    color: Colors.black87,
                    fontSize: 16,
                  ),
                ),
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
                  fillColor: const Color(0xfffb8e4fc),
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
                  fillColor: const Color(0xfffb8e4fc),
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
                  fillColor: const Color(0xfffb8e4fc),
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
                  fillColor: const Color(0xfffb8e4fc),
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
                  fillColor: const Color(0xfffb8e4fc),
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
                  fillColor: const Color(0xfffb8e4fc),
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
                    final result = await RegisterUserService().registerUser(
                      userName: userNameController.text,
                      dob: dob!,
                      email: emailController.text,
                      phoneNumber: phoneNumberController.text,
                      password: passwordController.text,
                    );
                    print(result);

                    // Handle result accordingly
                    if (result != null) {
                      // User registration successful, you can navigate to another screen or perform additional actions.
                      print(
                          "User registered successfully with ID: ${result.userId}");
                    } else {
                      // User registration failed
                      print("User registration failed");
                    }
                  } else if (registrationType == 2) {
                    final result = await RegisterStoreService().registerStore(
                      storeName: storeNameController.text,
                      gst: gstController.text,
                      email: emailController.text,
                      location: [13.113715408791111, 80.21668124172232],
                      phoneNumber: storePhoneNumberController.text,
                      password: passwordController.text,
                    );

                    // Handle result accordingly
                    if (result != null) {
                      // Store registration successful, you can navigate to another screen or perform additional actions.
                      print(
                          "Store registered successfully with ID: ${result.storeId}");
                    } else {
                      // Store registration failed
                      print("Store registration failed");
                    }
                  }
                } catch (e) {
                  // Handle errors if any
                  print('Error during registration: $e');
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
    );
  }
}
