class CategoryModel {
  final String? id;
  final String title;
  final String imageUrl;

  CategoryModel({
    this.id,
    required this.title,
    required this.imageUrl,
  });

  factory CategoryModel.fromMap(Map<String, dynamic> map, String id) {
    return CategoryModel(
      id: map["id"] ?? id,
      title: map["title"] ?? "",
      imageUrl: map["url"] ?? "",
    );
  }

  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "title": title,
      "url": imageUrl,
    };
  }
}
