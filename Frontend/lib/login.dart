import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:grub_genie/Api code/service/storelogin_service.dart';
import 'package:grub_genie/Api code/service/userlogin_service.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:page_transition/page_transition.dart';
import 'package:grub_genie/userhome.dart';
import 'package:grub_genie/storehome.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  int loginType = 1;
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final FlutterSecureStorage _secureStorage = FlutterSecureStorage();

  void _showMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
      ),
    );
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
                  "Login",
                  style: GoogleFonts.josefinSans(
                      color: Colors.black87, fontSize: 30),
                ),
                const Padding(padding: EdgeInsets.all(20)),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Radio(
                      value: 1,
                      groupValue: loginType,
                      onChanged: (value) {
                        setState(() {
                          loginType = value as int;
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
                      groupValue: loginType,
                      onChanged: (value) {
                        setState(() {
                          loginType = value as int;
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
                const Padding(padding: EdgeInsets.all(20)),
                ElevatedButton(
                  onPressed: () async {
                    try {
                      if (loginType == 1) {
                        final result = await UserLoginService().userLogin(
                          identifier: emailController.text,
                          password: passwordController.text,
                        );
                        if (result != null) {
                          print(result.userId);
                          _showMessage("User logged in successfully!");
                          await _secureStorage.write(
                            key: 'token',
                            value: result.token,
                          );
                          await _secureStorage.write(
                            key: 'userId',
                            value: result.userId,
                          );
                          await _secureStorage.write(
                            key: 'userName',
                            value: result.userName,
                          );
                          Navigator.pushReplacement(
                            context,
                            PageTransition(
                              child: const UserHome(),
                              type: PageTransitionType.rightToLeft,
                              duration: const Duration(milliseconds: 700),
                            ),
                          );
                        } else {
                          _showMessage("Invalid username or password.");
                        }
                      } else if (loginType == 2) {
                        final result = await StoreLoginService().storeLogin(
                          identifier: emailController.text,
                          password: passwordController.text,
                        );

                        if (result != null) {
                          print(result.storeId);
                          _showMessage("Store logged in successfully!");
                          await _secureStorage.write(
                            key: 'token',
                            value: result.token,
                          );
                          await _secureStorage.write(
                            key: 'storeId',
                            value: result.storeId,
                          );
                          await _secureStorage.write(
                            key: 'storeName',
                            value: result.storeName,
                          );
                          Navigator.pushReplacement(
                            context,
                            PageTransition(
                              child: const StoreHome(),
                              type: PageTransitionType.rightToLeft,
                              duration: const Duration(milliseconds: 700),
                            ),
                          );
                        } else {
                          _showMessage("Invalid username or password.");
                        }
                      }
                    } catch (e) {
                      print('Error during login: $e');
                      _showMessage(
                          "An error occurred during login. Please try again.");
                    }
                  },
                  style: ButtonStyle(
                    backgroundColor:
                        MaterialStatePropertyAll(Colors.green.shade300),
                  ),
                  child: Text(
                    "Login",
                    style: GoogleFonts.josefinSans(
                      color: Colors.black87,
                      fontSize: 16,
                    ),
                  ),
                ),
              ],
            )));
  }
}
