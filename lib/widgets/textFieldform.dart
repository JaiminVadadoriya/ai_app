// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class TextFiledform extends StatelessWidget {
  TextInputType? keyType;
  TextEditingController controller;
  final String? labelText;
  final String? hintText;
  Function validator;
  TextFiledform({
    Key? key,
    required this.controller,
    required this.labelText,
    required this.hintText,
    required this.validator,
    required this.keyType,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: keyType,
      controller: controller,
      decoration: InputDecoration(
        // border: OutlineInputBorder(),
        border: UnderlineInputBorder(),
        // labelText: 'Description about problem',
        labelText: labelText,
        // hintText: 'eg:392350',
        hintText: hintText,
      ),
      validator: (value) => validator(value),
    );
  }
}
