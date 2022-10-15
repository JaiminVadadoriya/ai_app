import 'package:flutter/material.dart';
// import 'package:flutter/rendering.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class CLocation extends StatefulWidget {
  const CLocation({super.key});

  @override
  State<CLocation> createState() => _CLocationState();
}

class _CLocationState extends State<CLocation> {
  late GoogleMapController googleMapController;
  static const CameraPosition initialCameraPosition = CameraPosition(
      target: LatLng(23.155188159222057, 72.67054829746485), zoom: 14);

  Set<Marker> markers = {};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Current Location")),
      body: GoogleMap(
        initialCameraPosition: initialCameraPosition,
        markers: markers,
        zoomControlsEnabled: false,
        mapType: MapType.normal,
        onMapCreated: (GoogleMapController controller) {
          googleMapController = controller;
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () async {
          Position position = await _determinePosition();
          googleMapController.animateCamera(CameraUpdate.newCameraPosition(
              CameraPosition(
                  target: LatLng(position.latitude, position.longitude),
                  zoom: 14)));

          markers.clear();
          markers.add(Marker(
              markerId: MarkerId('CurrentLocation'),
              position: LatLng(position.latitude, position.longitude)));
          setState(() {});
        },
        label: Text(""),
        icon: Icon(Icons.search_rounded),
      ),
    );
  }

  Future<Position> _determinePosition() async {
    bool serverEnabled;
    LocationPermission permission;

    serverEnabled = await Geolocator.isLocationServiceEnabled();

    if (!serverEnabled) {
      return Future.error('Location server are disabled');
    }

    permission = await Geolocator.checkPermission();

    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();

      if (permission == LocationPermission) {
        return Future.error("Location permission denied");
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error('Location permission are denied forever');
    }

    Position position = await Geolocator.getCurrentPosition();
    return position;
  }
}
