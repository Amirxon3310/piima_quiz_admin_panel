import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:piima_quiz_admin_panel/models/category_model.dart';
import 'package:piima_quiz_admin_panel/viewmodels/category_viewmodel.dart';
import 'package:piima_quiz_admin_panel/views/widgets/custom_button.dart';
import 'package:piima_quiz_admin_panel/views/widgets/custom_input_widget.dart';

class EditCategoryScreen extends StatelessWidget {
  final CategoryModel category;

  EditCategoryScreen({super.key, required this.category});

  final titleController = TextEditingController();
  final imageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    titleController.text = category.title;
    imageController.text = category.imageUrl;
    final viewmodel = Get.find<CategoryViewmodel>();

    return Scaffold(
      appBar: AppBar(
        title: const Text("Tahrirlash"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          spacing: 20,
          children: [
            CustomInputWidget(controller: titleController, title: "Nomi"),
            CustomInputWidget(
              controller: imageController,
              title: "URL",
              hasMoreLines: true,
            ),
            CustomButton(
              onPressed: () async {
                await viewmodel.updateCategory(
                  category.id!,
                  titleController.text.trim(),
                  imageController.text.trim(),
                );
                Get.back();
                Get.snackbar(
                  "Tahrirlandi",
                  "Kategoriya yangilandi",
                  backgroundColor: Colors.orange,
                );
              },
              title: "Tahrirlash",
            ),
          ],
        ),
      ),
    );
  }
}
