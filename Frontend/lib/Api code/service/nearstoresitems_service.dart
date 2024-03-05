import 'package:grub_genie/Api%20code/models/nearstoresitems.dart';
import 'package:grub_genie/Api%20code/providers/nearstoresitems_api.dart';

class NearStoresItemsService {
  final _api = NearStoresItemsApi();
  Future<NearStoresItems?> getNearStoresItems(
      double latitude, double longitude) async {
    return _api.getNearStoresItems(latitude, longitude);
  }
}
