import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import '../../app/modules/dashboard/controllers/dashboard_controller.dart';
import '../appColors.dart';

class CustomNavigationBar extends StatelessWidget {
  final Function(int)? onItemTapped; // Optional callback for custom tap behavior

  const CustomNavigationBar({super.key, this.onItemTapped});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<DashboardController>();

    // Navigation items with SVG icons and labels
    final List<Map<String, String>> navItems = [
      {
        'label': 'Menu',
        'icon': 'assets/images/nav/home_icon.svg',
      },
      {
        'label': 'Vocabulary',
        'icon': 'assets/images/nav/vocabulary_icon.svg',
      },
      {
        'label': 'Leaderboards',
        'icon': 'assets/images/nav/leaderboard_icon.svg',
      },
      {
        'label': 'Profile',
        'icon': 'assets/images/nav/profile_icon.svg',
      },
    ];

    return Obx(
          () => Container(
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 10,
              offset: const Offset(0, -2),
            ),
          ],
        ),
        child: SafeArea(
          top: false,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: navItems.asMap().entries.map((entry) {
                int index = entry.key;
                var item = entry.value;
                bool isActive = controller.currentIndex.value == index;

                return GestureDetector(
                  onTap: () {
                    if (onItemTapped != null) {
                      onItemTapped!(index);
                    } else {
                      controller.updateIndex(index);
                    }
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        SvgPicture.asset(
                          item['icon']!,
                          height: 24,
                          width: 24,
                          colorFilter: ColorFilter.mode(
                            isActive ? AppColors.appColor : Colors.grey,
                            BlendMode.srcIn,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          item['label']!,
                          style: TextStyle(
                            color: isActive ? AppColors.appColor : Colors.grey,
                            fontSize: 12,
                            fontWeight: isActive ? FontWeight.w600 : FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
        ),
      ),
    );
  }
}