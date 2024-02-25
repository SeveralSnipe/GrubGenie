import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:jiffy/jiffy.dart';
import 'package:grub_genie/Api code/service/updateitem_service.dart';

class FoodItemUpdate extends StatefulWidget {
  const FoodItemUpdate({Key? key}) : super(key: key);

  @override
  _FoodItemUpdateState createState() => _FoodItemUpdateState();
}

class _FoodItemUpdateState extends State<FoodItemUpdate> {
  String? expiryDate;
  TextEditingController itemMRPController = TextEditingController();
  TextEditingController itemSPController = TextEditingController();
  TextEditingController itemNameController = TextEditingController();
  TextEditingController stockQuantityController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // Fetch the existing item details using the itemId and populate the fields
    fetchItemDetails();
  }

  Future<void> fetchItemDetails() async {
    // TODO: Implement a method to fetch existing item details based on itemId
    // Set the values in the respective controllers
    // Example:
    // final itemDetails = await YourItemDetailsService().getItemDetails(widget.itemId);
    // if (itemDetails != null) {
    //   setState(() {
    //     expiryDate = itemDetails.expiryDate;
    //     itemMRPController.text = itemDetails.itemMRP.toString();
    //     itemSPController.text = itemDetails.itemSP.toString();
    //     itemNameController.text = itemDetails.itemName;
    //     stockQuantityController.text = itemDetails.stockQuantity.toString();
    //   });
    // }
  }

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
        title: const Text("Food Item Update"),
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
                        final result = await UpdateItemService().updateItem(
                          itemId: "1234",
                          expiryDate: expiryDate!,
                          itemMRP: double.parse(itemMRPController.text),
                          itemSP: double.parse(itemSPController.text),
                          itemName: itemNameController.text,
                          stockQuantity:
                              int.parse(stockQuantityController.text),
                        );

                        if (result != null) {
                          _showMessage('Food Item updated successfully!');
                          // Optionally, you can navigate to another screen or perform other actions
                        } else {
                          _showMessage(
                              'Failed to update Food Item. Please try again.');
                        }
                      } else {
                        _showMessage('Please fill in all the fields.');
                      }
                    } catch (error) {
                      print('Error updating Food Item: $error');
                      _showMessage('An error occurred. Please try again.');
                    }
                  },
                  style: ButtonStyle(
                    backgroundColor:
                        MaterialStatePropertyAll(Colors.red.shade300),
                  ),
                  child: Text(
                    "Update Food Item",
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
