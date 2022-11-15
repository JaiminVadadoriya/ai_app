// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

class TextFiledCom extends StatelessWidget {
  TextEditingController controller;
  final String? labelText;
  final String? hintText;
  Function validator;
  TextFiledCom({
    Key? key,
    required this.controller,
    required this.labelText,
    required this.hintText,
    required this.validator,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
          border: OutlineInputBorder(),
          // labelText: 'Description about problem',
          labelText: labelText,
          // hintText: 'eg:392350',
          hintText: hintText,
        ),
        validator: (value) => validator(value),
      ),
    );
  }
}
