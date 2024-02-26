import 'package:grub_genie/Api code/providers/unmappedrequest_api.dart';
import 'package:grub_genie/Api code/models/unmappedrequest.dart';

class UnmappedRequestFoodService {
  final _api = UnmappedRequestApi();

  Future<UnmappedRequest?> submitUnmappedRequest({
    required List<double> location,
    required String userId,
    required Map<String, dynamic> item,
    required double preferedPrice,
    double? agreedPrice,
    List<String>? additionalNotes,
  }) async {
    return _api.submitUnmappedRequest(
      userId: userId,
      location: location,
      item: item,
      preferedPrice: preferedPrice,
      agreedPrice: agreedPrice,
      additionalNotes: additionalNotes,
    );
  }
}
