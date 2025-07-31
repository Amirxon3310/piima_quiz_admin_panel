import 'package:piima_quiz_admin_panel/datasources/quiz_remote_datasource.dart';
import 'package:piima_quiz_admin_panel/models/answer_model.dart';
import 'package:piima_quiz_admin_panel/models/question_body_model.dart';
import 'package:piima_quiz_admin_panel/models/question_model.dart';

class QuizRepository {
  final QuizRemoteDatasource datasource;

  QuizRepository(this.datasource);

  Future<void> addQuiz(
    QuestionModel quiz,
    List<QuestionItemModel> questions,
    List<AnswerModel> answers,
  ) async {
    await datasource.addQuiz(
      quiz: quiz,
      questions: questions,
      answers: answers,
    );
  }

  // Stream<List<QuestionModel>> getQuizs() => datasource.getQuizs();
}
