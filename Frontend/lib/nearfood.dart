import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_search_bar/easy_search_bar.dart';
import 'package:flutter/material.dart';
import 'package:grub_genie/models.dart';
import 'package:jiffy/jiffy.dart';
import 'package:provider/provider.dart';
import 'Api code/models/nearfood.dart';
import 'Api code/service/nearfood_service.dart';
import 'chatbot_button.dart';
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
  // late LocationPermission permission;
  // Position currentPosition = Position(
  //     longitude: 0,
  //     latitude: 1,
  //     timestamp: DateTime(0),
  //     accuracy: 0,
  //     altitude: 0,
  //     altitudeAccuracy: 0,
  //     heading: 0,
  //     headingAccuracy: 0,
  //     speed: 0,
  //     speedAccuracy: 0);
  NearFood? nearFood;
  bool isLoaded = false;
  List<FoodCard> cardList = [];

  @override
  void initState() {
    super.initState();
    loadNearFood();
  }

  Future<void> loadNearFood() async {
    // permission = await Geolocator.checkPermission();
    // if (permission == LocationPermission.denied) {
    //   permission = await Geolocator.requestPermission();
    //   if (permission == LocationPermission.denied) {
    //     return Future.error('Location permissions are denied');
    //   }
    // }
    // Geolocator.getCurrentPosition(
    //         desiredAccuracy: LocationAccuracy.best,
    //         forceAndroidLocationManager: true)
    //     .then((Position position) {
    //   setState(() {
    //     currentPosition = position;
    //   });
    // }).catchError((e) {
    //   print(e);
    // });
    // print(currentPosition.latitude);
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
                      backgroundColor: const Color(0xfffb8e4fc),
                      foregroundColor: Colors.black,
                      title: const Text('Search'),
                      onSearch: (value) {
                        myFoodProvider.searched(value);
                      }),
                  body: Stack(alignment: Alignment.center, children: [
                    Container(
                        alignment: Alignment.topCenter,
                        color: Colors.lightBlue,
                        child: ListView.builder(
                            padding: const EdgeInsets.only(top: 10),
                            itemCount: myFoodProvider.cardList.length,
                            itemBuilder: ((context, index) {
                              return myFoodProvider.cardList[index];
                            }))),
                    ChatbotButton(
                      onPressed: () {
                        // Handle the chatbot button press
                        // You can implement the logic to open/minimize the chatbot here
                      },
                    ),
                  ]));
            }))
        : const CircularProgressIndicator();
  }
}
