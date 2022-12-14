import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;

  // ignore: prefer_const_constructors_in_immutables
  CustomTextField({
    required this.hint,
    required this.controller,
  });
  final String hint;
  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: const Color.fromARGB(255, 22, 18, 1))),
        child: TextFormField(
          controller: controller,
          maxLines: 2,
          minLines: 1,
          decoration: InputDecoration(border: InputBorder.none, hintText: hint),
        ));
  }
}
