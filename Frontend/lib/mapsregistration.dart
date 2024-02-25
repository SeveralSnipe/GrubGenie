import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapPage extends StatefulWidget {
  @override
  _MapPageState createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  late var lat;
  late var long;
  GoogleMapController? _controller;
  late LatLng _markerLatLng;
  bool isLoaded = false;

  void _onMapCreated(GoogleMapController controller) {
    setState(() {
      _controller = controller;
    });
  }

  void _onMarkerDragEnd(LatLng position) {
    setState(() {
      _markerLatLng = position;
    });
  }

  void _submitLocation() {
    // You can now use _markerLatLng.latitude and _markerLatLng.longitude for further processing.
    Navigator.pop(context, [_markerLatLng.latitude, _markerLatLng.longitude]);
  }

  @override
  void initState() {
    // TODO: implement initState
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
              title: const Text('Mark store location'),
            ),
            body: GoogleMap(
              onMapCreated: _onMapCreated,
              initialCameraPosition: CameraPosition(
                target: _markerLatLng,
                zoom: 15.0,
              ),
              markers: {
                Marker(
                  markerId: const MarkerId('Location'),
                  position: _markerLatLng,
                  draggable: true,
                  onDragEnd: (newPosition) {
                    _onMarkerDragEnd(newPosition);
                  },
                ),
              },
            ),
            floatingActionButton: FloatingActionButton(
              onPressed: _submitLocation,
              child: const Icon(Icons.check),
            ),
          )
        : const CircularProgressIndicator();
  }
}
