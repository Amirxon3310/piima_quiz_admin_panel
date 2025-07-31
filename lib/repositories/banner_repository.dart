import 'package:piima_quiz_admin_panel/datasources/banner_remote_datasource.dart';
import 'package:piima_quiz_admin_panel/models/banner_model.dart';

class BannerRepository {
  final BannerRemoteDatasource remote;

  BannerRepository(this.remote);

  Future<void> addBanner(BannerModel banner) => remote.addBanner(banner);

  Stream<List<BannerModel>> getBanners() => remote.getBanners();

  Future<void> updateBanner(BannerModel banner) => remote.updateBanner(banner);

  Future<void> deleteBanner(String id) => remote.deleteBanner(id);
}
