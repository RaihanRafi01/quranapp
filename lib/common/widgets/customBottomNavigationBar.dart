import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../appColors.dart';

class CustomBottomNavigationBar extends StatefulWidget {
  const CustomBottomNavigationBar({super.key});

  @override
  State<CustomBottomNavigationBar> createState() => _CustomBottomNavigationBarState();
}

class _CustomBottomNavigationBarState extends State<CustomBottomNavigationBar> {
  int _currentIndex = 0;

  // List of SVG asset paths for navigation items
  final List<String> _svgIcons = [
    'assets/images/nav/home_icon.svg',
    'assets/images/nav/vocabulary_icon.svg',
    'assets/images/nav/leaderboard_icon.svg',
    'assets/images/nav/profile_icon.svg',
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
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
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildNavItem(
                svgPath: _svgIcons[0],
                label: 'Menu',
                index: 0,
                isActive: _currentIndex == 0,
              ),
              _buildNavItem(
                svgPath: _svgIcons[1],
                label: 'Vocabulary',
                index: 1,
                isActive: _currentIndex == 1,
              ),
              _buildNavItem(
                svgPath: _svgIcons[2],
                label: 'Leaderboards',
                index: 2,
                isActive: _currentIndex == 2,
              ),
              _buildNavItem(
                svgPath: _svgIcons[3],
                label: 'Profile',
                index: 3,
                isActive: _currentIndex == 3,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNavItem({
    required String svgPath,
    required String label,
    required int index,
    required bool isActive,
  }) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _currentIndex = index;
        });
        // Add navigation logic here
        _handleNavigation(index);
      },
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SvgPicture.asset(
              svgPath,
              height: 24,
              width: 24,
              colorFilter: ColorFilter.mode(
                isActive ? AppColors.appColor : Colors.grey,
                BlendMode.srcIn,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              label,
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
  }

  void _handleNavigation(int index) {
    // Add your navigation logic here
    switch (index) {
      case 0:
      // Navigate to Menu/Home
        break;
      case 1:
      // Navigate to Vocabulary
        break;
      case 2:
      // Navigate to Leaderboards
        break;
      case 3:
      // Navigate to Profile
        break;
    }
  }
}