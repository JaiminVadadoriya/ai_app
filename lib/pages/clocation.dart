import 'dart:async';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
// import 'package:flutter/rendering.dart';

class CLocation extends StatefulWidget {
  const CLocation({Key? key}) : super(key: key);

  @override
  _CLocationState createState() => _CLocationState();
}

class _CLocationState extends State<CLocation> {
  // late GoogleMapController googleMapController;

  Completer<GoogleMapController> _controller = Completer();

  // static const CameraPosition initialCameraPosition = CameraPosition(
  //     target: LatLng(23.155188159222057, 72.67054829746485), zoom: 14);

// on below line we have specified camera position
  static final CameraPosition _kGoogle = const CameraPosition(
    target: LatLng(20.42796133580664, 80.885749655962),
    zoom: 14.4746,
  );

  // Set<Marker> markers = {};

// on below line we have created the list of markers
  final List<Marker> _markers = <Marker>[];

// created method for getting user current location
  Future<Position> getUserCurrentLocation() async {
    await Geolocator.requestPermission()
        .then((value) {})
        .onError((error, stackTrace) async {
      await Geolocator.requestPermission();
      print("ERROR" + error.toString());
    });
    return await Geolocator.getCurrentPosition();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Current Location")),
      // body: GoogleMap(
      //   initialCameraPosition: initialCameraPosition,
      //   markers: markers,
      //   zoomControlsEnabled: false,
      //   mapType: MapType.normal,
      //   onMapCreated: (GoogleMapController controller) {
      //     googleMapController = controller;
      //   },
      // ),
      body: Container(
        child: SafeArea(
          // on below line creating google maps
          child: GoogleMap(
            onTap: (argument) => {
              print("${_markers.length}"),
              if (_markers.length == 2)
                {
                  _markers.removeLast(),
                },
              setState(() {
                _markers.add(
                  Marker(
                    markerId: MarkerId('2'),
                    position: argument,
                    infoWindow: InfoWindow(
                      title: 'Problem',
                    ),
                  ),
                );
              }),
              print("${_markers.length}"),
            },
            // on below line setting camera position
            initialCameraPosition: _kGoogle,
            // on below line we are setting markers on the map
            markers: Set<Marker>.of(_markers),
            // on below line specifying map type.
            mapType: MapType.normal,
            // on below line setting user location enabled.
            myLocationEnabled: true,
            // on below line setting compass enabled.
            compassEnabled: true,
            // on below line specifying controller on map complete.
            onMapCreated: (GoogleMapController controller) {
              _controller.complete(controller);
            },
          ),
        ),
      ),
      // floatingActionButton: FloatingActionButton.extended(
      //   onPressed: () async {
      //     Position position = await _determinePosition();
      //     googleMapController.animateCamera(CameraUpdate.newCameraPosition(
      //         CameraPosition(
      //             target: LatLng(position.latitude, position.longitude),
      //             zoom: 14)));

      //     markers.clear();
      //     markers.add(Marker(
      //         markerId: MarkerId('CurrentLocation'),
      //         position: LatLng(position.latitude, position.longitude)));
      //     setState(() {});
      //   },
      //   label: Text(""),
      //   icon: Icon(Icons.search_rounded),
      // ),

      // on pressing floating action button the camera will take to user current location
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          getUserCurrentLocation().then((value) async {
            print(value.latitude.toString() + " " + value.longitude.toString());

            // marker added for current users location
            _markers.add(
              Marker(
                markerId: MarkerId("1"),
                position: LatLng(value.latitude, value.longitude),
                infoWindow: InfoWindow(
                  title: 'My Current Location',
                ),
              ),
            );

            // specified current users location
            CameraPosition cameraPosition = new CameraPosition(
              target: LatLng(value.latitude, value.longitude),
              zoom: 14,
            );

            final GoogleMapController controller = await _controller.future;
            controller
                .animateCamera(CameraUpdate.newCameraPosition(cameraPosition));
            setState(() {});
          });
        },
        child: Icon(Icons.location_searching),
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
