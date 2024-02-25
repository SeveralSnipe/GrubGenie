import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:grub_genie/Api code/models/unmappedrequest.dart';

class UnmappedRequestApi {
  Future<UnmappedRequest?> submitUnmappedRequest({
    required List<double> location,
    required String userId,
    required Map<String, dynamic> item,
    required double preferedPrice,
    double? agreedPrice,
    List<String>? additionalNotes,
  }) async {
    Map<String, dynamic> data = {
      "Location": location,
      "UserId": userId,
      "Item": item,
      "PreferedPrice": preferedPrice,
      if (agreedPrice != null) "AgreedPrice": agreedPrice,
      if (additionalNotes != null) "AdditionalNotes": additionalNotes,
    };

    var body = jsonEncode(data);
    var uri = Uri.parse('http://10.0.2.2:5000/UnMappedRouter/UMRequest');
    var client = http.Client();

    var response = await client.post(
      uri,
      body: body,
      headers: {"Content-Type": "application/json"},
    );

    print('Got response');
    if (response.statusCode == 200) {
      print('Got successful response');
      return unmappedRequestFromJson(
          const Utf8Decoder().convert(response.bodyBytes));
    } else {
      print(response.statusCode);
    }
    return null;
  }
}
