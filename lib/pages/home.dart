import 'dart:async';

import 'package:ai_app/pages/com_form.dart';
import 'package:ai_app/utils/notification_api.dart';
import 'package:ai_app/widgets/user_map.dart';
import 'package:ai_app/widgets/all_problem.dart';
import 'package:ai_app/widgets/user_problem.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:timezone/timezone.dart' as tz;

class Home extends StatefulWidget {
  Home({super.key});

  static Completer<GoogleMapController> controller = Completer();

// on below line we have specified camera position
  static final CameraPosition kGoogle = CameraPosition(
    target: LatLng(20.42796133580664, 80.885749655962),
    zoom: 14.4746,
  );

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _selectedIndex = 0;
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

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
    await getUserCurrentLocation().then((value) async {
      print(value.latitude.toString() + " " + value.longitude.toString());
      MyMap.userLocation = GeoPoint(value.latitude, value.longitude);

      // position: LatLng(value.latitude, value.longitude),

      // specified current users location
      CameraPosition cameraPosition = CameraPosition(
        target: LatLng(value.latitude, value.longitude),
        zoom: 14,
      );

      final GoogleMapController controller = await Home.controller.future;

      controller.animateCamera(CameraUpdate.newCameraPosition(cameraPosition));
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    // https://firebase.google.com/docs/firestore/query-data/get-data
//     // below line is used to get the
//     // instance of our FIrebase database.
//     final FirebaseFirestore db = FirebaseFirestore.instance;
//     // below line is used to get collection reference for our database.
//     final collection = db.collection("problems");
//     final docRef = collection
//         .withConverter(
//           fromFirestore: (snapshot, options) => Complain.fromFirestore(
//               snapshot.data()! as DocumentSnapshot<Map<String, dynamic>>,
//               options),
//           toFirestore: (Complain city, options) => city.toFirestore(),
//         )
//         .doc();
// final docSnap = await ref.get();
// final city = docSnap.data(); // Convert to City object
// if (city != null) {
//   print(city);
// } else {
//   print("No such document.");
// }

    List<Widget> widgetOptions = <Widget>[
      MyMap(
        dekhBinod: () => dekhBinod(),
      ),
      AllProblem(),
      UserProblem()

      // MapMun(
      //     cameraTarget: cameraTarget,
      //     dekhBinod: () => {
      //           dekhBinod(),
      //         }),
    ];
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      appBar: _selectedIndex == 0
          ? AppBar(
              title: const Text("select location"),
              actions: <Widget>[
                // on pressing icon button the camera will take to user current location
                IconButton(
                  tooltip: 'find current location',
                  icon: const Icon(Icons.location_searching_rounded),
                  onPressed: () {
                    dekhBinod();
                  },
                ),
              ],
            )
          : AppBar(
              title: const Text("Problems"),
            ),
      body: widgetOptions.elementAt(_selectedIndex),
      // on pressing floating action button the camera will take to user current location
      floatingActionButton: _selectedIndex == 0
          ? FloatingActionButton.extended(
              onPressed: () async {
                // NotificationApi.initState();

                // // void listenNotifications() =>
                // //     NotificationApi.onNotification.stream.listen(onClickedNotification);
                // NotificationApi.showScheduledNotification(
                //   title: 'hi${FirebaseAuth.instance.currentUser?.displayName}',
                //   body: 'hey! Do we have everything we need for the lunch',
                //   payload: 'sarah.abs',
                //   scheduledDate: tz.TZDateTime.now(tz.local).add(
                //     const Duration(seconds: 1),
                //   ),
                // );
                if (MyMap.problemSelected) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: ((context) => const ComForm()),
                    ),
                  );
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                    content: Text("Please select problem location!!!"),
                  ));
                }
              },
              label: const Text('Raise Complain'),
              icon: const Icon(Icons.add),
            )
          : null,
      bottomNavigationBar: BottomNavigationBar(
        elevation: 0,
        selectedIconTheme: IconThemeData(
          color: Colors.black87,
        ),
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
            backgroundColor: Colors.transparent,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.list),
            label: 'All Problems',
            backgroundColor: Colors.transparent,
            // backgroundColor: Colors.green,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle),
            label: 'My Problems',
            backgroundColor: Colors.transparent,
          ),
          // BottomNavigationBarItem(
          //   icon: Icon(Icons.settings),
          //   label: 'Settings',
          //   backgroundColor: Colors.transparent,
          // ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.black87,
        onTap: _onItemTapped,
      ),
    );
  }
}
