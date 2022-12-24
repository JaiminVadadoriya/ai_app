import 'package:ai_app/models/complain.dart';
import 'package:ai_app/pages/userhome.dart';
import 'package:ai_app/widgets/probSelect.dart';
import 'package:ai_app/widgets/textFieldCom.dart';
import 'package:flutter/material.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';

class ComForm extends StatefulWidget {
  // final LatLng currentLoc;
  // final LatLng problemLoc;
  // ComForm({
  //   required this.currentLoc,
  //   required this.problemLoc,
  // });
  static const String _title = 'Geo tag App';

  @override
  State<ComForm> createState() => _ComFormState();
}

class _ComFormState extends State<ComForm> {
  List<Complain> allComplain = [
    Complain(
      problem: 'Road',
      desc: 'kuch bhi',
      address: 'Vrindavan Society, Bapu Nagar, Ahmedabad  - 382160',
      pincode: 345621,
    ),
  ];

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

    Complain xyz;
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

    return MaterialApp(
      title: ComForm._title,
      home: Scaffold(
        appBar: AppBar(title: const Text(ComForm._title)),
        body: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 0, vertical: 40.0),
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
                    onPressed: () => {
                      if (_formKey.currentState!.validate())
                        {
                          xyz = Complain(
                            problem: dropdownvalue,
                            desc: desController.text,
                            address: addrController.text,
                            pincode: int.parse(pinController.text),
                          ),
                          allComplain.add(xyz),
                          print(
                              "\n$dropdownvalue-${desController.text}-${addrController.text}-${int.parse(pinController.text)}"),
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => UserHome(
                                allComplain: allComplain,
                              ),
                            ),
                          ),
                        },
                      if (pinController.text.length != 6)
                        {
                          pinController.clear(),
                        },
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
