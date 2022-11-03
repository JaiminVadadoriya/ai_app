import 'package:flutter/material.dart';

class ProbSelect extends StatefulWidget {
  const ProbSelect({super.key});

  @override
  State<ProbSelect> createState() => _ProbSelectState();
}

class _ProbSelectState extends State<ProbSelect> {
  String dropdownvalue = "";

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18),
          child: DropdownButton(
            hint: Text("Select Your Problems"),
            isExpanded: true,
            items: [
              DropdownMenuItem(
                child: Text("Road"),
                value: "Road",
              ),
              DropdownMenuItem(
                child: Text("Street Light"),
                value: "Street Light",
              ),
              DropdownMenuItem(
                child: Text("Garbage Collection"),
                value: "Garbage Collection",
              ),
            ],
            // value: dropdownvalue,
            onChanged: (value) => {
              setState(() {
                dropdownvalue = value.toString();
              })
            },
          ),
        ),
        dropdownvalue.isEmpty
            ? Container(
                padding: const EdgeInsets.symmetric(vertical: 30),
                child: Text("Please select problem from above"),
              )
            : Container(
                padding: const EdgeInsets.symmetric(vertical: 30),
                child: Text("You Select : $dropdownvalue"),
              ),
      ],
    );
  }
}
