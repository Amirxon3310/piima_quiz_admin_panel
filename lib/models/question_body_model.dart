class QuestionBodyModel {
  final String id;
  final List<QuestionItemModel> questions;

  QuestionBodyModel({required this.id, required this.questions});

  Map<String, dynamic> toMap() => {
        "id": id,
      };
}

class QuestionItemModel {
  final String id;
  final String? image;
  final String question;
  final List<OptionModel> options;

  QuestionItemModel({
    required this.id,
    this.image,
    required this.question,
    required this.options,
  });

  Map<String, dynamic> toMap() => {
        "id": id,
        "image": image,
        "question": question,
        "options": options.map((o) => o.toMap()).toList(),
      };
}

class OptionModel {
  final String id;
  final String text;

  OptionModel({required this.id, required this.text});

  Map<String, dynamic> toMap() => {
        "id": id,
        "text": text,
      };
}
