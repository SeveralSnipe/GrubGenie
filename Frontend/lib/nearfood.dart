import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_search_bar/easy_search_bar.dart';
import 'package:flutter/material.dart';
import 'package:grub_genie/models.dart';
import 'package:jiffy/jiffy.dart';
import 'package:provider/provider.dart';
import 'package:grub_genie/Api code/providers/nearfood_api.dart';
import 'Api code/models/nearfood.dart';
import 'Api code/service/nearfood_service.dart';
import 'foodcard.dart';

// List<Widget> cardList = [
//   const FoodCard(
//       item: 'Maggi Masala 1-Pack',
//       price: 10,
//       store: 'Pazhamudhir Nilayam',
//       expiry: '30/1/2024',
//       mrp: 20),
//   const FoodCard(
//       item: 'iD Chapati 350g',
//       price: 50,
//       store: 'Nilgiris',
//       expiry: '30/1/2024',
//       mrp: 75)
// ];

class FoodList extends StatefulWidget {
  const FoodList({super.key});

  @override
  State<FoodList> createState() => _FoodListState();
}

class _FoodListState extends State<FoodList> {
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
    return isLoaded
        ? ChangeNotifierProvider(
            create: (context) => NearFoodProvider(cardList),
            child: Consumer<NearFoodProvider>(
                builder: (context, myFoodProvider, child) {
              return Scaffold(
                  appBar: EasySearchBar(
                      backgroundColor: Colors.white,
                      foregroundColor: Colors.black,
                      title: const Text('Search'),
                      onSearch: (value) {
                        myFoodProvider.searched(value);
                      }),
                  body: Container(
                      alignment: Alignment.topCenter,
                      decoration: const BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            Color.fromARGB(255, 148, 221, 255),
                            Color.fromARGB(255, 177, 158, 180)
                          ],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                      ),
                      child: ListView.builder(
                          padding: const EdgeInsets.only(top: 10),
                          itemCount: myFoodProvider.cardList.length,
                          itemBuilder: ((context, index) {
                            return myFoodProvider.cardList[index];
                          }))));
            }))
        : const CircularProgressIndicator();
  }
}
