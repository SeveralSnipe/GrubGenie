import 'dart:convert';
import 'package:geolocator/geolocator.dart';
import 'package:grub_genie/Api code/models/nearfood.dart';
import 'package:http/http.dart' as http;

class NearFoodApi {
  Future<NearFood?> getNearFood() async {
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }
    Position currentPosition = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.best,
        forceAndroidLocationManager: true);
    Map data = {
      "location": [currentPosition.latitude, currentPosition.longitude],
      "maxDist": 10000,
      "sorts": "dist"
    };
    var body = jsonEncode(data);
    var client = http.Client();
    var uri = Uri.parse(
        'http://10.0.2.2:5000/CommerceNearMeRouter/StoreNearMeWithItemNames');
    var response = await client
        .post(uri, body: body, headers: {"Content-Type": "application/json"});
    print('Got response');
    if (response.statusCode == 200) {
      print('Got successful response');
      return nearFoodFromJson(const Utf8Decoder().convert(response.bodyBytes));
    }
    return null;
  }
}
