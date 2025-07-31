import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:piima_quiz_admin_panel/viewmodels/news_viewmodel.dart';
import 'package:piima_quiz_admin_panel/views/screens/add/add_news_screen.dart';
import 'package:piima_quiz_admin_panel/views/screens/edit/edit_news_screen.dart';

class NewsScreen extends StatelessWidget {
  NewsScreen({super.key});

  final newsViewmodel = Get.put(NewsViewmodel());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Yangiliklar"),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => AddNewsScreen(),
                ),
              );
            },
            icon: Icon(Icons.add_box_rounded),
          )
        ],
        centerTitle: true,
      ),
      body: Obx(() {
        return ListView.separated(
          itemCount: newsViewmodel.news.length,
          separatorBuilder: (_, __) => const Divider(),
          itemBuilder: (context, index) {
            final news = newsViewmodel.news[index];
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
                      news.imageUrl,
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
                  Expanded(
                    child: Column(
                      spacing: 10,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          news.title,
                          style: TextStyle(
                              fontWeight: FontWeight.w600, fontSize: 16),
                        ),
                        Text(news.body)
                      ],
                    ),
                  ),
                  // Spacer(),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.edit, color: Colors.blue),
                        onPressed: () {
                          Get.to(() => EditNewsScreen(news: news));
                        },
                      ),
                      IconButton(
                        icon: const Icon(Icons.delete, color: Colors.red),
                        onPressed: () {
                          Get.defaultDialog(
                            title: "O'chirish",
                            middleText: "Bu yangilikni o'chirmoqchimisiz?",
                            textConfirm: "Ha",
                            textCancel: "Yo'q",
                            contentPadding: const EdgeInsets.all(30),
                            onConfirm: () async {
                              await newsViewmodel.deleteNews(news.id!);
                              Get.back();
                              Get.snackbar(
                                "Deleted",
                                "Yangilik o'chirildi",
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
      }),
    );
  }
}
