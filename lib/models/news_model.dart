class NewsModel {
  final String? id;
  final String title;
  final String body;
  final Map<String, dynamic>? author;
  final String imageUrl;

  NewsModel({
    this.id,
    required this.title,
    required this.body,
    this.author,
    required this.imageUrl,
  });

  factory NewsModel.fromMap(Map<String, dynamic> map, String id) {
    return NewsModel(
      id: map["id"] ?? id,
      title: map["title"] ?? "",
      body: map["body"] ?? "",
      author: map["author"] ?? {"id": id, "name": "Admin"},
      imageUrl: map["url"] ?? "",
    );
  }

  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "title": title,
      "body": body,
      "author": {"id": id, "name": "Admin"},
      "url": imageUrl,
    };
  }
}
