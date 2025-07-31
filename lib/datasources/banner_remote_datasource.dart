import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:piima_quiz_admin_panel/models/banner_model.dart';

class BannerRemoteDatasource {
  final banners = FirebaseFirestore.instance.collection("banners");

  Future<void> addBanner(BannerModel banner) async {
    final docRef = await banners.add(banner.toMap());
    await docRef.update({"id": docRef.id});
  }

  Stream<List<BannerModel>> getBanners() {
    return banners.snapshots().map(
      (snapshot) {
        return snapshot.docs.map((doc) {
          return BannerModel.fromMap(doc.data(), doc.id);
        }).toList();
      },
    );
  }

  Future<void> updateBanner(BannerModel banner) async {
    await banners.doc(banner.id).update(banner.toMap());
  }

  Future<void> deleteBanner(String id) async {
    await banners.doc(id).delete();
  }
}
