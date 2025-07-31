import 'package:piima_quiz_admin_panel/datasources/category_remote_datasource.dart';
import 'package:piima_quiz_admin_panel/models/category_model.dart';

class CategoryRepository {
  final CategoryRemoteDatasource remote;

  CategoryRepository(this.remote);

  Future<void> addCategory(CategoryModel category) =>
      remote.addCategory(category);

  Stream<List<CategoryModel>> getCategories() => remote.getCategories();

  Future<void> updateCategory(CategoryModel category) =>
      remote.updateCategory(category);

  Future<void> deleteCategory(String id) => remote.deleteCategory(id);
}
