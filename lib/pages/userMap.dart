import 'dart:async';
// import 'package:ai_app/pages/clocation.dart';
import 'package:ai_app/pages/comForm.dart';
// import 'package:fluttertoast/fluttertoast.dart';
import 'package:geolocator/geolocator.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

// void main() => runApp(MyApp());

class MyMap extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MapSample();
  }
}

class MapSample extends StatefulWidget {
  @override
  MapSampleState createState() => MapSampleState();
}

class MapSampleState extends State<MapSample> {
  Completer<GoogleMapController> _controller = Completer();
  // on below line we have specified camera position
  static final CameraPosition _kGoogle = const CameraPosition(
    target: LatLng(20.42796133580664, 80.885749655962),
    zoom: 14.4746,
  );

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

  void dekhBinod() async {
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
          visible: false,
        ),
      );

      // specified current users location
      CameraPosition cameraPosition = CameraPosition(
        target: LatLng(value.latitude, value.longitude),
        zoom: 14,
      );

      final GoogleMapController controller = await _controller.future;

      controller.animateCamera(CameraUpdate.newCameraPosition(cameraPosition));
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      appBar: AppBar(
        title: Text("select location"),
        actions: <Widget>[
          // on pressing icon button the camera will take to user current location
          IconButton(
            tooltip: 'find current location',
            icon: Icon(Icons.location_searching_rounded),
            onPressed: () => dekhBinod(),
          ),
        ],
      ),
      body: Container(
        child: SafeArea(
          // on below line creating google maps
          child: GoogleMap(
            onTap: (argument) => {
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
              dekhBinod();
            },
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          if (_markers.length == 2) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: ((context) => ComForm(
                    // currentLoc: _markers[0].position,
                    // problemLoc: _markers[1].position,
                    )),
              ),
            );
          } else {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text("Please select problem location!!!"),
            ));
          }
        },
        label: Text('Raise Complain'),
        icon: Icon(Icons.add),
      ),
    );
  }
}
