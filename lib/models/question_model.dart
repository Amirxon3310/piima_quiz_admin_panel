class QuestionModel {
  final String id;
  final String categoryId;
  final String createdAt;
  final Map<String, dynamic> creator;
  final String favorited;
  final String? photo;
  final String played;
  final String questions;
  final String questionsBodyId;
  final String shared;
  final String title;

  QuestionModel({
    required this.id,
    required this.categoryId,
    required this.createdAt,
    required this.creator,
    required this.favorited,
    this.photo,
    required this.played,
    required this.questions,
    required this.questionsBodyId,
    required this.shared,
    required this.title,
  });

  factory QuestionModel.fromMap(Map<String, dynamic> map,) {
    return QuestionModel(
      id: map["id"] ?? "",
      categoryId: map["category_id"],
      createdAt: map["created_at"],
      creator: map["creator"],
      favorited: map["favorited"],
      played: map["played"],
      questions: map["questions"],
      questionsBodyId: map["questions_body_id"],
      shared: map["shared"],
      title: map["title"],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "category_id": categoryId,
      "created_at": createdAt,
      "creator": creator,
      "favorited": favorited,
      "photo": photo,
      "played": played,
      "questions": questions,
      "questions_body_id": questionsBodyId,
      "shared": shared,
      "title": title,
    };
  }

  QuestionModel copyWith({
    String? id,
    String? categoryId,
    String? createdAt,
    Map<String, dynamic>? creator,
    String? favorited,
    String? photo,
    String? played,
    String? questions,
    String? questionsBodyId,
    String? shared,
    String? title,
  }) {
    return QuestionModel(
      id: id ?? this.id,
      categoryId: categoryId ?? this.categoryId,
      createdAt: createdAt ?? this.createdAt,
      creator: creator ?? this.creator,
      favorited: favorited ?? this.favorited,
      photo: photo ?? this.photo,
      played: played ?? this.played,
      questions: questions ?? this.questions,
      questionsBodyId: questionsBodyId ?? this.questionsBodyId,
      shared: shared ?? this.shared,
      title: title ?? this.title,
    );
  }
}
