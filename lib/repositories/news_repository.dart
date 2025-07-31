import 'package:piima_quiz_admin_panel/datasources/news_remote_datasource.dart';
import 'package:piima_quiz_admin_panel/models/news_model.dart';

class NewsRepository {
  final NewsRemoteDatasource remote;

  NewsRepository(this.remote);

  Future<void> addNews(NewsModel news) => remote.addNews(news);

  Stream<List<NewsModel>> getNews() => remote.getNews();

  Future<void> updateNews(NewsModel news) => remote.updateNews(news);

  Future<void> deleteNews(String id) => remote.deleteNews(id);
}
