import 'package:get/get.dart';
import 'package:piima_quiz_admin_panel/datasources/banner_remote_datasource.dart';
import 'package:piima_quiz_admin_panel/models/banner_model.dart';
import 'package:piima_quiz_admin_panel/repositories/banner_repository.dart';

class BannerViewmodel extends GetxController {
  late final BannerRepository repository;

  final isLoading = false.obs;
  final banners = <BannerModel>[].obs;

  @override
  void onInit() {
    repository = BannerRepository(BannerRemoteDatasource());
    repository.getBanners().listen((data) {
      banners.value = data;
    });
    super.onInit();
  }

  Future<void> addBanner(String title, String imageUrl) async {
    isLoading.value = true;

    final id = DateTime.now().millisecondsSinceEpoch.toString();
    final banner = BannerModel(id: id, title: title, imageUrl: imageUrl);
    await repository.addBanner(banner);

    isLoading.value = false;
  }

  Future<void> updateBanner(String id, String title, String imageUrl) async {
    final banner = BannerModel(id: id, title: title, imageUrl: imageUrl);
    await repository.updateBanner(banner);
  }

  Future<void> deleteBanner(String id) async {
    await repository.deleteBanner(id);
  }
}
