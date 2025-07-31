import 'package:get/get.dart';
import 'package:piima_quiz_admin_panel/datasources/category_remote_datasource.dart';
import 'package:piima_quiz_admin_panel/models/category_model.dart';
import 'package:piima_quiz_admin_panel/repositories/category_repository.dart';

class CategoryViewmodel extends GetxController {
  late final CategoryRepository repository;

  final isLoading = false.obs;
  final categories = <CategoryModel>[].obs;

  @override
  void onInit() {
    repository = CategoryRepository(CategoryRemoteDatasource());
    repository.getCategories().listen((data) {
      categories.value = data;
    });
    super.onInit();
  }

  Future<void> addCategory(String title, String imageUrl) async {
    isLoading.value = true;

    final id = DateTime.now().millisecondsSinceEpoch.toString();
    final category = CategoryModel(id: id, title: title, imageUrl: imageUrl);
    await repository.addCategory(category);

    isLoading.value = false;
  }

  Future<void> updateCategory(String id, String title, String imageUrl) async {
    final category = CategoryModel(id: id, title: title, imageUrl: imageUrl);
    await repository.updateCategory(category);
  }

  Future<void> deleteCategory(String id) async {
    await repository.deleteCategory(id);
  }
}
