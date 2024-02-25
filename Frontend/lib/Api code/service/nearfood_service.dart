import 'package:grub_genie/Api code/providers/nearfood_api.dart';
import 'package:grub_genie/Api code/models/nearfood.dart';
// import 'package:grub_genie/Api code/models/nearfood.dart';

class NearFoodService {
  final _api = NearFoodApi();
  Future<NearFood?> getNearFood() async {
    return _api.getNearFood();
  }
}
