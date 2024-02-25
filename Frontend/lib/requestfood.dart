import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:jiffy/jiffy.dart';

import 'chatbot_button.dart';

class RequestFood extends StatefulWidget {
  const RequestFood({Key? key}) : super(key: key);

  @override
  _RequestFoodState createState() => _RequestFoodState();
}

class _RequestFoodState extends State<RequestFood> {
  String? selectedFoodItem = '';
  int quantity = 1;
  DateTime? preferredExpirationDate;
  String additionalNotes = '';
  String location = '';
  double maxDistance = 0.0;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  List<String> foodItems = [
    'Maggi Masala 1-Pack',
    'iD Chapati 350g',
  ];

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
                  DropdownMenu<String>(
                    width: MediaQuery.of(context).size.width * 0.9,
                    inputDecorationTheme: InputDecorationTheme(
                      filled: true,
                      fillColor: const Color(0xffb8e4fc),
                    ),
                    initialSelection: selectedFoodItem,
                    label: Text(
                      'Food Item',
                      style: GoogleFonts.josefinSans(
                        color: Colors.black87,
                        fontSize: 16,
                      ),
                    ),
                    onSelected: (String? foodItem) {
                      setState(() {
                        selectedFoodItem = foodItem;
                      });
                    },
                    dropdownMenuEntries: foodItems
                        .map<DropdownMenuEntry<String>>(
                          (String foodItem) => DropdownMenuEntry<String>(
                            value: foodItem,
                            label: foodItem,
                          ),
                        )
                        .toList(),
                  ),
                  const Padding(padding: EdgeInsets.all(10)),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Quantity',
                        style: GoogleFonts.josefinSans(
                          color: Colors.black87,
                          fontSize: 16,
                        ),
                      ),
                      Row(
                        children: [
                          IconButton(
                            icon: const Icon(Icons.remove),
                            onPressed: () {
                              setState(() {
                                if (quantity > 1) quantity--;
                              });
                            },
                          ),
                          Text(
                            '$quantity',
                            style: GoogleFonts.josefinSans(
                              color: Colors.black87,
                              fontSize: 16,
                            ),
                          ),
                          IconButton(
                            icon: const Icon(Icons.add),
                            onPressed: () {
                              setState(() {
                                quantity++;
                              });
                            },
                          ),
                        ],
                      ),
                    ],
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
                  TextFormField(
                    decoration: InputDecoration(
                        labelText: 'Location',
                        labelStyle: GoogleFonts.josefinSans(
                          color: Colors.black87,
                          fontSize: 16,
                        ),
                        filled: true,
                        fillColor: const Color(0xffb8e4fc)),
                    onChanged: (value) {
                      setState(() {
                        location = value;
                      });
                    },
                  ),
                  const Padding(padding: EdgeInsets.all(10)),
                  TextFormField(
                    decoration: InputDecoration(
                      labelText: 'Max Distance (in km)',
                      labelStyle: GoogleFonts.josefinSans(
                        color: Colors.black87,
                        fontSize: 16,
                      ),
                      filled: true,
                      fillColor: const Color(0xffb8e4fc),
                    ),
                    keyboardType: TextInputType.number,
                    onChanged: (value) {
                      setState(() {
                        maxDistance = double.tryParse(value) ?? 0.0;
                      });
                    },
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
        ChatbotButton(
          onPressed: () {
            // Handle the chatbot button press
            // You can implement the logic to open/minimize the chatbot here
          },
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
              onPressed: () {
                Navigator.pop(context);
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
