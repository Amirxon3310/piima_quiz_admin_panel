import 'package:get/get.dart';
import 'package:piima_quiz_admin_panel/datasources/news_remote_datasource.dart';
import 'package:piima_quiz_admin_panel/models/news_model.dart';
import 'package:piima_quiz_admin_panel/repositories/news_repository.dart';

class NewsViewmodel extends GetxController {
  late final NewsRepository repository;

  final isLoading = false.obs;
  final news = <NewsModel>[].obs;

  @override
  void onInit() {
    repository = NewsRepository(NewsRemoteDatasource());
    repository.getNews().listen((data) {
      news.value = data;
    });
    super.onInit();
  }

  Future<void> addNews(String title, String body, String imageUrl) async {
    isLoading.value = true;

    final id = DateTime.now().millisecondsSinceEpoch.toString();
    final newNews =
        NewsModel(id: id, title: title, body: body, imageUrl: imageUrl);
    await repository.addNews(newNews);

    isLoading.value = false;
  }

  Future<void> updateNews(
      String id, String title, String body, String imageUrl) async {
    final updatedNews =
        NewsModel(id: id, title: title, body: body, imageUrl: imageUrl);
    await repository.updateNews(updatedNews);
  }

  Future<void> deleteNews(String id) async {
    await repository.deleteNews(id);
  }
}
