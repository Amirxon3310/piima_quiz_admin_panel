import 'package:get/get.dart';
import '../models/question_model.dart';
import '../models/answer_model.dart';
import '../models/question_body_model.dart';
import '../repositories/quiz_repository.dart';

class QuizViewmodel extends GetxController {
  final QuizRepository repository;

  QuizViewmodel(this.repository);

  List<QuestionModel> quizs = <QuestionModel>[].obs;

  RxBool isLoading = false.obs;

  Future<void> addQuiz(
    QuestionModel quiz,
    List<QuestionItemModel> questions,
    List<AnswerModel> answers,
  ) async {
    isLoading.value = true;
    await repository.addQuiz(quiz, questions, answers);
    isLoading.value = false;
  }

  Future<void> getQuizs() async {
    isLoading.value = true;
    // quizs = await repository.getQuizs();
  }
}
