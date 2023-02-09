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
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_rounded),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.symmetric(
            horizontal: 15,
            vertical: 10,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: EdgeInsets.symmetric(
                  horizontal: 15,
                  vertical: 10,
                ),
                width: double.infinity,
                child: Text(
                  "-${complain.problem}-",
                  style: TextStyle(
                    fontSize: 26,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                "Address:",
                style: TextStyle(
                  fontSize: 18,
                ),
                textAlign: TextAlign.left,
              ),
              Text("${complain.address}"),
              SizedBox(
                height: 8,
              ),
              Divider(),
              Text(
                "Time:",
                style: TextStyle(
                  fontSize: 18,
                ),
                textAlign: TextAlign.left,
              ),
              Text("${complain.complainTime?.toDate()}"),
              SizedBox(
                height: 8,
              ),
              Divider(),
              Text(
                "Description:",
                style: TextStyle(
                  fontSize: 18,
                ),
                textAlign: TextAlign.left,
              ),
              Text("${complain.description}"),
              SizedBox(
                height: 8,
              ),
              Divider(),
              Text(
                "Problem Location:",
                style: TextStyle(
                  fontSize: 18,
                ),
                textAlign: TextAlign.left,
              ),
              Text(
                  "[ ${complain.problemLocation?.latitude} - ${complain.problemLocation?.longitude} ]"),
              SizedBox(
                height: 8,
              ),
              Divider(),
              Text(
                "Process:",
                style: TextStyle(
                  fontSize: 18,
                ),
                textAlign: TextAlign.left,
              ),
              Text("${complain.problemProcess}"),
              SizedBox(
                height: 8,
              ),
              Divider(),
              Text(
                "Pincode:",
                style: TextStyle(
                  fontSize: 18,
                ),
                textAlign: TextAlign.right,
              ),
              Text("${complain.pincode}"),
            ],
          ),
        ),
      ),
    );
  }
}
