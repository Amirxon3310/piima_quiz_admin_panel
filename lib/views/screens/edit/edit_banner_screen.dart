import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:piima_quiz_admin_panel/models/banner_model.dart';
import 'package:piima_quiz_admin_panel/viewmodels/banner_viewmodel.dart';
import 'package:piima_quiz_admin_panel/views/widgets/custom_button.dart';
import 'package:piima_quiz_admin_panel/views/widgets/custom_input_widget.dart';

class EditBannerScreen extends StatelessWidget {
  final BannerModel banner;

  EditBannerScreen({super.key, required this.banner});

  final titleController = TextEditingController();
  final imageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    titleController.text = banner.title;
    imageController.text = banner.imageUrl;
    final viewmodel = Get.find<BannerViewmodel>();

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
                await viewmodel.updateBanner(
                  banner.id!,
                  titleController.text.trim(),
                  imageController.text.trim(),
                );
                Get.back();
                Get.snackbar(
                  "Tahrirlandi",
                  "Banner yangilandi",
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
