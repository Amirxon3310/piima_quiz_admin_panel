import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:piima_quiz_admin_panel/models/question_model.dart';
import 'package:piima_quiz_admin_panel/models/question_body_model.dart';
import 'package:piima_quiz_admin_panel/models/answer_model.dart';

class QuizRemoteDatasource {
  final _firestore = FirebaseFirestore.instance;

  Future<void> addQuiz({
    required QuestionModel quiz,
    required List<QuestionItemModel> questions,
    required List<AnswerModel> answers,
  }) async {
    try {
      final bodyDocRef = await _firestore.collection("questions_body").add({});
      final questionsBodyId = bodyDocRef.id;

      final quizWithBodyId = quiz.copyWith(questionsBodyId: questionsBodyId);

      await _firestore
          .collection("questions")
          .doc(quizWithBodyId.id)
          .set(quizWithBodyId.toMap());

      for (final question in questions) {
        await _firestore
            .collection("questions_body")
            .doc(questionsBodyId)
            .collection("questions")
            .doc(question.id)
            .set(question.toMap());
      }

      for (final answer in answers) {
        await _firestore
            .collection("answers")
            .doc(answer.questionId)
            .set(answer.toMap());
      }
    } catch (e) {
      throw Exception("Quiz qo'shishda xatolik: $e");
    }
  }

  Future<List<QuestionModel>> getQuizs() async {
    final quizs = await _firestore.collection("questions").get();
    // return quizs.snapshots().map(
    //   (snapshot) {
    //     return snapshot.docs.map((doc) {
    //       return QuestionModel.fromMap(doc.data(), doc.id);
    //     }).toList();
    //   },
    // );
   return quizs.docs.map((doc) => QuestionModel.fromMap(doc.data())).toList();
  }
}
