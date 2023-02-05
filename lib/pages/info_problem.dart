// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:ai_app/models/complain.dart';

class InfoProblem extends StatelessWidget {
  final Complain complain;
  const InfoProblem({
    Key? key,
    required this.complain,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Problem Details"),
      ),
      body: Center(
        child: Container(
          child: Column(children: [
            Text(
              "${complain.problem}",
              style: TextStyle(
                fontSize: 22,
              ),
            ),
            Text("Address: ${complain.address}"),
            Text("Time: ${complain.complainTime?.toDate()}"),
            Text("Description: ${complain.description}"),
            Text(
                "Problem Location: [ ${complain.problemLocation?.latitude} - ${complain.problemLocation?.longitude} ]"),
            Text("Process: ${complain.problemProcess}"),
            Text("Pincode: ${complain.pincode}"),
          ]),
        ),
      ),
    );
  }
}
