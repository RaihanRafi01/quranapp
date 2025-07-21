import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:quranapp/app/modules/leaderboards/views/leaderboards_view.dart';
import 'package:quranapp/app/modules/vocabulary/views/main_vocabulary.dart';
import 'package:quranapp/app/modules/vocabulary/views/vocabulary_view.dart';
import 'package:quranapp/common/widgets/customNavigationBar.dart';
import '../../../../common/appColors.dart';
import '../../../../common/widgets/customBottomNavigationBar.dart';
import '../../home/controllers/home_controller.dart';
import '../../home/views/home_view.dart';
import '../../profile/views/profile_view.dart';
import '../controllers/dashboard_controller.dart';

class DashboardView extends StatefulWidget {
  const DashboardView({super.key});

  @override
  State<DashboardView> createState() => _DashboardViewState();
}

class _DashboardViewState extends State<DashboardView> {
  @override
  Widget build(BuildContext context) {
    // Initialize the DashboardController as permanent
    Get.put(HomeController());
    final controller = Get.put(DashboardController(), permanent: true);
    // Check for navigation argument and update index if provided
    if (Get.arguments != null && Get.arguments is int) {
      controller.updateIndex(Get.arguments as int);
    }

    final List<Widget> _screens = [
      const HomeView(),
      const MainVocabularyView(),
      const LeaderboardsView(),
      const ProfileView(),
    ];

    return Scaffold(
      backgroundColor: AppColors.appColor,
      body: Stack(
        children: [
          Obx(() => _screens[controller.currentIndex.value]),
          const Align(
            alignment: Alignment.bottomCenter,
            child: CustomNavigationBar(),
          ),
        ],
      ),
    );
  }
}