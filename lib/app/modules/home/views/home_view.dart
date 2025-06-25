import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart'; // Added for SVG support
import 'package:get/get.dart';
import 'package:quranapp/common/widgets/customButton.dart';
import '../../../../common/appColors.dart';
import '../../../../common/customFont.dart';
import '../../../../common/widgets/customBottomNavigationBar.dart';
import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            // Top Menu Section
            const TopMenuSection(),

            // Main Content
            Expanded(
              child: SingleChildScrollView(
                //padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    // Featured Course Card
                    const FeaturedCourseCard(),
                    //const SizedBox(height: 20),

                    // Stats Section
                    const StatsSection(),
                    const SizedBox(height: 20),

                    // Course List
                    const CourseListSection(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: const CustomBottomNavigationBar(),
    );
  }
}

// Reusable Top Menu Widget
class TopMenuSection extends StatelessWidget {
  const TopMenuSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text(
            'Menu',
            style: TextStyle(
              color: Colors.black,
              fontSize: 18,
              fontWeight: FontWeight.w500,
            ),
          ),
          Row(
            children: [
              Icon(
                Icons.search,
                color: Colors.black.withOpacity(0.8),
                size: 24,
              ),
              const SizedBox(width: 16),
              Icon(
                Icons.settings,
                color: Colors.black.withOpacity(0.8),
                size: 24,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// Reusable Featured Course Card Widget
class FeaturedCourseCard extends StatelessWidget {
  final String title;
  final String duration;
  final String imagePath;
  final String buttonText;
  final VoidCallback? onTap;

  const FeaturedCourseCard({
    super.key,
    this.title = 'Quranic Only',
    this.duration = '6 Months',
    this.imagePath = '',
    this.buttonText = 'View Instructions',
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Background Islamic Pattern/Book Image
        Positioned(
          right: 0,
          left: 0,
          top: 0,
          bottom: 0,
          child: Image.asset('assets/images/home/home_banner.png', scale: 4),
        ),

        // Content
        Padding(
          padding: const EdgeInsets.all(50),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: h2.copyWith(
                      color: Colors.white.withOpacity(0.7),
                      fontSize: 20,
                    ),
                  ),
                  Text(
                    duration,
                    style: h1.copyWith(
                      color: Colors.white,
                      fontSize: 36,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButton(
                          onPressed: (){},
                          style: ElevatedButton.styleFrom(
                            foregroundColor: Colors.black, backgroundColor: AppColors.clrGreen, minimumSize: Size(double.infinity, 40),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(100)),
                          ),
                          child: Text(buttonText,style: h2.copyWith(fontSize: 14)),
                        )
                      ),
                      SvgPicture.asset(
                        'assets/images/home/arrow_btn.svg', // Replace with your SVG icon path
                      ),
                      const SizedBox(width: 100),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}

// Reusable Stats Section Widget
class StatsSection extends StatelessWidget {
  final int fireCount;
  final int coinCount;
  final int maxCoins = 50; // Fixed maximum coins as per the image

  const StatsSection({
    super.key,
    this.fireCount = 0,
    this.coinCount = 0,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white, // Subtle background
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 4,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          children: [
            StatItem(
              path: 'assets/images/home/fire_icon.png',
              count: fireCount,
              color: const Color(0xFFFF5722), // Orange for fire
              label: 'Days',
            ),
            const SizedBox(width: 30),
            StatItem(
              path: 'assets/images/home/coin_icon.png',
              count: coinCount,
              maxCount: maxCoins,
              color: const Color(0xFFFFCA28), // Amber for coin
              label: 'coins',
            ),
            const Spacer(),
            const Icon(
              Icons.chevron_right,
              color: Colors.black,
              size: 30,
            ),
          ],
        ),
      ),
    );
  }
}

// Reusable Stat Item Widget
class StatItem extends StatelessWidget {
  final String path;
  final int count;
  final int? maxCount; // Optional for coins to show "0/50"
  final Color color;
  final String label;

  const StatItem({
    super.key,
    required this.path,
    required this.count,
    this.maxCount,
    required this.color,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Image.asset(path,scale: 4),
        const SizedBox(width: 12),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              maxCount != null ? '$count/$maxCount' : count.toString(),
              style: TextStyle(
                color: Colors.black,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              label,
              style: TextStyle(
                color: Colors.black.withOpacity(0.6),
                fontSize: 10,
              ),
            ),
          ],
        ),
      ],
    );
  }
}

// Reusable Course List Section Widget
class CourseListSection extends StatelessWidget {
  const CourseListSection({super.key});

  @override
  Widget build(BuildContext context) {
    final courses = [
      CourseItem(
        title: 'Learn Quranic',
        subtitle: 'Master every word in the Quran and understand what...',
        imagePath: 'assets/images/home/dummy_image_1.png',
        isCompleted: false,
      ),
      CourseItem(
        title: 'Learn Arabic with Hadith',
        subtitle:
        'Learn the language of the Holy Quran and understand it without...',
        imagePath: 'assets/images/home/dummy_image_2.png',
        isCompleted: false,
      ),
      CourseItem(
        title: 'Learn with Islamic Videos',
        subtitle: '',
        imagePath: 'assets/images/home/dummy_image_3.png',
        isCompleted: false,
      ),

    ];

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: Column(
        children: courses
            .map((course) => Padding(
          padding: const EdgeInsets.only(bottom: 12),
          child: CourseListItem(courseItem: course),
        ))
            .toList(),
      ),
    );
  }
}

// Course Item Data Model
class CourseItem {
  final String title;
  final String subtitle;
  final String imagePath;
  final bool isCompleted;

  CourseItem({
    required this.title,
    required this.subtitle,
    required this.imagePath,
    required this.isCompleted,
  });
}

// Reusable Course List Item Widget
class CourseListItem extends StatelessWidget {
  final CourseItem courseItem;
  final VoidCallback? onTap;

  const CourseListItem({
    super.key,
    required this.courseItem,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(6),
      decoration: BoxDecoration(
        color:  AppColors.btnClr2,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          // Course Image/Icon
          Image.asset(courseItem.imagePath),

          const SizedBox(width: 16),

          // Course Details
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  courseItem.title,
                  style: h1.copyWith(
                    color: Colors.black,
                    fontSize: 16,
                  ),
                ),
                if (courseItem.subtitle.isNotEmpty) ...[
                  const SizedBox(height: 4),
                  Text(
                    courseItem.subtitle,
                    style: h4.copyWith(
                      color: Colors.black.withOpacity(0.6),
                      fontSize: 14,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ],
            ),
          ),

          // Action Button
          SvgPicture.asset('assets/images/home/arrow_btn.svg')
        ],
      ),
    );
  }
}