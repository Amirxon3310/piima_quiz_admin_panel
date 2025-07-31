import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:piima_quiz_admin_panel/viewmodels/banner_viewmodel.dart';
import 'package:piima_quiz_admin_panel/views/screens/add/add_banner_screen.dart';
import 'package:piima_quiz_admin_panel/views/screens/edit/edit_banner_screen.dart';

class BannerScreen extends StatelessWidget {
  BannerScreen({super.key});

  final bannerViewmodel = Get.put(BannerViewmodel());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Bannerlar"),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => AddBannerScreen(),
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
            itemCount: bannerViewmodel.banners.length,
            separatorBuilder: (_, __) => const Divider(),
            itemBuilder: (context, index) {
              final banner = bannerViewmodel.banners[index];
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
                        banner.imageUrl,
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
                    Expanded(child: Text(banner.title)),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: const Icon(Icons.edit, color: Colors.blue),
                          onPressed: () {
                            Get.to(() => EditBannerScreen(banner: banner));
                          },
                        ),
                        IconButton(
                          icon: const Icon(Icons.delete, color: Colors.red),
                          onPressed: () {
                            Get.defaultDialog(
                              title: "O'chirish",
                              middleText: "Bu bannerni o'chirmoqchimisiz?",
                              textConfirm: "Ha",
                              textCancel: "Yo'q",
                              contentPadding: const EdgeInsets.all(30),
                              onConfirm: () async {
                                await bannerViewmodel.deleteBanner(banner.id!);
                                Get.back();
                                Get.snackbar(
                                  "Deleted",
                                  "Banner o'chirildi",
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
