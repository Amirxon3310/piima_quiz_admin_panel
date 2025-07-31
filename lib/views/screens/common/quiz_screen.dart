import 'package:flutter/material.dart';
import 'package:piima_quiz_admin_panel/views/screens/add/add_quiz_screen.dart';

class QuizScreen extends StatelessWidget {
  const QuizScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Quizlar"),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => AddQuizScreen(),
                ),
              );
            },
            icon: Icon(Icons.add_box_rounded),
          )
        ],
        centerTitle: true,
      ),
      body: Center(
        child: Text("Bu yerda quizlar chiqadi!"),
      ),
    );
  }
}
