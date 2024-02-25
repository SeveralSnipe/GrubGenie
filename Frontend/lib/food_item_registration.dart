import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:jiffy/jiffy.dart';
import 'package:grub_genie/Api code/service/registeritem_service.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class FoodItemRegistration extends StatefulWidget {
  const FoodItemRegistration({Key? key}) : super(key: key);

  @override
  _FoodItemRegistrationState createState() => _FoodItemRegistrationState();
}

class _FoodItemRegistrationState extends State<FoodItemRegistration> {
  String? expiryDate;
  final FlutterSecureStorage _secureStorage = FlutterSecureStorage();

  TextEditingController itemMRPController = TextEditingController();
  TextEditingController itemSPController = TextEditingController();
  TextEditingController itemNameController = TextEditingController();
  TextEditingController stockQuantityController = TextEditingController();

  @override
  void dispose() {
    itemMRPController.dispose();
    itemSPController.dispose();
    itemNameController.dispose();
    stockQuantityController.dispose();
    super.dispose();
  }

  void _showMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Food Item Registration"),
        backgroundColor: const Color(0xffb8e4fc),
      ),
      body: Stack(alignment: Alignment.center, children: [
        Container(
          alignment: Alignment.center,
          color: Colors.lightBlue,
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
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

                    if (pickedDate != null &&
                        pickedDate.toString().split(' ')[0] != expiryDate) {
                      setState(() {
                        expiryDate = pickedDate.toString().split(' ')[0];
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
                      'Expiry Date: ${Jiffy.parse(expiryDate!, pattern: 'yyyy-MM-dd').yMMMMd}',
                      style: GoogleFonts.josefinSans(
                        color: Colors.black87,
                        fontSize: 16,
                      ),
                    ),
                  ),
                const Padding(padding: EdgeInsets.all(10)),
                TextFormField(
                  controller: itemMRPController,
                  decoration: InputDecoration(
                    labelText: 'Item MRP',
                    labelStyle: GoogleFonts.josefinSans(
                      color: Colors.black87,
                      fontSize: 16,
                    ),
                    filled: true,
                    fillColor: const Color(0xffb8e4fc),
                  ),
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter Item MRP';
                    }
                    return null;
                  },
                ),
                const Padding(padding: EdgeInsets.all(10)),
                TextFormField(
                  controller: itemSPController,
                  decoration: InputDecoration(
                    labelText: 'Item Selling Price',
                    labelStyle: GoogleFonts.josefinSans(
                      color: Colors.black87,
                      fontSize: 16,
                    ),
                    filled: true,
                    fillColor: const Color(0xffb8e4fc),
                  ),
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter Item Selling Price';
                    }
                    return null;
                  },
                ),
                const Padding(padding: EdgeInsets.all(10)),
                TextFormField(
                  controller: itemNameController,
                  decoration: InputDecoration(
                    labelText: 'Item Name',
                    labelStyle: GoogleFonts.josefinSans(
                      color: Colors.black87,
                      fontSize: 16,
                    ),
                    filled: true,
                    fillColor: const Color(0xffb8e4fc),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter Item Name';
                    }
                    return null;
                  },
                ),
                const Padding(padding: EdgeInsets.all(10)),
                TextFormField(
                  controller: stockQuantityController,
                  decoration: InputDecoration(
                    labelText: 'Stock Quantity',
                    labelStyle: GoogleFonts.josefinSans(
                      color: Colors.black87,
                      fontSize: 16,
                    ),
                    filled: true,
                    fillColor: const Color(0xffb8e4fc),
                  ),
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter Stock Quantity';
                    }
                    return null;
                  },
                ),
                const Padding(padding: EdgeInsets.all(20)),
                ElevatedButton(
                  onPressed: () async {
                    try {
                      if (expiryDate != null &&
                          itemMRPController.text.isNotEmpty &&
                          itemSPController.text.isNotEmpty &&
                          itemNameController.text.isNotEmpty &&
                          stockQuantityController.text.isNotEmpty) {
                        final result = await RegisterItemService().registerItem(
                          expiryDate: expiryDate!,
                          itemMRP: double.parse(itemMRPController.text),
                          itemSP: double.parse(itemSPController.text),
                          itemName: itemNameController.text,
                          stockQuantity:
                              int.parse(stockQuantityController.text),
                          storeId:
                              await _secureStorage.read(key: 'storeId') ?? '',
                        );

                        if (result != null) {
                          _showMessage('Food Item registered successfully!');
                        } else {
                          _showMessage(
                              'Failed to register Food Item. Please try again.');
                        }
                      } else {
                        _showMessage('Please fill in all the fields.');
                      }
                    } catch (error) {
                      print('Error registering Food Item: $error');
                      _showMessage('An error occurred. Please try again.');
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
      ]),
    );
  }
}
