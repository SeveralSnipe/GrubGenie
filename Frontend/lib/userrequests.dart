import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:grub_genie/Api%20code/service/userrequests_service.dart'; // Update with the correct path
import 'package:grub_genie/Api%20code/models/userrequests.dart'; // Update with the correct path
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class UserRequestsScreen extends StatefulWidget {
  const UserRequestsScreen({Key? key}) : super(key: key);

  @override
  _UserRequestsScreenState createState() => _UserRequestsScreenState();
}

class _UserRequestsScreenState extends State<UserRequestsScreen> {
  final secureStorage = FlutterSecureStorage();
  String? selectedUserId;

  final UserRequestsService _userRequestsService =
      UserRequestsService(); // Update with the correct service

  @override
  void initState() {
    super.initState();
    fetchUserId();
  }

  Future<void> fetchUserId() async {
    final storedUserId = await secureStorage.read(key: 'userId');
    if (storedUserId != null) {
      setState(() {
        selectedUserId = storedUserId;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("User Requests"),
        backgroundColor: const Color(0xffb8e4fc),
      ),
      body: FutureBuilder<UserRequests?>(
        future: _userRequestsService.getUserRequests(
          userId: selectedUserId ?? '',
        ),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.result.isEmpty) {
            return Center(child: Text('No user requests available.'));
          } else {
            return ListView.builder(
              itemCount: snapshot.data!.result.length,
              itemBuilder: (context, index) {
                Result userRequest = snapshot.data!.result[index];
                return _buildUserRequestCard(userRequest);
              },
            );
          }
        },
      ),
    );
  }

  Widget _buildUserRequestCard(Result userRequest) {
    return Card(
      margin: const EdgeInsets.all(8.0),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Status: ${userRequest.status}',
              style: GoogleFonts.josefinSans(fontSize: 16),
            ),
            Text(
              'Additional Notes: ${userRequest.additionalNotes.join(', ')}',
              style: GoogleFonts.josefinSans(fontSize: 16),
            ),
            Text(
              'Cost Price: ${userRequest.costPrice}',
              style: GoogleFonts.josefinSans(fontSize: 16),
            ),
            Text(
              'Discount Price: ${userRequest.discountPrice}',
              style: GoogleFonts.josefinSans(fontSize: 16),
            ),
            Text(
              'Orders:',
              style: GoogleFonts.josefinSans(
                  fontSize: 16, fontWeight: FontWeight.bold),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: userRequest.orders.entries.map((orderEntry) {
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
