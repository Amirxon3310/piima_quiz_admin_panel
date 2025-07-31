class AnswerModel {
  final String answerId;
  final String questionId;

  AnswerModel({
    required this.answerId,
    required this.questionId,
  });

  Map<String, dynamic> toMap() => {
        'answer_id': answerId,
        'question_id': questionId,
      };
}
