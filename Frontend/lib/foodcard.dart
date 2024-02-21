import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class FoodCard extends StatefulWidget {
  final String item;
  final int? price;
  final String store;
  final String expiry;
  final int? mrp;

  const FoodCard(
      {super.key,
      required this.item,
      required this.price,
      required this.store,
      required this.expiry,
      required this.mrp});

  @override
  State<FoodCard> createState() => _FoodCardState();
}

class _FoodCardState extends State<FoodCard> {
  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ListTile(
            title: Text(
              widget.item,
              style: GoogleFonts.josefinSans(
                color: Colors.black87,
                fontSize: 20,
              ),
            ),
            subtitle: Text(
              'Expiry: ${widget.expiry}',
              style: GoogleFonts.josefinSans(
                  color: Colors.black87,
                  fontSize: 16,
                  fontWeight: FontWeight.w300),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Price: ${widget.price}',
                style: GoogleFonts.josefinSans(
                  color: Colors.black87,
                  fontSize: 16,
                ),
              ),
              const SizedBox(
                width: 6,
              ),
              Text(
                'MRP: ${widget.mrp}',
                style: GoogleFonts.josefinSans(
                  color: Colors.black87,
                  fontSize: 16,
                ),
              ),
              const SizedBox(
                width: 6,
              ),
              Text(
                'Store: ${widget.store}',
                style: GoogleFonts.josefinSans(
                  color: Colors.black87,
                  fontSize: 16,
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
