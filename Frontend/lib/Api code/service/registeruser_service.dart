import 'package:grub_genie/Api code/providers/registeruser_api.dart';
import 'package:grub_genie/Api code/models/registeruser.dart';

class RegisterUserService {
  final _api = RegisterUserApi();

  Future<RegisterUser?> registerUser({
    required String userName,
    required String dob,
    required String email,
    required String phoneNumber,
    required String password,
  }) async {
    return _api.registerUser(
      userName: userName,
      dob: dob,
      email: email,
      phoneNumber: phoneNumber,
      password: password,
    );
  }
}
