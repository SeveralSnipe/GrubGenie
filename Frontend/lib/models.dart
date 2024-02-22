import 'package:flutter/material.dart';

import 'foodcard.dart';

class NearFoodProvider extends ChangeNotifier {
  late List<FoodCard> totalCardList;
  late List<FoodCard> cardList;

  NearFoodProvider(this.totalCardList) {
    cardList = List.from(totalCardList);
  }

  void searched(String query) {
    // if (query == '') {
    //   cardList = List.from(totalCardList);
    //   notifyListeners();
    //   return;
    // } may work without
    cardList.clear();
    for (var result in totalCardList) {
      if (result.item.toLowerCase().contains(query.toLowerCase())) {
        cardList.add(result);
      }
    }
    notifyListeners();
  }
}
