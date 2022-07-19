import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final String text;
  const CustomTextField({Key? key, required this.controller, required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
    border: const OutlineInputBorder(),
    labelText: text,
  ),
      style: const TextStyle(color: Colors.black),
    );
  }
}
