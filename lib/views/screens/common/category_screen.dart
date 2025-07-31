import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:piima_quiz_admin_panel/viewmodels/category_viewmodel.dart';
import 'package:piima_quiz_admin_panel/views/screens/add/add_category_screen.dart';
import 'package:piima_quiz_admin_panel/views/screens/edit/edit_category_screen.dart';

class CategoryScreen extends StatelessWidget {
  CategoryScreen({super.key});

  final categoryViewmodel = Get.put(CategoryViewmodel());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Kategoriyalar"),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => AddCategoryScreen(),
                ),
              );
            },
            icon: Icon(Icons.add_box_rounded),
          )
        ],
        centerTitle: true,
      ),
      body: Obx(
        () {
          return ListView.separated(
            itemCount: categoryViewmodel.categories.length,
            separatorBuilder: (_, __) => const Divider(),
            itemBuilder: (context, index) {
              final category = categoryViewmodel.categories[index];
              return Container(
                width: double.infinity,
                margin: EdgeInsets.symmetric(horizontal: 10),
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: Colors.black38,
                ),
                child: Row(
                  spacing: 10,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadiusGeometry.circular(12),
                      child: Image.network(
                        category.imageUrl,
                        width: 100,
                        height: 100,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return Placeholder(
                            fallbackWidth: 100,
                            fallbackHeight: 100,
                          );
                        },
                      ),
                    ),
                    Text(category.title),
                    Spacer(),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: const Icon(Icons.edit, color: Colors.blue),
                          onPressed: () {
                            Get.to(
                                () => EditCategoryScreen(category: category));
                          },
                        ),
                        IconButton(
                          icon: const Icon(Icons.delete, color: Colors.red),
                          onPressed: () {
                            Get.defaultDialog(
                              title: "O'chirish",
                              middleText: "Bu kategoriyani o'chirmoqchimisiz?",
                              textConfirm: "Ha",
                              textCancel: "Yo'q",
                              contentPadding: const EdgeInsets.all(30),
                              onConfirm: () async {
                                await categoryViewmodel
                                    .deleteCategory(category.id!);
                                Get.back();
                                Get.snackbar(
                                  "Deleted",
                                  "Kategoriya o'chirildi",
                                  backgroundColor: Colors.red,
                                );
                              },
                            );
                          },
                        ),
                      ],
                    )
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
}
