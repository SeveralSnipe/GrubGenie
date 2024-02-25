import 'package:grub_genie/Api code/providers/storesnearme_api.dart';
import 'package:grub_genie/Api code/models/storesnearme.dart';

class StoresNearMeService {
  final _api = StoreNearMeDistApi();

  Future<List<StoresNearMe>?> getStoresNearMe({
    required List<double> location,
  }) async {
    return _api.getStoresNearMe(
      location: location,
      sorts: "dist",
      maxDist: 100000,
    );
  }
}
