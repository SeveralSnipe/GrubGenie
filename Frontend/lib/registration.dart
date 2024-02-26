import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:grub_genie/Api code/service/registerstore_service.dart';
import 'package:grub_genie/Api code/service/registeruser_service.dart';
import 'package:grub_genie/mapsregistration.dart';
import 'package:jiffy/jiffy.dart';
import 'package:page_transition/page_transition.dart';

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
  int registrationType = 1;
  String? dob;
  var mapResult = [0.0, 0.0];

  void _showMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
      ),
    );
  }

  String? _validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter Email';
    }
    if (!RegExp(r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$')
        .hasMatch(value)) {
      return 'Please enter a valid Email';
    }
    return null;
  }

  String? _validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter Password';
    }
    if (value.length < 6) {
      return 'Password must be at least 6 characters long';
    }
    return null;
  }

  String? _validateText(String? value, String fieldName) {
    if (value == null || value.isEmpty) {
      return 'Please enter $fieldName';
    }
    return null;
  }

  String? _validatePhoneNumber(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter Phone Number';
    }
    if (!RegExp(r'^\d{10}$').hasMatch(value)) {
      return 'Please enter a valid 10-digit Phone Number';
    }
    return null;
  }

  bool _validateForm() {
    if (_validateEmail(emailController.text) != null) {
      _showMessage(_validateEmail(emailController.text)!);
      return false;
    }

    if (_validatePassword(passwordController.text) != null) {
      _showMessage(_validatePassword(passwordController.text)!);
      return false;
    }

    if (registrationType == 1) {
      if (dob == null) {
        _showMessage("Please select Date of Birth");
        return false;
      }

      if (_validatePhoneNumber(phoneNumberController.text) != null) {
        _showMessage(_validatePhoneNumber(phoneNumberController.text)!);
        return false;
      }

      if (_validateText(userNameController.text, 'UserName') != null) {
        _showMessage(_validateText(userNameController.text, 'UserName')!);
        return false;
      }
    } else if (registrationType == 2) {
      if (_validateText(gstController.text, 'GST') != null) {
        _showMessage(_validateText(gstController.text, 'GST')!);
        return false;
      }

      if (mapResult[0] == 0.0 || mapResult[1] == 0.0) {
        _showMessage("Please mark the store location");
        return false;
      }

      if (_validatePhoneNumber(storePhoneNumberController.text) != null) {
        _showMessage(_validatePhoneNumber(storePhoneNumberController.text)!);
        return false;
      }

      if (_validateText(storeNameController.text, 'StoreName') != null) {
        _showMessage(_validateText(storeNameController.text, 'StoreName')!);
        return false;
      }
    }

    return true;
  }

  Future<void> _mapSelect(BuildContext context) async {
    var temp = await Navigator.push(
      context,
      PageTransition(
        child: MapPage(),
        type: PageTransitionType.rightToLeft,
        duration: const Duration(milliseconds: 700),
      ),
    );
    mapResult = temp;
  }

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

            TextFormField(
              controller: emailController,
              decoration: InputDecoration(
                labelText: 'Email',
                labelStyle: GoogleFonts.josefinSans(
                  color: Colors.black87,
                  fontSize: 16,
                ),
                filled: true,
                fillColor: const Color(0xffb8e4fc),
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
                fillColor: const Color(0xffb8e4fc),
              ),
              obscureText: true,
            ),
            const Padding(padding: EdgeInsets.all(10)),
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
                  fillColor: const Color(0xffb8e4fc),
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
                  fillColor: const Color(0xffb8e4fc),
                ),
                keyboardType: TextInputType.text,
              ),
            ],
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
                  fillColor: const Color(0xffb8e4fc),
                ),
                keyboardType: TextInputType.number,
              ),
              const Padding(padding: EdgeInsets.all(10)),
              ElevatedButton(
                onPressed: () {
                  _mapSelect(context);
                },
                style: ButtonStyle(
                  backgroundColor:
                      MaterialStatePropertyAll(Colors.green.shade300),
                ),
                child: Text(
                  "Mark Location",
                  style: GoogleFonts.josefinSans(
                    color: Colors.black87,
                    fontSize: 16,
                  ),
                ),
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
                  fillColor: const Color(0xffb8e4fc),
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
                  fillColor: const Color(0xffb8e4fc),
                ),
                keyboardType: TextInputType.text,
              ),
            ],
            const Padding(padding: EdgeInsets.all(20)),
            ElevatedButton(
              onPressed: () async {
                if (_validateForm()) {
                  try {
                    if (registrationType == 1) {
                      final result = await RegisterUserService().registerUser(
                        userName: userNameController.text,
                        dob: dob!,
                        email: emailController.text,
                        phoneNumber: phoneNumberController.text,
                        password: passwordController.text,
                      );
                      if (result != null) {
                        print(result.userId);
                        _showMessage("User registered successfully!");
                      } else {
                        _showMessage("User registration failed");
                      }
                    } else if (registrationType == 2) {
                      final result = await RegisterStoreService().registerStore(
                        storeName: storeNameController.text,
                        gst: gstController.text,
                        email: emailController.text,
                        location: [mapResult[0], mapResult[1]],
                        phoneNumber: storePhoneNumberController.text,
                        password: passwordController.text,
                      );

                      if (result != null) {
                        print(result.storeId);
                        _showMessage("Store registered successfully!");
                      } else {
                        _showMessage("Store registration failed!");
                      }
                    }
                  } catch (e) {
                    print('Error during registration: $e');
                    _showMessage(
                        "An error occurred during registration. Please try again.");
                  }
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
