import 'package:ai_app/pages/feedbck.dart';
import 'package:ai_app/pages/home.dart';
import 'package:ai_app/widgets/user_map.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
// import 'package:intl/intl.dart';
import 'package:flutter/material.dart'
    show
        AppBar,
        BuildContext,
        Column,
        Container,
        EdgeInsets,
        ElevatedButton,
        Form,
        FormState,
        GlobalKey,
        MaterialPageRoute,
        Navigator,
        Padding,
        Scaffold,
        SingleChildScrollView,
        State,
        StatefulWidget,
        Text,
        TextEditingController,
        TextStyle,
        Widget;

import 'package:ai_app/models/complain.dart';
import 'package:ai_app/widgets/prob_select.dart';
import 'package:ai_app/widgets/text_field_com.dart';

import '../utils/notification_api.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';

class ComForm extends StatefulWidget {
  // final LatLng currentLoc;
  // final LatLng problemLoc;
  // ComForm({
  //   required this.currentLoc,
  //   required this.problemLoc,
  // });
  static const String _title = 'Geo tag App';

  const ComForm({super.key});

  @override
  State<ComForm> createState() => _ComFormState();
}

class _ComFormState extends State<ComForm> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    NotificationApi.initState();
    listenNotifications();
  }

  void listenNotifications() =>
      NotificationApi.onNotification.stream.listen(onClickedNotification);

  void onClickedNotification(String? payload) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => FeedBck(documentId: payload),
      ),
    );
  }
  // List<Complain> allComplain = [
  //   Complain(
  //     problem: 'Road',
  //     description: 'kuch bhi',
  //     address: 'Vrindavan Society, Bapu Nagar, Ahmedabad',
  //     pincode: 345621,
  //     complainTime: Timestamp.now(),
  //     problemLocation: MapSample.complainLoc,
  //     email: "jaiminvadadoriya@gmail.com",
  //     // problemLoc: {
  //     //   "latitude": MapSample.complainLoc.latitude,
  //     //   "longitude": MapSample.complainLoc.longitude,
  //     // },
  //     currentLocation: MapSample.userLocation,
  //     // currentLoc: {
  //     //   "latitude": MapSample.userLocation.latitude,
  //     //   "longitude": MapSample.userLocation.longitude,
  //     // },
  //   ),
  // ];

  String dropdownvalue = "Road";

  final _formKey = GlobalKey<FormState>();

  void dropDownFun(String value) {
    setState(() {
      dropdownvalue = value.toString();
    });
  }

  @override
  Widget build(BuildContext context) {
    TextEditingController desController = TextEditingController();
    TextEditingController addrController = TextEditingController();
    TextEditingController pinController = TextEditingController();

    // below line is used to get the
    // instance of our FIrebase database.
    final FirebaseFirestore db = FirebaseFirestore.instance;
    // below line is used to get collection reference for our database.
    final collection = db.collection("problems");
    Complain _complainUser;
    // _submitData() {
    //   Complain ex = Complain(
    //     id: DateTime.now().second,
    //     problem: dropdownvalue,
    //     description: desController.text,
    //     address: addrController.text,
    //     pincode: int.parse(pinController.text),
    //     comTime: DateTime.now(),
    //   );

    // print("id: ${ex.id} \n");
    // print("problem: ${ex.problem} \n");
    // print("description: ${ex.description} \n");
    // print("address: ${ex.address} \n");
    // print("pincode: ${ex.pincode} \n");
    // print("comTime: ${ex.comTime} \n");
    //   allComplain.add(ex);
    // }

    return Scaffold(
      appBar: AppBar(title: const Text(ComForm._title)),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 0, vertical: 40.0),
                child: Text(
                  "Describe your Problem",
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
              ),
              ProbSelect(
                dropDownFun: dropDownFun,
                dropdownvalue: dropdownvalue,
              ),
              TextFiledCom(
                controller: pinController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Enter PinCode';
                  } else if (value.length != 6) {
                    return 'Invalid PinCode';
                  }
                  return null;
                },
                labelText: 'Pin code',
                hintText: 'eg:392350',
              ),
              // SizedBox(
              //   height: 30.0,
              // ),
              TextFiledCom(
                controller: desController,
                labelText: 'Description about problem',
                hintText: '',
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Describe your problem';
                  }
                  return null;
                },
              ),
              TextFiledCom(
                controller: addrController,
                labelText: 'Enter problem address',
                hintText: '',
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Enter Address of problem';
                  }
                  return null;
                },
              ),
              Container(
                height: 50,
                padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                child: ElevatedButton(
                  child: const Text('Submit Problem'),
                  onPressed: () async {
                    final userEmail =
                        await FirebaseAuth.instance.currentUser!.email;
                    if (_formKey.currentState!.validate()) {
                      _complainUser = Complain(
                        problem: dropdownvalue,
                        description: desController.text,
                        address: addrController.text,
                        problemProcess: "register",
                        pincode: int.parse(pinController.text),
                        // complainTime: DateFormat("yyyy-MM-ddTHH:mm:ss").format(DateTime.now),
                        complainTime: Timestamp.now(),
                        email: userEmail,
                        problemLocation: MyMap.complainLoc,
                        // problemLoc: {
                        //   "latitude": MapSample.complainLoc.latitude,
                        //   "longitude": MapSample.complainLoc.longitude,
                        // },
                        currentLocation: MyMap.userLocation,
                        // currentLoc: {
                        //   "latitude": MapSample.userLocation.latitude,
                        //   "longitude": MapSample.userLocation.longitude,
                        // },
                      );

                      /////////////////////////
                      ///add to fire base
                      /////////////////////////

                      final docRef = collection
                          .withConverter(
                            fromFirestore: Complain.fromFirestore,
                            toFirestore: (Complain city, options) =>
                                city.toFirestore(),
                          )
                          .doc();

                      docRef.set(_complainUser).then(
                            (value) =>
                                NotificationApi.showScheduledNotification(
                              title: 'hey',
                              body: '${docRef.id}',
                              payload: '${docRef.id}',
                              scheduledDate: DateTime.now().add(
                                Duration(
                                  seconds: 12,
                                ),
                              ),
                            ).onError(
                              (error, stackTrace) =>
                                  print("${error} -${stackTrace}"),
                            ),
                          );
                      // allComplain.add(_complainUser);
                      // print(
                      //     "\n$dropdownvalue-${desController.text}-${addrController.text}-${int.parse(pinController.text)}"),
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Home(),
                        ),
                      );
                    }
                    if (pinController.text.length != 6) {
                      pinController.clear();
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
