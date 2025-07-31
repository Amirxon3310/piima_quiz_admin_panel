import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:piima_quiz_admin_panel/viewmodels/category_viewmodel.dart';
import 'package:piima_quiz_admin_panel/views/widgets/custom_button.dart';
import 'package:piima_quiz_admin_panel/views/widgets/custom_input_widget.dart';
import 'package:piima_quiz_admin_panel/views/widgets/custom_loading_widget.dart';

class AddCategoryScreen extends StatelessWidget {
  const AddCategoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final categoryViewmodel = Get.put(CategoryViewmodel());

    final categoryNameController = TextEditingController();
    final imageController = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        title: Text("Kategoriya qo'shish"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          child: Column(
            spacing: 20,
            children: [
              CustomInputWidget(
                controller: categoryNameController,
                title: "Kategoriya nomi ...",
              ),
              CustomInputWidget(
                controller: imageController,
                title: "URL (rasm uchun) ...",
                hasMoreLines: true,
              ),
              Obx(
                () {
                  return categoryViewmodel.isLoading.value
                      ? CustomLoadingWidget()
                      : CustomButton(
                          onPressed: () async {
                            final title = categoryNameController.text.trim();
                            final imageUrl = imageController.text.trim();

                            if (title.isNotEmpty && imageUrl.isNotEmpty) {
                              await categoryViewmodel.addCategory(
                                  title, imageUrl);
                              Get.snackbar(
                                'Success',
                                "Kategoriya qo'shildi!",
                                duration: const Duration(seconds: 1),
                                backgroundColor: Colors.green,
                              );
                              categoryNameController.clear();
                              imageController.clear();
                              await Future.delayed(
                                const Duration(seconds: 1),
                                () {
                                  if (context.mounted) {
                                    Navigator.pop(context);
                                  }
                                },
                              );
                            } else {
                              Get.snackbar("Error",
                                  "Barcha maydonlar to'ldirilishi shart");
                            }
                          },
                          title: "Qo'shish",
                        );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
