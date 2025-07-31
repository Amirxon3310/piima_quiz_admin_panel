import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:piima_quiz_admin_panel/models/news_model.dart';
import 'package:piima_quiz_admin_panel/viewmodels/news_viewmodel.dart';
import 'package:piima_quiz_admin_panel/views/widgets/custom_button.dart';
import 'package:piima_quiz_admin_panel/views/widgets/custom_input_widget.dart';

class EditNewsScreen extends StatelessWidget {
  final NewsModel news;

  EditNewsScreen({super.key, required this.news});

  final titleController = TextEditingController();
  final bodyController = TextEditingController();
  final imageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    titleController.text = news.title;
    bodyController.text = news.body;
    imageController.text = news.imageUrl;
    final viewmodel = Get.find<NewsViewmodel>();

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
            CustomInputWidget(controller: bodyController, title: "Tanasi"),
            CustomInputWidget(
              controller: imageController,
              title: "URL",
              hasMoreLines: true,
            ),
            CustomButton(
              onPressed: () async {
                await viewmodel.updateNews(
                  news.id!,
                  titleController.text.trim(),
                  bodyController.text.trim(),
                  imageController.text.trim(),
                );
                Get.back();
                Get.snackbar(
                  "Tahrirlandi",
                  "Yangilik yangilandi",
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
