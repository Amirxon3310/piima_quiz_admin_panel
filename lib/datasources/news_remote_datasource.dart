import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:piima_quiz_admin_panel/models/news_model.dart';

class NewsRemoteDatasource {
  final newsCollection = FirebaseFirestore.instance.collection("news");

  Future<void> addNews(NewsModel news) async {
    final docRef = await newsCollection.add(news.toMap());
    await docRef.update({"id": docRef.id});
  }

  Stream<List<NewsModel>> getNews() {
    return newsCollection.snapshots().map(
      (snapshot) {
        return snapshot.docs.map((doc) {
          return NewsModel.fromMap(doc.data(), doc.id);
        }).toList();
      },
    );
  }

  Future<void> updateNews(NewsModel news) async {
    await newsCollection.doc(news.id).update(news.toMap());
  }

  Future<void> deleteNews(String id) async {
    await newsCollection.doc(id).delete();
  }
}
