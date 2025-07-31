import 'package:flutter/material.dart';

class CustomLoadingWidget extends StatelessWidget {
  const CustomLoadingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return CircularProgressIndicator(
      color: Color(0xFF0189FF),
    );
  }
}