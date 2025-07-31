class BannerModel {
  final String? id;
  final String title;
  final String imageUrl;

  BannerModel({
    this.id,
    required this.title,
    required this.imageUrl,
  });

  factory BannerModel.fromMap(Map<String, dynamic> map, String id) {
    return BannerModel(
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
