// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:ai_app/widgets/select_image.dart';
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
        title: const Text("Problem Details"),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_rounded),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.symmetric(
            horizontal: 15,
            vertical: 10,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SelectImage(
                    problem: complain.problem,
                    sizeImg: 100,
                  )
                ],
              ),
              Container(
                margin: const EdgeInsets.symmetric(
                  horizontal: 15,
                  vertical: 10,
                ),
                width: double.infinity,
                child: Text(
                  "${complain.problem}",
                  style: const TextStyle(
                    fontSize: 26,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              const Text(
                "Address:",
                style: TextStyle(
                  fontSize: 18,
                ),
                textAlign: TextAlign.left,
              ),
              Text("${complain.address}"),
              const SizedBox(
                height: 10,
              ),
              const Divider(),
              const Text(
                "Time:",
                style: TextStyle(
                  fontSize: 18,
                ),
                textAlign: TextAlign.left,
              ),
              Text("${complain.complainTime?.toDate()}"),
              const SizedBox(
                height: 8,
              ),
              const Divider(),
              const Text(
                "Description:",
                style: TextStyle(
                  fontSize: 18,
                ),
                textAlign: TextAlign.left,
              ),
              Text("${complain.description}"),
              const SizedBox(
                height: 8,
              ),
              const Divider(),
              const Text(
                "Problem Location:",
                style: TextStyle(
                  fontSize: 18,
                ),
                textAlign: TextAlign.left,
              ),
              Text(
                  "[ ${complain.problemLocation?.latitude} - ${complain.problemLocation?.longitude} ]"),
              const SizedBox(
                height: 8,
              ),
              const Divider(),
              const Text(
                "Process:",
                style: TextStyle(
                  fontSize: 18,
                ),
                textAlign: TextAlign.left,
              ),
              Text("${complain.problemProcess}"),
              const SizedBox(
                height: 8,
              ),
              const Divider(),
              const Text(
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
