import 'package:grub_genie/Api code/providers/storerequests_api.dart';
import 'package:grub_genie/Api code/models/storerequests.dart';

class StoreRequestsService {
  final _api = StoreRequestsApi();

  Future<StoreRequests?> getStoreRequests({
    required String storeId,
  }) async {
    return _api.getStoreRequests(storeId);
  }
}
