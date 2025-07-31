import 'package:flutter/material.dart';

class QuizQuestionUIModel {
  final TextEditingController questionController = TextEditingController();
  final TextEditingController imageController = TextEditingController();
  final List<TextEditingController> optionControllers =
      List.generate(4, (_) => TextEditingController());
  int correctAnswerIndex = 0;
}
