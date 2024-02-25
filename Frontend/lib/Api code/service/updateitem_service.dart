import 'package:grub_genie/Api code/providers/updateitem_api.dart';
import 'package:grub_genie/Api code/models/updateitem.dart';

class UpdateItemService {
  final _api = UpdateItemApi();

  Future<UpdateItem?> updateItem({
    required String itemId,
    required String expiryDate,
    String? itemName,
    int? stockQuantity,
    double? itemMRP,
    double? itemSP,
  }) async {
    return _api.updateItem(
      itemId: itemId,
      expiryDate: expiryDate,
      itemName: itemName,
      stockQuantity: stockQuantity,
      itemMRP: itemMRP,
      itemSP: itemSP,
    );
  }
}
