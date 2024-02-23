import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:grub_genie/Api code/service/storelogin_service.dart';
import 'package:grub_genie/Api code/service/userlogin_service.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  int loginType = 1; // 1 for user, 2 for store
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Login"),
        backgroundColor: const Color(0xfffb8e4fc),
      ),
      body: Stack(alignment: Alignment.center, children: [
        Container(
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
                const Padding(padding: EdgeInsets.all(20)),
                ElevatedButton(
                  onPressed: () async {
                    try {
                      if (loginType == 1) {
                        final result = await UserLoginService().userLogin(
                          identifier: emailController.text,
                          password: passwordController.text,
                        );
                        print(result);

                        // Handle result accordingly
                        if (result != null) {
                          // User registration successful, you can navigate to another screen or perform additional actions.
                          print(
                              "User logged in successfully with ID: ${result.userId}");
                        } else {
                          // User registration failed
                          print("User login failed");
                        }
                      } else if (loginType == 2) {
                        final result = await StoreLoginService().storeLogin(
                          identifier: emailController.text,
                          password: passwordController.text,
                        );

                        // Handle result accordingly
                        if (result != null) {
                          // Store registration successful, you can navigate to another screen or perform additional actions.
                          print(
                              "Store logged in successfully with ID: ${result.storeId}");
                        } else {
                          // Store registration failed
                          print("Store registration failed");
                        }
                      }
                    } catch (e) {
                      // Handle errors if any
                      print('Error during login: $e');
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
            ),
          ),
        )
      ]),
    );
  }
}
