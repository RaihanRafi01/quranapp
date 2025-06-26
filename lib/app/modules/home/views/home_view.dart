import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
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
            TopMenuSection(),

            // Main Content
            Expanded(
              child: SingleChildScrollView(
                child: Obx(() => Column(
                  children: [
                    // Featured Course Card
                    const FeaturedCourseCard(),

                    // Stats Section
                    const StatsSection(),
                    const SizedBox(height: 20),

                    // Show Recent Lessons and Video Lessons if a course is selected
                    if (controller.selectedCourse.value != null) ...[
                       RecentLessonsSection(title: 'Recent Lessons'),
                      const SizedBox(height: 20),
                      //const VideoLessonsSection(),
                       RecentLessonsSection(title: 'Video Lessons'),
                      const SizedBox(height: 20),
                    ],

                    // Course List (hide if course is selected)
                    if (controller.selectedCourse.value == null)
                      const CourseListSection(),
                  ],
                )),
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
class TopMenuSection extends GetView<HomeController> {
  const TopMenuSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Obx(() => Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Show Back button if a course is selected, otherwise show "Menu" text
          controller.selectedCourse.value != null
              ? GestureDetector(
            onTap: controller.clearSelection,
            child: Row(
              children: [
                Icon(
                  Icons.arrow_back,
                  color: Colors.black.withOpacity(0.8),
                  size: 24,
                ),
                const SizedBox(width: 8),
                const Text(
                  'Back',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          )
              : const Text(
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
      )),
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
                            onPressed: () {},
                            style: ElevatedButton.styleFrom(
                              foregroundColor: Colors.black,
                              backgroundColor: AppColors.clrGreen,
                              minimumSize: Size(double.infinity, 40),
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(100)),
                            ),
                            child: Text(buttonText, style: h2.copyWith(fontSize: 14)),
                          )),
                      SvgPicture.asset(
                        'assets/images/home/arrow_btn.svg',
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
          color: Colors.white,
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
              color: const Color(0xFFFF5722),
              label: 'Days',
            ),
            const SizedBox(width: 30),
            StatItem(
              path: 'assets/images/home/coin_icon.png',
              count: coinCount,
              maxCount: maxCoins,
              color: const Color(0xFFFFCA28),
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
  final int? maxCount;
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
        Image.asset(path, scale: 4),
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

// Recent Lessons Section Widget
class RecentLessonsSection extends StatelessWidget {
  String title;
  RecentLessonsSection({super.key,required this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: h1.copyWith(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          const SizedBox(height: 12),
          SizedBox(
            height: 180,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: 2, // Based on your image
              itemBuilder: (context, index) {
                return Padding(
                  padding: EdgeInsets.only(right: index == 0 ? 12 : 0),
                  child: RecentLessonCard(
                    lessonNumber: index + 1,
                    title: 'Al-Fatiha',
                    subtitle: 'The Opening',
                    isCompleted: index == 0,
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

// Recent Lesson Card Widget
class RecentLessonCard extends StatelessWidget {
  final int lessonNumber;
  final String title;
  final String subtitle;
  final bool isCompleted;

  const RecentLessonCard({
    super.key,
    required this.lessonNumber,
    required this.title,
    required this.subtitle,
    this.isCompleted = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 242,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        /*image: const DecorationImage(
          image: AssetImage('assets/images/home/dummy_image_1.png'), // Add your lesson background image
          fit: BoxFit.cover,
        ),*/
      ),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: AppColors.cardBgWhite
        ),
        padding: const EdgeInsets.all(8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Image.asset('assets/images/home/dummy_image_4.png'),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '$lessonNumber. $title',
                      style: h2.copyWith(
                        color: AppColors.textColor,
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      '   $subtitle',
                      style: h4.copyWith(
                        color: AppColors.textColor,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
                SvgPicture.asset('assets/images/home/arrow_btn.svg')
              ],
            ),
          ],
        ),
      ),
    );
  }
}

// Video Lessons Section Widget
class VideoLessonsSection extends StatelessWidget {
  const VideoLessonsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Video Lessons',
            style: h1.copyWith(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          const SizedBox(height: 12),
          Container(
            height: 100,
            decoration: BoxDecoration(
              color: Colors.grey[200],
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Center(
              child: Text(
                'Video lessons will be displayed here',
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 14,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// Updated Course List Section Widget
class CourseListSection extends GetView<HomeController> {
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
        subtitle: 'Learn the language of the Holy Quran and understand it without...',
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
          child: CourseListItem(
            courseItem: course,
            onTap: () => controller.selectCourse(course),
          ),
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

// Updated Course List Item Widget
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
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(6),
        decoration: BoxDecoration(
          color: AppColors.btnClr2,
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
      ),
    );
  }
}