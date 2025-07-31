import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:piima_quiz_admin_panel/viewmodels/news_viewmodel.dart';
import 'package:piima_quiz_admin_panel/views/widgets/custom_button.dart';
import 'package:piima_quiz_admin_panel/views/widgets/custom_input_widget.dart';
import 'package:piima_quiz_admin_panel/views/widgets/custom_loading_widget.dart';

class AddNewsScreen extends StatelessWidget {
  const AddNewsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final newsViewmodel = Get.put(NewsViewmodel());

    final newsTitleController = TextEditingController();
    final newsBodyController = TextEditingController();
    final imageController = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        title: Text("Yangilik qo'shish"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          child: Column(
            spacing: 20,
            children: [
              CustomInputWidget(
                controller: newsTitleController,
                title: "Yangilik nomi ...",
              ),
              CustomInputWidget(
                controller: newsBodyController,
                title: "Yangilik matni ...",
                hasMoreLines: true,
              ),
              CustomInputWidget(
                controller: imageController,
                title: "URL (rasm uchun) ...",
                hasMoreLines: true,
              ),
              Obx(
                () {
                  return newsViewmodel.isLoading.value
                      ? CustomLoadingWidget()
                      : CustomButton(
                          onPressed: () async {
                            final title = newsTitleController.text.trim();
                            final body = newsBodyController.text.trim();
                            final imageUrl = imageController.text.trim();

                            if (title.isNotEmpty &&
                                imageUrl.isNotEmpty &&
                                body.isNotEmpty) {
                              await newsViewmodel.addNews(
                                  title, body, imageUrl);
                              Get.snackbar(
                                'Success',
                                "Yangilik qo'shildi!",
                                duration: const Duration(seconds: 1),
                                backgroundColor: Colors.green,
                              );
                              newsTitleController.clear();
                              newsBodyController.clear();
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
