import 'package:grub_genie/Api code/providers/userlogin_api.dart';
import 'package:grub_genie/Api code/models/userlogin.dart';

class UserLoginService {
  final _api = UserLoginApi();

  Future<UserLogin?> userLogin({
    required String identifier,
    required String password,
  }) async {
    return _api.userLogin(
      identifier: identifier,
      password: password,
    );
  }
}
