import 'dart:async';
// import 'package:geolocator/geolocator.dart';
// import 'package:ai_app/pages/sign.dart';
import 'package:ai_app/pages/clocation.dart';
import 'package:ai_app/pages/comForm.dart';
// import 'package:ai_app/pages/userhome.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

// void main() => runApp(MyApp());

class MyMap extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Google Maps Demo',
      home: MapSample(),
    );
  }
}

class MapSample extends StatefulWidget {
  @override
  State<MapSample> createState() => MapSampleState();
}

class MapSampleState extends State<MapSample> {
  Completer<GoogleMapController> _controller = Completer();

  // static final CameraPosition _kGooglePlex = CameraPosition(
  //   target: LatLng(37.42796133580664, -122.085749655962),
  //   // target: LatLng(23.033863, 72.585022),
  //   //target: LatLng(23.155188159222057, 72.67054829746485),
  //   zoom: 14.4746,
  // );

  // static final CameraPosition _kLake = CameraPosition(
  //     bearing: 192.8334901395799,
  //     // target: LatLng(37.43296265331129, -122.08832357078792),
  //     // target: LatLng(23.033863, 72.585022),
  //     target: LatLng(23.155188159222057, 72.67054829746485),
  //     tilt: 59.440717697143555,
  //     zoom: 19.151926040649414);

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      body: CLocation(),
      // GoogleMap(
      //   mapType: MapType.satellite,
      //   onTap: (argument) => {
      //     print(argument)
      //     // Navigator.push(
      //     //     context, MaterialPageRoute(builder: ((context) => ComForm())))
      //   },
      //   initialCameraPosition: _kGooglePlex,
      //   onMapCreated: (GoogleMapController controller) {
      //     _controller.complete(controller);
      //   },
      // ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: ((context) => ComForm())));
        },
        label: Text('Raise Complain'),
        icon: Icon(Icons.add),
      ),
    );
  }

  // Future<void> _goToTheLake() async {
  //   final GoogleMapController controller = await _controller.future;
  //   controller.animateCamera(CameraUpdate.newCameraPosition(_kLake));
  // }
}
