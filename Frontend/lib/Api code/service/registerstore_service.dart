import 'package:grub_genie/Api code/providers/registerstore_api.dart';
import 'package:grub_genie/Api code/models/registerstore.dart';

class RegisterStoreService {
  final _api = RegisterStoreApi();

  Future<RegisterStore?> registerStore({
    required String storeName,
    required String gst,
    required String email,
    required String location,
    required String phoneNumber,
    required String password,
  }) async {
    return _api.registerStore(
      storeName: storeName,
      gst: gst,
      email: email,
      location: location,
      phoneNumber: phoneNumber,
      password: password,
    );
  }
}
