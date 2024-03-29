import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:grub_genie/Api code/models/nearfood.dart';
import 'package:grub_genie/foodcard.dart';
import 'package:jiffy/jiffy.dart';

import 'Api code/service/nearfood_service.dart';

class ApiTest extends StatefulWidget {
  const ApiTest({super.key});

  @override
  State<ApiTest> createState() => _ApiTestState();
}

class _ApiTestState extends State<ApiTest> {
  NearFood? nearFood;
  bool isLoaded = false;
  List<FoodCard> cardList = [];

  @override
  void initState() {
    super.initState();
    loadNearFood();
  }

  Future<void> loadNearFood() async {
    final nearFoodService = NearFoodService();
    nearFood = await nearFoodService.getNearFood();
    for (var result in nearFood!.result) {
      for (var item in result.items) {
        Timestamp expiryTimestamp =
            Timestamp(item.expiryDate.seconds, item.expiryDate.nanoseconds);
        String expiryDate =
            Jiffy.parseFromDateTime(expiryTimestamp.toDate()).yMMMMd;
        cardList.add(FoodCard(
            item: item.itemName,
            price: item.itemSp,
            store: result.storeName,
            expiry: expiryDate,
            mrp: item.itemMrp));
      }
    }
    setState(() {
      isLoaded = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: isLoaded
            ? Container(
                alignment: Alignment.topCenter,
                color: Colors.lightBlue,
                child: ListView.builder(
                    padding: const EdgeInsets.only(top: 10),
                    itemCount: cardList.length,
                    itemBuilder: ((context, index) {
                      return cardList[index];
                    })))
            : const CircularProgressIndicator());
  }
}
