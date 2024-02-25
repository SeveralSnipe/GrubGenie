import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:grub_genie/Api%20code/service/requestfood_service.dart';
import 'package:grub_genie/Api%20code/service/unmappedrequest_service.dart';
import 'package:page_transition/page_transition.dart';

import 'chatbot_button.dart';
import 'mapsregistration.dart';

class RequestFood extends StatefulWidget {
  const RequestFood({Key? key}) : super(key: key);

  @override
  _RequestFoodState createState() => _RequestFoodState();
}

class _RequestFoodState extends State<RequestFood> {
  String? selectedFoodItem = '';
  int quantity = 1;
  double preferredPrice = 0;
  String additionalNotes = '';
  String location = '';
  String username = '';
  List<double> mapResult = [0.0, 0.0];
  final FlutterSecureStorage _secureStorage = FlutterSecureStorage();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

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
  void initState() {
    // TODO: implement initState
    super.initState();
    _loadUsername();
  }

  void _loadUsername() async {
    String? storedUsername = await _secureStorage.read(key: 'userName');
    setState(() {
      username = storedUsername ?? 'User';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Request Food"),
        backgroundColor: const Color(0xffb8e4fc),
      ),
      body: Stack(alignment: Alignment.center, children: [
        Container(
          alignment: Alignment.center,
          color: Colors.lightBlue,
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  TextFormField(
                    decoration: InputDecoration(
                        labelText: 'Requested Item',
                        labelStyle: GoogleFonts.josefinSans(
                          color: Colors.black87,
                          fontSize: 16,
                        ),
                        filled: true,
                        fillColor: const Color(0xffb8e4fc)),
                    maxLines: 3,
                    onChanged: (value) {
                      setState(() {
                        selectedFoodItem = value;
                      });
                    },
                  ),
                  const Padding(padding: EdgeInsets.all(10)),
                  TextFormField(
                    decoration: InputDecoration(
                        labelText: 'Preferred Price',
                        labelStyle: GoogleFonts.josefinSans(
                          color: Colors.black87,
                          fontSize: 16,
                        ),
                        filled: true,
                        fillColor: const Color(0xffb8e4fc)),
                    maxLines: 3,
                    keyboardType: TextInputType.number,
                    onChanged: (value) {
                      setState(() {
                        preferredPrice = value as double;
                      });
                    },
                  ),
                  const Padding(padding: EdgeInsets.all(10)),
                  TextFormField(
                    decoration: InputDecoration(
                        labelText: 'Quantity',
                        labelStyle: GoogleFonts.josefinSans(
                          color: Colors.black87,
                          fontSize: 16,
                        ),
                        filled: true,
                        fillColor: const Color(0xffb8e4fc)),
                    maxLines: 3,
                    keyboardType: TextInputType.number,
                    onChanged: (value) {
                      setState(() {
                        quantity = value as int;
                      });
                    },
                  ),
                  const Padding(padding: EdgeInsets.all(10)),
                  TextFormField(
                    decoration: InputDecoration(
                        labelText: 'Additional Notes',
                        labelStyle: GoogleFonts.josefinSans(
                          color: Colors.black87,
                          fontSize: 16,
                        ),
                        filled: true,
                        fillColor: const Color(0xffb8e4fc)),
                    maxLines: 3,
                    onChanged: (value) {
                      setState(() {
                        additionalNotes = value;
                      });
                    },
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
                  const Padding(padding: EdgeInsets.all(20)),
                  ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState?.validate() ?? false) {
                        showConfirmationDialog();
                      }
                    },
                    style: ButtonStyle(
                      backgroundColor:
                          MaterialStatePropertyAll(Colors.green.shade300),
                    ),
                    child: Text(
                      "Submit Request",
                      style: GoogleFonts.josefinSans(
                        color: Colors.black87,
                        fontSize: 16,
                      ),
                    ),
                  ),
                  const Padding(padding: EdgeInsets.all(10)),
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    style: ButtonStyle(
                      backgroundColor:
                          MaterialStatePropertyAll(Colors.red.shade300),
                    ),
                    child: Text(
                      "Cancel",
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
        ),
      ]),
    );
  }

  void showConfirmationDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.lightBlue,
          title: Text(
            'Confirm Submission',
            style: GoogleFonts.oswald(color: Colors.black, fontSize: 30),
          ),
          content: Text(
            'Are you sure you want to submit the food request?',
            style: GoogleFonts.josefinSans(
              color: Colors.black87,
              fontSize: 16,
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              style: ButtonStyle(
                backgroundColor: MaterialStatePropertyAll(Colors.red.shade300),
              ),
              child: Text(
                'Cancel',
                style: GoogleFonts.josefinSans(
                  color: Colors.black87,
                  fontSize: 16,
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () async {
                final result = await UnmappedRequestFoodService()
                    .submitUnmappedRequest(
                        location: mapResult,
                        userId: username,
                        item: {
                          "ItemName": selectedFoodItem,
                          "ItemQuantity": quantity
                        },
                        preferedPrice: preferredPrice,
                        additionalNotes: [additionalNotes]);
                if (context.mounted) {
                  Navigator.pop(context);
                }
              },
              style: ButtonStyle(
                backgroundColor:
                    MaterialStatePropertyAll(Colors.green.shade300),
              ),
              child: Text(
                'Submit',
                style: GoogleFonts.josefinSans(
                  color: Colors.black87,
                  fontSize: 16,
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
