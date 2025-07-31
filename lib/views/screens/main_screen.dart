import 'package:flutter/material.dart';
import 'package:piima_quiz_admin_panel/views/screens/common/banner_screen.dart';
import 'package:piima_quiz_admin_panel/views/screens/common/category_screen.dart';
import 'package:piima_quiz_admin_panel/views/screens/common/dashboard_screen.dart';
import 'package:piima_quiz_admin_panel/views/screens/common/news_screen.dart';
import 'package:piima_quiz_admin_panel/views/screens/common/quiz_screen.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  static final ValueNotifier<int> selectedIndex = ValueNotifier(0);

  static final List<Widget> screens = [
    DashboardScreen(),
    CategoryScreen(),
    QuizScreen(),
    NewsScreen(),
    BannerScreen(),
  ];

  static final List<Icon> icons = [
    Icon(Icons.dashboard),
    Icon(Icons.category),
    Icon(Icons.question_mark),
    Icon(Icons.newspaper),
    Icon(Icons.campaign),
  ];

  static final List<String> labels = [
    "Dashboard",
    "Kategoriya",
    "Quizlar",
    "Yangiliklar",
    "Bannerlar"
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ValueListenableBuilder<int>(
        valueListenable: selectedIndex,
        builder: (context, index, _) {
          return screens[index];
        },
      ),
      bottomNavigationBar: ValueListenableBuilder<int>(
        valueListenable: selectedIndex,
        builder: (context, index, _) {
          return BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            currentIndex: index,
            onTap: (value) => selectedIndex.value = value,
            items: List.generate(
              5,
              (index) {
                return BottomNavigationBarItem(
                  icon: icons[index],
                  label: labels[index],
                );
              },
            ),
          );
        },
      ),
    );
  }
}
