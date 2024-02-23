import 'package:grub_genie/Api code/providers/storelogin_api.dart';
import 'package:grub_genie/Api code/models/storelogin.dart';

class StoreLoginService {
  final _api = StoreLoginApi();

  Future<StoreLogin?> storeLogin({
    required String identifier,
    required String password,
  }) async {
    return _api.storeLogin(
      identifier: identifier,
      password: password,
    );
  }
}
