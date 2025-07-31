import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:piima_quiz_admin_panel/viewmodels/banner_viewmodel.dart';
import 'package:piima_quiz_admin_panel/views/widgets/custom_button.dart';
import 'package:piima_quiz_admin_panel/views/widgets/custom_input_widget.dart';
import 'package:piima_quiz_admin_panel/views/widgets/custom_loading_widget.dart';

class AddBannerScreen extends StatelessWidget {
  const AddBannerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final bannerViewmodel = Get.put(BannerViewmodel());

    final bannerTitleController = TextEditingController();
    final imageController = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        title: Text("Banner qo'shish"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          child: Column(
            spacing: 20,
            children: [
              CustomInputWidget(
                controller: bannerTitleController,
                title: "Banner nomi ...",
              ),
              CustomInputWidget(
                controller: imageController,
                title: "URL (rasm uchun) ...",
                hasMoreLines: true,
              ),
              Obx(
                () {
                  return bannerViewmodel.isLoading.value
                      ? CustomLoadingWidget()
                      : CustomButton(
                          onPressed: () async {
                            final title = bannerTitleController.text.trim();
                            final imageUrl = imageController.text.trim();

                            if (title.isNotEmpty && imageUrl.isNotEmpty) {
                              await bannerViewmodel.addBanner(title, imageUrl);
                              Get.snackbar(
                                'Success',
                                "Banner qo'shildi!",
                                duration: const Duration(seconds: 1),
                                backgroundColor: Colors.green,
                              );
                              bannerTitleController.clear();
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
