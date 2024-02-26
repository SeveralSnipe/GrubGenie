import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:grub_genie/Api code/service/storerequests_service.dart';
import 'package:grub_genie/Api code/models/storerequests.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class StoreRequestsScreen extends StatefulWidget {
  const StoreRequestsScreen({Key? key}) : super(key: key);

  @override
  _StoreRequestsScreenState createState() => _StoreRequestsScreenState();
}

class _StoreRequestsScreenState extends State<StoreRequestsScreen> {
  final secureStorage = FlutterSecureStorage();
  String? selectedStoreId;

  final StoreRequestsService _storeRequestsService = StoreRequestsService();
  @override
  void initState() {
    super.initState();
    fetchStoreId();
  }

  Future<void> fetchStoreId() async {
    final storedStoreId = await secureStorage.read(key: 'storeId');
    if (storedStoreId != null) {
      setState(() {
        selectedStoreId = storedStoreId;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Store Requests"),
        backgroundColor: const Color(0xffb8e4fc),
      ),
      body: FutureBuilder<StoreRequests?>(
        future: _storeRequestsService.getStoreRequests(
          storeId: selectedStoreId ?? '',
        ),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.result.isEmpty) {
            return Center(child: Text('No store requests available.'));
          } else {
            return ListView.builder(
              itemCount: snapshot.data!.result.length,
              itemBuilder: (context, index) {
                Result storeRequest = snapshot.data!.result[index];
                return _buildStoreRequestCard(storeRequest);
              },
            );
          }
        },
      ),
    );
  }

  Widget _buildStoreRequestCard(Result storeRequest) {
    return Card(
      margin: const EdgeInsets.all(8.0),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Status: ${storeRequest.status}',
              style: GoogleFonts.josefinSans(fontSize: 16),
            ),
            Text(
              'Additional Notes: ${storeRequest.additionalNotes.join(', ')}',
              style: GoogleFonts.josefinSans(fontSize: 16),
            ),
            Text(
              'Cost Price: ${storeRequest.costPrice}',
              style: GoogleFonts.josefinSans(fontSize: 16),
            ),
            Text(
              'Discount Price: ${storeRequest.discountPrice}',
              style: GoogleFonts.josefinSans(fontSize: 16),
            ),
            Text(
              'Orders:',
              style: GoogleFonts.josefinSans(
                  fontSize: 16, fontWeight: FontWeight.bold),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: storeRequest.orders.entries.map((orderEntry) {
                String productName = orderEntry.key;

                return Text(
                  productName,
                  style: GoogleFonts.josefinSans(fontSize: 16),
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }
}
