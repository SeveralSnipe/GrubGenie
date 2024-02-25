import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:jiffy/jiffy.dart';
import 'package:grub_genie/Api code/service/updateitem_service.dart';
import 'package:grub_genie/Api code/service/storeitems_service.dart';
import 'package:grub_genie/Api code/models/storeitems.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

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

  String? selectedStoreId;
  String? selectedItemId;

  final secureStorage = FlutterSecureStorage();

  @override
  void initState() {
    super.initState();
    fetchStoreId();
  }

  Future<void> fetchStoreId() async {
    final storedStoreId = await secureStorage.read(key: 'storeId');
    print(storedStoreId);
    if (storedStoreId != null) {
      setState(() {
        selectedStoreId = storedStoreId;
      });
    }
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
                FutureBuilder<StoreItems?>(
                  future: StoreItemsService().getStoreItems(
                    storeId: selectedStoreId ?? '',
                  ),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(
                        child: CircularProgressIndicator(
                          valueColor: AlwaysStoppedAnimation<Color>(
                              Colors.red.shade300),
                        ),
                      );
                    } else if (snapshot.hasError) {
                      return Center(
                        child: Text(
                          'Error: ${snapshot.error}',
                          style: GoogleFonts.josefinSans(
                            color: Colors.black87,
                            fontSize: 16,
                          ),
                        ),
                      );
                    } else if (!snapshot.hasData ||
                        snapshot.data!.results.isEmpty) {
                      return Center(
                        child: Text(
                          'No items found for the selected store',
                          style: GoogleFonts.josefinSans(
                            color: Colors.black87,
                            fontSize: 16,
                          ),
                        ),
                      );
                    } else {
                      List<DropdownMenuItem<String>> dropdownItems =
                          snapshot.data!.results.map((item) {
                        return DropdownMenuItem<String>(
                          value: item.itemId,
                          child: Text(
                            item.itemName,
                            style: GoogleFonts.josefinSans(
                              color: Colors.black87,
                              fontSize: 16,
                            ),
                          ),
                        );
                      }).toList();

                      return DropdownButton<String>(
                        value: selectedItemId,
                        hint: Text(
                          'Select Existing Item',
                          style: GoogleFonts.josefinSans(
                            color: Colors.black87,
                            fontSize: 16,
                          ),
                        ),
                        onChanged: (newValue) {
                          setState(() {
                            selectedItemId = newValue;
                            print(selectedItemId);
                          });
                        },
                        items: dropdownItems,
                      );
                    }
                  },
                ),
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
                          selectedItemId != null &&
                          itemMRPController.text.isNotEmpty &&
                          itemSPController.text.isNotEmpty &&
                          itemNameController.text.isNotEmpty &&
                          stockQuantityController.text.isNotEmpty) {
                        final result = await UpdateItemService().updateItem(
                          itemId: selectedItemId ?? '',
                          expiryDate: expiryDate!,
                          itemMRP: double.parse(itemMRPController.text),
                          itemSP: double.parse(itemSPController.text),
                          itemName: itemNameController.text,
                          stockQuantity:
                              int.parse(stockQuantityController.text),
                        );

                        if (result != null) {
                          _showMessage('Food Item updated successfully!');
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
