import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

import 'models.dart';

class NearStores extends StatefulWidget {
  const NearStores({super.key});

  @override
  _NearStoresState createState() => _NearStoresState();
}

class _NearStoresState extends State<NearStores> {
  late double lat;
  late double long;
  GoogleMapController? _controller;
  late LatLng _markerLatLng;
  bool isLoaded = false;

  void _onMapCreated(GoogleMapController controller) {
    setState(() {
      _controller = controller;
    });
  }

  @override
  void initState() {
    super.initState();
    getLocation();
  }

  void getLocation() async {
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
    lat = currentPosition.latitude;
    long = currentPosition.longitude;
    _markerLatLng = LatLng(lat, long);
    setState(() {
      isLoaded = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return isLoaded
        ? Scaffold(
            appBar: AppBar(
              title: const Text('Nearby Stores'),
            ),
            body: ChangeNotifierProvider(
              create: (context) => NearStoresProvider(lat, long, context),
              child: Consumer<NearStoresProvider>(
                  builder: (context, myStoresProvider, child) {
                return myStoresProvider.isLoaded
                    ? GoogleMap(
                        onMapCreated: _onMapCreated,
                        initialCameraPosition: CameraPosition(
                          target: _markerLatLng,
                          zoom: 15.0,
                        ),
                        markers: myStoresProvider.markers,
                      )
                    : const Center(child: CircularProgressIndicator());
              }),
            ))
        : const CircularProgressIndicator();
  }
}
