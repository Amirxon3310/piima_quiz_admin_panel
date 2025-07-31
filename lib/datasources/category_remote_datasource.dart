import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:piima_quiz_admin_panel/models/category_model.dart';

class CategoryRemoteDatasource {
  final categories = FirebaseFirestore.instance.collection("categories");

  Future<void> addCategory(CategoryModel category) async {
    final docRef = await categories.add(category.toMap());
    await docRef.update({"id": docRef.id});
  }

  Stream<List<CategoryModel>> getCategories() {
    return categories.snapshots().map(
      (snapshot) {
        return snapshot.docs.map((doc) {
          return CategoryModel.fromMap(doc.data(), doc.id);
        }).toList();
      },
    );
  }

  Future<void> updateCategory(CategoryModel category) async {
    await categories.doc(category.id).update(category.toMap());
  }

  Future<void> deleteCategory(String id) async {
    await categories.doc(id).delete();
  }
}
