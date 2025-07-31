import 'package:flutter/material.dart';

class CustomInputWidget extends StatelessWidget {
  final TextEditingController controller;
  final String title;
  final bool hasMoreLines;
  const CustomInputWidget({
    super.key,
    required this.controller,
    required this.title,
    this.hasMoreLines = false,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      maxLines: hasMoreLines ? null : 1,
      keyboardType: hasMoreLines ? TextInputType.multiline : TextInputType.text,
      cursorColor: Color(0xFF0189FF),
      decoration: InputDecoration(
        hintText: title,
        border: OutlineInputBorder(),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Color(0xFF0189FF)),
        ),
      ),
    );
  }
}
