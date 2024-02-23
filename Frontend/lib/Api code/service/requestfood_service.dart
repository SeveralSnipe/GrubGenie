import 'package:grub_genie/Api code/providers/requestfood_api.dart';
import 'package:grub_genie/Api code/models/requestfood.dart';

class RequestFoodService {
  final _api = RequestFoodApi();

  Future<RequestFood?> requestFood({
    required String userId,
    required List<double> location,
    required Map<String, Map<String, int>> orders,
    required double costPrice,
    double? discountPrice,
    required String status,
    String? additionalNotes,
  }) async {
    return _api.requestFood(
      userId: userId,
      location: location,
      orders: orders,
      costPrice: costPrice,
      discountPrice: discountPrice,
      status: status,
      additionalNotes: additionalNotes,
    );
  }
}
