import 'package:flutter/material.dart';

class Text_Field extends StatelessWidget {
  final String labeltext;
  final String hinttext;
  final onchange;
  final controller;
  final errorttext;
  const Text_Field({
    super.key,
    required this.labeltext,
    required this.hinttext,
    this.onchange,
    this.controller,
    this.errorttext,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      onChanged: onchange,
      decoration: InputDecoration(
        errorText: errorttext,
        labelText: labeltext,
        hintText: hinttext,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
        ),
      ),
    );
  }
}
