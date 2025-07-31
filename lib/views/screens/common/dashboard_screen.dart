import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import 'package:piima_quiz_admin_panel/datasources/quiz_remote_datasource.dart';
import 'package:piima_quiz_admin_panel/repositories/quiz_repository.dart';
import 'package:piima_quiz_admin_panel/viewmodels/banner_viewmodel.dart';
import 'package:piima_quiz_admin_panel/viewmodels/category_viewmodel.dart';
import 'package:piima_quiz_admin_panel/viewmodels/news_viewmodel.dart';
import 'package:piima_quiz_admin_panel/viewmodels/quiz_viewmodel.dart';
import 'package:piima_quiz_admin_panel/views/screens/common/banner_screen.dart';
import 'package:piima_quiz_admin_panel/views/screens/common/category_screen.dart';
import 'package:piima_quiz_admin_panel/views/screens/common/news_screen.dart';
import 'package:piima_quiz_admin_panel/views/screens/common/quiz_screen.dart';
import 'package:piima_quiz_admin_panel/views/widgets/custom_card_widget.dart';

class DashboardScreen extends StatelessWidget {
  DashboardScreen({super.key});
  final categoryViewmodel = Get.put(CategoryViewmodel());
  final newsViewmodel = Get.put(NewsViewmodel());
  final bannerViewmodel = Get.put(BannerViewmodel());
  final quizViewmodel =
      Get.put(QuizViewmodel(QuizRepository(QuizRemoteDatasource())));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Dashboard"),
        centerTitle: true,
      ),
      body: Obx(
        () {
          return Padding(
            padding: const EdgeInsets.all(12),
            child: StaggeredGrid.count(
              crossAxisCount: 4,
              mainAxisSpacing: 12,
              crossAxisSpacing: 12,
              children: [
                StaggeredGridTile.count(
                  crossAxisCellCount: 4,
                  mainAxisCellCount: 1.5,
                  child: CustomCardWidget(
                    icon: Icons.category,
                    title: "Kategoriyalar",
                    count: categoryViewmodel.categories.length,
                    color: Color(0xFF6A0572),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => CategoryScreen(),
                        ),
                      );
                    },
                  ),
                ),
                StaggeredGridTile.count(
                  crossAxisCellCount: 2,
                  mainAxisCellCount: 4,
                  child: CustomCardWidget(
                    icon: Icons.article,
                    title: "Yangiliklar",
                    count: newsViewmodel.news.length,
                    color: Color(0xFFFF6B6B),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => NewsScreen(),
                        ),
                      );
                    },
                  ),
                ),
                StaggeredGridTile.count(
                  crossAxisCellCount: 2,
                  mainAxisCellCount: 2,
                  child: CustomCardWidget(
                    icon: Icons.image,
                    title: "Bannerlar",
                    count: bannerViewmodel.banners.length,
                    color: Color(0xFF00F5A0),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => BannerScreen(),
                        ),
                      );
                    },
                  ),
                ),
                StaggeredGridTile.count(
                  crossAxisCellCount: 2,
                  mainAxisCellCount: 2,
                  child: CustomCardWidget(
                    icon: Icons.question_mark,
                    title: "Quizlar",
                    count: bannerViewmodel.banners.length,
                    color: Color(0xFF4169E1),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => QuizScreen(),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
