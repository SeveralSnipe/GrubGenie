import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:jiffy/jiffy.dart';

class FoodItemRegistration extends StatefulWidget {
  const FoodItemRegistration({Key? key}) : super(key: key);

  @override
  _FoodItemRegistrationState createState() => _FoodItemRegistrationState();
}

class _FoodItemRegistrationState extends State<FoodItemRegistration> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  DateTime? expiryDate;
  double? itemMRP;
  double? itemSP;
  String? itemName;
  int? stockQuantity;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Food Item Registration"),
          backgroundColor: const Color(0xfffb8e4fc),
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
                    ElevatedButton(
                      onPressed: () async {
                        DateTime? pickedDate = await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime.now(),
                          lastDate: DateTime(DateTime.now().year + 1),
                        );

                        if (pickedDate != null && pickedDate != expiryDate) {
                          setState(() {
                            expiryDate = pickedDate;
                          });
                        }
                      },
                      style: ButtonStyle(
                        backgroundColor:
                            MaterialStatePropertyAll(Colors.red.shade300),
                      ),
                      child: Text(
                        expiryDate != null ? 'Change Date' : 'Pick Date',
                        style: GoogleFonts.josefinSans(
                          color: Colors.black87,
                          fontSize: 16,
                        ),
                      ),
                    ),
                    if (expiryDate != null)
                      Padding(
                        padding: const EdgeInsets.all(10),
                        child: Text(
                          'Expiry Date: ${Jiffy.parseFromDateTime(expiryDate!).yMMMMd}',
                          style: GoogleFonts.josefinSans(
                            color: Colors.black87,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    const Padding(padding: EdgeInsets.all(10)),
                    TextFormField(
                      decoration: InputDecoration(
                        labelText: 'Item MRP',
                        labelStyle: GoogleFonts.josefinSans(
                          color: Colors.black87,
                          fontSize: 16,
                        ),
                        filled: true,
                        fillColor: const Color(0xfffb8e4fc),
                      ),
                      keyboardType: TextInputType.number,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter Item MRP';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        itemMRP = double.tryParse(value!);
                      },
                    ),
                    const Padding(padding: EdgeInsets.all(10)),
                    TextFormField(
                      decoration: InputDecoration(
                        labelText: 'Item Selling Price',
                        labelStyle: GoogleFonts.josefinSans(
                          color: Colors.black87,
                          fontSize: 16,
                        ),
                        filled: true,
                        fillColor: const Color(0xfffb8e4fc),
                      ),
                      keyboardType: TextInputType.number,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter Item Selling Price';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        itemSP = double.tryParse(value!);
                      },
                    ),
                    const Padding(padding: EdgeInsets.all(10)),
                    TextFormField(
                      decoration: InputDecoration(
                        labelText: 'Item Name',
                        labelStyle: GoogleFonts.josefinSans(
                          color: Colors.black87,
                          fontSize: 16,
                        ),
                        filled: true,
                        fillColor: const Color(0xfffb8e4fc),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter Item Name';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        itemName = value!;
                      },
                    ),
                    const Padding(padding: EdgeInsets.all(10)),
                    TextFormField(
                      decoration: InputDecoration(
                        labelText: 'Stock Quantity',
                        labelStyle: GoogleFonts.josefinSans(
                          color: Colors.black87,
                          fontSize: 16,
                        ),
                        filled: true,
                        fillColor: const Color(0xfffb8e4fc),
                      ),
                      keyboardType: TextInputType.number,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter Stock Quantity';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        stockQuantity = int.tryParse(value!);
                      },
                    ),
                    const Padding(padding: EdgeInsets.all(20)),
                    ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState?.validate() ?? false) {
                          _formKey.currentState?.save();
                          // Now you can send the registration data to your backend
                          // (expiryDate, itemMRP, itemSP, itemName, stockQuantity)
                          // Handle the registration logic here
                        }
                      },
                      style: ButtonStyle(
                        backgroundColor:
                            MaterialStatePropertyAll(Colors.green.shade300),
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
              ),
            ),
          )
        ]));
  }
}
