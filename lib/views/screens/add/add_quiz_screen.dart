import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:piima_quiz_admin_panel/datasources/quiz_remote_datasource.dart';
import 'package:piima_quiz_admin_panel/models/answer_model.dart';
import 'package:piima_quiz_admin_panel/models/question_body_model.dart';
import 'package:piima_quiz_admin_panel/models/question_model.dart';
import 'package:piima_quiz_admin_panel/models/quiz_question_ui_model.dart';
import 'package:piima_quiz_admin_panel/repositories/quiz_repository.dart';
import 'package:piima_quiz_admin_panel/viewmodels/category_viewmodel.dart';
import 'package:piima_quiz_admin_panel/viewmodels/quiz_viewmodel.dart';
import 'package:piima_quiz_admin_panel/views/widgets/custom_input_widget.dart';
import 'package:uuid/uuid.dart';

class AddQuizScreen extends StatefulWidget {
  const AddQuizScreen({super.key});

  @override
  State<AddQuizScreen> createState() => _AddQuizScreenState();
}

class _AddQuizScreenState extends State<AddQuizScreen> {
  final titleController = TextEditingController();
  final imageController = TextEditingController();
  final quizViewmodel = Get.put<QuizViewmodel>(
    QuizViewmodel(QuizRepository(QuizRemoteDatasource())),
  );

  String? selectedCategoryId;
  List<QuizQuestionUIModel> questions = [];

  @override
  void initState() {
    super.initState();
    questions.add(QuizQuestionUIModel());
  }

  void submitQuiz() async {
    if (selectedCategoryId == null || titleController.text.isEmpty) {
      Get.snackbar("Xatolik", "Barcha maydonlarni to'ldiring!");
      return;
    }

    final quizId = const Uuid().v4();
    const questionBodyId = "30XdTYgYAqZtuxYsFftf";

    final quiz = QuestionModel(
      id: quizId,
      categoryId: selectedCategoryId!,
      createdAt: DateTime.now().toIso8601String(),
      creator: {
        "name": "Admin",
        "photo":
            "https://icon-library.com/images/admin-icon-png/admin-icon-png-18.jpg",
        "user_id": ""
      },
      favorited: "",
      photo: imageController.text,
      played: "0",
      questions: questions.length.toString(),
      questionsBodyId: questionBodyId,
      shared: "0",
      title: titleController.text,
    );

    final List<QuestionItemModel> questionItems = [];
    final List<AnswerModel> answerItems = [];

    for (var q in questions) {
      final questionId = const Uuid().v4();

      final options = List.generate(4, (i) {
        final oid = const Uuid().v4();
        return OptionModel(id: oid, text: q.optionControllers[i].text);
      });

      final correctOption = options[q.correctAnswerIndex];

      questionItems.add(
        QuestionItemModel(
          id: questionId,
          image: q.imageController.text,
          question: q.questionController.text,
          options: options,
        ),
      );

      answerItems.add(
        AnswerModel(
          answerId: correctOption.id,
          questionId: questionId,
        ),
      );
    }

    await quizViewmodel.addQuiz(quiz, questionItems, answerItems);

    Get.snackbar("Muvaffaqiyatli", "Quiz qo'shildi!",
        backgroundColor: Colors.green);
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Quiz qo'shish"),
        actions: [
          IconButton(
            icon: const Icon(Icons.check),
            onPressed: submitQuiz,
          )
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(12),
        child: Column(
          spacing: 12,
          children: [
            DropdownButtonFormField<String>(
              value: selectedCategoryId,
              hint: const Text("Kategoriya tanlang"),
              items: Get.find<CategoryViewmodel>().categories.map((cat) {
                return DropdownMenuItem(
                  value: cat.id,
                  child: Text(cat.title),
                );
              }).toList(),
              onChanged: (val) {
                setState(() {
                  selectedCategoryId = val;
                });
              },
            ),
            CustomInputWidget(controller: titleController, title: "Quiz nomi"),
            CustomInputWidget(
              controller: imageController,
              title: "URL (quiz rasmi uchun)",
              hasMoreLines: true,
            ),
            const SizedBox(height: 20),
            ...questions.asMap().entries.map((entry) {
              final index = entry.key;
              final q = entry.value;

              return Card(
                margin: const EdgeInsets.symmetric(vertical: 8),
                elevation: 3,
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: Column(
                    spacing: 8,
                    children: [
                      Text("Savol ${index + 1}",
                          style: const TextStyle(fontWeight: FontWeight.bold)),
                      const SizedBox(height: 8),
                      CustomInputWidget(
                        controller: q.questionController,
                        title: "Savol matni",
                      ),
                      CustomInputWidget(
                        controller: q.imageController,
                        title: "URL (savol uchun)(optional)",
                        hasMoreLines: true,
                      ),
                      ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: 4,
                        itemBuilder: (context, i) {
                          return RadioListTile(
                            value: i,
                            groupValue: q.correctAnswerIndex,
                            onChanged: (val) {
                              setState(() {
                                q.correctAnswerIndex = val!;
                              });
                            },
                            title: CustomInputWidget(
                                controller: q.optionControllers[i],
                                title: "Variant ${i + 1}"),
                          );
                        },
                      ),
                      const SizedBox(height: 6),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          if (questions.length > 1)
                            TextButton.icon(
                              icon: const Icon(Icons.delete),
                              label: const Text("O'chirish"),
                              onPressed: () {
                                setState(() {
                                  questions.removeAt(index);
                                });
                              },
                            ),
                        ],
                      )
                    ],
                  ),
                ),
              );
            }),
            const SizedBox(height: 10),
            ElevatedButton.icon(
              onPressed: () {
                setState(() {
                  questions.add(QuizQuestionUIModel());
                });
              },
              icon: const Icon(Icons.add),
              label: const Text("Savol qo'shish"),
            )
          ],
        ),
      ),
    );
  }
}
