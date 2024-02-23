import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:grub_genie/Api code/models/requestfood.dart';

class RequestFoodApi {
  Future<RequestFood?> requestFood({
    required String userId,
    required List<double> location,
    required Map<String, Map<String, int>> orders,
    required double costPrice,
    double? discountPrice,
    required String status,
    String? additionalNotes,
  }) async {
    Map data = {
      "UserId": userId,
      "Location": location,
      "Orders": orders,
      "CostPrice": costPrice,
      if (discountPrice != null) "DiscountPrice": discountPrice,
      "Status": status,
      "AdditionalNotes": additionalNotes ?? "",
    };

    var body = jsonEncode(data);
    var uri =
        Uri.parse('http://10.0.2.2:5000/CommerceRequestRouter/requestItem');
    var client = http.Client();

    var response = await client.post(
      uri,
      body: body,
      headers: {"Content-Type": "application/json"},
    );

    print('Got response');
    if (response.statusCode == 200) {
      print('Got successful response');
      return requestFoodFromJson(
          const Utf8Decoder().convert(response.bodyBytes));
    }
    return null;
  }
}
