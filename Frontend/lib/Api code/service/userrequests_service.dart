import 'package:grub_genie/Api code/providers/userrequests_api.dart';
import 'package:grub_genie/Api code/models/userrequests.dart';

class UserRequestsService {
  final _api = UserRequestsApi();

  Future<UserRequests?> getUserRequests({
    required String userId,
  }) async {
    return _api.getUserRequests(userId);
  }
}
