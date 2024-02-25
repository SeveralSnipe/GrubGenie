import 'package:grub_genie/Api code/providers/registeritem_api.dart';
import 'package:grub_genie/Api code/models/registeritem.dart';

class RegisterItemService {
  final _api = RegisterItemApi();

  Future<RegisterItem?> registerItem({
    required String expiryDate,
    required double itemMRP,
    required double itemSP,
    required String itemName,
    required int stockQuantity,
    required String storeId,
  }) async {
    return _api.registerItem(
      expiryDate: expiryDate,
      itemMRP: itemMRP,
      itemSP: itemSP,
      itemName: itemName,
      stockQuantity: stockQuantity,
      storeId: storeId,
    );
  }
}
