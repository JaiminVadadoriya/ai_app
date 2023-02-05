// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:async';
import 'dart:convert';
import 'package:ai_app/pages/home.dart';
import 'package:ai_app/pages/com_form.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../utils/notification_api.dart';

// void main() => runApp(MyApp());

class MyMap extends StatefulWidget {
  final Function dekhBinod;
  const MyMap({
    required this.dekhBinod,
  });
  static bool problemSelected = false;
  static GeoPoint complainLoc = const GeoPoint(0, 0);
  static GeoPoint userLocation = const GeoPoint(0, 0);
  @override
  State<MyMap> createState() => _MyMapState(dekhBinod);
}

class _MyMapState extends State<MyMap> {
  final Function dekhBinod;

  _MyMapState(this.dekhBinod);
  // @override
  // Future<void> initState() async {
  //   super.initState();
  //   // samashyaHe().listen((event) {
  //   //   _markers.addAll(event);
  //   // });
  // }

  // Completer<GoogleMapController> _controller = Completer();
  // // on below line we have specified camera position
  // static final CameraPosition _kGoogle = const CameraPosition(
  //   target: LatLng(23, 23.037965185520633),
  //   zoom: 50,
  // );

// documents ids
  List<String> docIds = [];

// on below line we have created the list of markers
  final _markers = <Marker>[];

// // created method for getting user current location
//   Future<Position> getUserCurrentLocation() async {
//     await Geolocator.requestPermission()
//         .then((value) {})
//         .onError((error, stackTrace) async {
//       await Geolocator.requestPermission();
//       print("ERROR" + error.toString());
//     });
//     return await Geolocator.getCurrentPosition(
//         desiredAccuracy: LocationAccuracy.high);
//   }

  // void dekhBinod() async {
  //   await getUserCurrentLocation().then((value) async {
  //     print(value.latitude.toString() + " " + value.longitude.toString());
  //     MyMap.userLocation = GeoPoint(value.latitude, value.longitude);

  //     // marker added for current users location
  //     _markers.add(
  //       Marker(
  //         markerId: const MarkerId("1"),
  //         position: LatLng(value.latitude, value.longitude),
  //         infoWindow: const InfoWindow(
  //           title: 'My Current Location',
  //         ),
  //         visible: false,
  //       ),
  //     );

  //     // specified current users location
  //     CameraPosition cameraPosition = CameraPosition(
  //       target: LatLng(value.latitude, value.longitude),
  //       zoom: 14,
  //     );

  //     final GoogleMapController controller = await _controller.future;

  //     controller.animateCamera(CameraUpdate.newCameraPosition(cameraPosition));
  //     setState(() {});
  //   });
  // }

  // List<Complain> complain = [];

  Future samashyaHe() async {
//get the collection
    // List<Marker> _samashyas = <Marker>[];
    print("add ho ne vala  ");

    await FirebaseFirestore.instance.collection('problems').get().then(
          (snapshot) => snapshot.docs.forEach(
            (document) async {
              docIds.add(document.reference.id);
              _markers.add(await samashyaKiJagah(document.reference.id));
            },
          ),
        );
    // yield _samashyas;
  }

  // Future samashyaKiJagah(String documentId) async {
  Future<Marker> samashyaKiJagah(String documentId) async {
    FirebaseFirestore db = FirebaseFirestore.instance;
    //get the collection
    print("call to hovA");
    CollectionReference collection =
        FirebaseFirestore.instance.collection("problems");

    // await collection.get().asStream().asyncMap(
    //   (event) {
    //     event.docs;
    //   },
    // );

// ( OnCompleteListener<QuerySnapshot>() {
//                 // @Override
//                 // public void onComplete(@NonNull Task<QuerySnapshot> task) {
//                     if (task.isSuccessful()) {
//                         for (QueryDocumentSnapshot document : task.getResult()) {
//                             Log.i(TAG,document.getData().get("position").toString());
//                         }
//                     } else {
//                         Log.w(TAG, "Error getting documents.", task.getException());
//                     }
//                 // }
//             });

    var problem = await collection.doc(documentId).get();
    // var problem = await collection.doc(documentId).get();

    Map<String, dynamic> data = problem.data() as Map<String, dynamic>;

    // GeoPoint geopoint = data['problemLocation']!;
    GeoPoint geopoint = const GeoPoint(0, 0);
    if (await data['problemLocation'] != null) {
      geopoint = data['problemLocation'] as GeoPoint;
      print(geopoint.latitude);
      print(geopoint.longitude);
    }
    print("add ho gaya ${data['problem']} ");
    print("add ho gaya ${geopoint.latitude}  -  ${geopoint.longitude} ");

    return Marker(
      markerId: MarkerId("${documentId}"),
      // markerId: MarkerId("${data['complainTime']}"),
      // position: data['problemLocation'],
      position: LatLng(geopoint.latitude, geopoint.longitude),
      infoWindow: InfoWindow(
        // title: data['problem'].toString(),
        title: data['problem'],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return
        //  Scaffold(
        // floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        // appBar: AppBar(
        //   title: const Text("select location"),
        //   actions: <Widget>[
        //     // on pressing icon button the camera will take to user current location
        //     IconButton(
        //       tooltip: 'find current location',
        //       icon: const Icon(Icons.location_searching_rounded),
        //       onPressed: () => dekhBinod(),
        //     ),
        //   ],
        // ),
        // body:
        SafeArea(
      // on below line creating google maps
      child: GoogleMap(
        onTap: (argument) {
          if (MyMap.problemSelected) {
            _markers.removeWhere(
              (element) => element.markerId.value == 'user Location',
            );
          }

          setState(
            () {
              MyMap.problemSelected = true;
              print(MyMap.problemSelected);
              MyMap.complainLoc =
                  GeoPoint(argument.latitude, argument.longitude);
              _markers.add(
                Marker(
                  markerId: const MarkerId('user Location'),
                  position: argument,
                  infoWindow: const InfoWindow(
                    title: 'Problem',
                  ),
                ),
              );
              // _markers.add(samashyaKiJagah(docIds[0]));
              // FutureBuilder(
              //   future: samashyaHe(),
              //   builder: (context, snapshot) {
              //     // _markers.add(samashyaKiJagah(docIds[0]));
              //   },
              // );
            },
          );
        },
        // on below line setting camera position
        initialCameraPosition: Home.kGoogle,
        // on below line we are setting markers on the map
        // markers: Set<Marker>.of(_markers),
        markers: Set.of(_markers),
        // on below line specifying map type.
        mapType: MapType.normal,
        // on below line setting user location enabled.
        myLocationEnabled: true,
        // on below line setting compass enabled.
        compassEnabled: true,
        // on below line specifying controller on map complete.

        onMapCreated: (GoogleMapController controller) async {
          // samashyaHe().listen((event) {
          //   _markers.addAll(event);
          // });
          // samashyaHe();

          await samashyaHe();
          Home.controller.complete(controller);
          dekhBinod();
        },
      ),
    );
  }
}
