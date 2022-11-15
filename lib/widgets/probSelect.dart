// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

class ProbSelect extends StatefulWidget {
  String dropdownvalue;
  Function dropDownFun;

  ProbSelect({
    required this.dropdownvalue,
    required this.dropDownFun,
  });
  @override
  State<ProbSelect> createState() => _ProbSelectState();
}

class _ProbSelectState extends State<ProbSelect> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18),
          child: DropdownButton(
            hint: Text("Select Your Problems"),
            value: widget.dropdownvalue,
            isExpanded: true,
            borderRadius: BorderRadius.all(Radius.circular(.2)),
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
            onChanged: (value) => widget.dropDownFun(value),
          ),
        ),
        widget.dropdownvalue.isEmpty
            ? Container(
                // padding: const EdgeInsets.symmetric(vertical: 30),
                child: Text("Please select problem from above"),
              )
            : Container(),
      ],
    );
  }
}
