import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:grub_genie/Api%20code/models/nearstoresitems.dart';
import 'package:grub_genie/Api%20code/service/chatbot_service.dart';
import 'package:grub_genie/message.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import 'Api code/models/storesnearme.dart';
import 'Api code/service/nearstoresitems_service.dart';
import 'Api code/service/storesnearme_service.dart';
import 'foodcard.dart';

class NearFoodProvider extends ChangeNotifier {
  late List<FoodCard> totalCardList;
  late List<FoodCard> cardList;

  NearFoodProvider(this.totalCardList) {
    cardList = List.from(totalCardList);
  }

  void searched(String query) {
    cardList.clear();
    for (var result in totalCardList) {
      if (result.item.toLowerCase().contains(query.toLowerCase())) {
        cardList.add(result);
      }
    }
    notifyListeners();
  }
}

class ChatbotProvider extends ChangeNotifier {
  List<Message> messages = [];

  Future<void> sendMessage(String message, String userId) async {
    messages.add(Message(
        content: Text(message,
            style: GoogleFonts.josefinSans(
              color: Colors.black87,
              fontSize: 16,
            )),
        sentByMe: true));
    messages.add(Message(
        content: LoadingAnimationWidget.twistingDots(
            leftDotColor: Colors.cyan, rightDotColor: Colors.cyan, size: 20),
        sentByMe: false));
    notifyListeners();
    var chatbotResponse = await ChatbotService().getChatbot(message, userId);
    messages.removeLast();
    messages.add(Message(
        content: Text(chatbotResponse!.response,
            style: GoogleFonts.josefinSans(
              color: Colors.black87,
              fontSize: 16,
            )),
        sentByMe: false));
    notifyListeners();
  }
}

class NearStoresProvider extends ChangeNotifier {
  Set<Marker> markers = {};
  late NearStoresItems? result;
  bool isLoaded = false;
  late dynamic context;

  NearStoresProvider(var lat, var long, this.context) {
    loadData(lat, long);
  }

  void loadData(var lat, var long) async {
    result = await NearStoresItemsService().getNearStoresItems(lat, long);
    print(result);
    if (result != null) {
      for (var store in result!.result) {
        markers.add(Marker(
          markerId: MarkerId(store.storeName),
          position: LatLng(store.location.latitude, store.location.longitude),
          infoWindow: InfoWindow(
              title: store.storeName,
              snippet: 'Phone: ${store.phoneNumber}, Email: ${store.email}'),
          onTap: () {
            showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  scrollable: true,
                  content: SizedBox(
                    width: double.maxFinite,
                    height: 100,
                    child: store.items.isNotEmpty
                        ? ListView.separated(
                            itemCount: store.items.length,
                            separatorBuilder: (context, index) {
                              return const Divider();
                            },
                            itemBuilder: (context, index) {
                              return Column(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(store.items[index].itemName),
                                  const Padding(padding: EdgeInsets.all(4)),
                                  Text(
                                      'Selling price: ${store.items[index].itemSp}'),
                                  const Padding(padding: EdgeInsets.all(4)),
                                  Text('MRP: ${store.items[index].itemMrp}'),
                                  const Padding(padding: EdgeInsets.all(4)),
                                  Text(
                                      'Expiry: ${store.items[index].expiryDate}'),
                                ],
                              );
                            },
                          )
                        : const Text('This store has no items.'),
                  ),
                );
              },
            );
          },
        ));
      }
      isLoaded = true;
      notifyListeners();
    } else {
      print('Result failure');
      return;
    }
  }
}
