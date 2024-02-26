import 'package:grub_genie/Api code/providers/storeitems_api.dart';
import 'package:grub_genie/Api code/models/storeitems.dart';

class StoreItemsService {
  final _api = StoreItemsApi();

  Future<StoreItems?> getStoreItems({
    required String storeId,
  }) async {
    return _api.getStoreItems(storeId);
  }
}
