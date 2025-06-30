import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:quranapp/app/modules/coin/views/coin_view.dart';
import 'package:quranapp/app/modules/hadith_lessons/views/hadith_lessons_view.dart';
import 'package:quranapp/app/modules/imported_lessons/views/imported_lessons_view.dart';
import 'package:quranapp/app/modules/quranic_lessons/views/quranic_lessons_view.dart';
import 'package:quranapp/app/modules/video_lessons/views/video_lessons_view.dart';
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

                        // Show Recent Lessons and Course-Specific Lessons if a course is selected
                        if (controller.selectedCourse.value != null) ...[
                          RecentLessonsSection(title: 'Recent Lessons'),
                          const SizedBox(height: 20),
                          RecentLessonsSection(
                              title: controller.sectionTitle.value),
                          const SizedBox(height: 20),
                        ],

                        // Course List (hide if course is selected)
                        if (controller.selectedCourse.value == null)
                          const CourseListSection(),
                        SizedBox(height: 80)
                      ],
                    )),
              ),
            ),
          ],
        ),
      ),
     // bottomNavigationBar: const CustomBottomNavigationBar(),
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
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Show the section title (e.g., Quranic Lessons, Hadith Lessons, Video Lessons)
                  Text(
                    controller.selectedCourse.value != null
                        ? controller.sectionTitle.value
                        : 'Courses',
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  // Show Back button if a course is selected
                  if (controller.selectedCourse.value != null) ...[
                    const SizedBox(height: 8),
                    GestureDetector(
                      onTap: controller.clearSelection,
                      child: Row(
                        children: [
                          Icon(Icons.arrow_back_ios_new_rounded, color: AppColors.textBlue),
                          /*const SizedBox(width: 8),
                          Text(
                            'Back',
                            style: TextStyle(
                              color: Colors.black.withOpacity(0.8),
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                            ),
                          ),*/
                        ],
                      ),
                    ),
                  ],
                ],
              ),
              Row(
                children: [
                  SvgPicture.asset('assets/images/home/search_icon.svg'),
                  const SizedBox(width: 16),
                  SvgPicture.asset('assets/images/home/settings_icon.svg')
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
    return AspectRatio(
      aspectRatio: 16 / 9, // Maintain a consistent aspect ratio
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Stack(
          fit: StackFit.expand, // Ensure children expand to fill the Stack
          children: [
            // Background Islamic Pattern/Book Image
            Image.asset(
              'assets/images/home/home_banner.png',
              //fit: BoxFit.cover, // Ensure image covers the entire area
              //width: double.infinity,
              //height: double.infinity,
            ),

            // Content
            Padding(
              padding: const EdgeInsets.all(30), // Reduced padding for better fit
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center, // Center content vertically
                children: [
                  Text(
                    title,
                    style: h2.copyWith(
                      color: Colors.white.withOpacity(0.7),
                      fontSize: 20,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(
                    duration,
                    style: h1.copyWith(
                      color: Colors.white,
                      fontSize: 36,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      // Fixed-size button
                      SizedBox(
                        width: 180.0, // Fixed width
                        height: 40.0, // Fixed height
                        child: ElevatedButton(
                          onPressed: onTap ?? () {},
                          style: ElevatedButton.styleFrom(
                            foregroundColor: Colors.black,
                            backgroundColor: AppColors.clrGreen,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(100),
                            ),
                          ),
                          child: Text(
                            buttonText,
                            style: h2.copyWith(fontSize: 14),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ),
                      SvgPicture.asset(
                        'assets/images/home/arrow_btn.svg',
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
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
      child: GestureDetector(
        onTap: ()=> Get.to(CoinView()),
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
  final String title;

  const RecentLessonsSection({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    // Determine content based on section title
    final isRecentLessons = title == 'Recent Lessons';
    final lessonTitles = isRecentLessons
        ? ['Al-Fatiha', 'Al-Baqarah']
        : title == 'Video Lessons'
            ? ['Tajweed Basics', 'Surah Recitation']
            : title == 'Hadith Lessons'
                ? ['Quran Memorization', 'Tafsir Insights']
                : ['Quranic Lesson 1', 'Quranic Lesson 2'];
    final subtitles = isRecentLessons
        ? ['The Opening', 'The Cow']
        : title == 'Video Lessons'
            ? ['Learn proper pronunciation', 'Practice with examples']
            : title == 'Hadith Lessons'
                ? ['Memorize key verses', 'Understand meanings']
                : ['Core Quranic teachings', 'Advanced Quranic study'];

    // Determine navigation based on section title
    void Function(String, String) onLessonTap;
    switch (title) {
      case 'Recent Lessons':
        onLessonTap = (title, subtitle) => Get.to(() => QuranicLessonsView(
            title: title, subtitle: subtitle)); // Recent Lessons are Quranic
        break;
      case 'Video Lessons':
        onLessonTap = (title, subtitle) =>
            Get.to(() => HadithLessonsView(title: title, subtitle: subtitle,isHadith: false,));
        break;
      case 'Hadith Lessons':
        onLessonTap = (title, subtitle) =>
            Get.to(() => HadithLessonsView(title: title, subtitle: subtitle,isHadith: true,));
        break;
      case 'Quranic Lessons':
        onLessonTap = (title, subtitle) =>
            Get.to(() => QuranicLessonsView(title: title, subtitle: subtitle));
        break;
      case 'Imported Lessons':
        onLessonTap = (title, subtitle) => Get.to(() => ImportedLessonsView(
            title: title, subtitle: subtitle)); // Recent Lessons are Quranic
        break;
      default:
        onLessonTap = (title, subtitle) =>
            Get.to(() => QuranicLessonsView(title: title, subtitle: subtitle));
    }

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
              itemCount: 2,
              itemBuilder: (context, index) {
                return Padding(
                  padding: EdgeInsets.only(right: index == 0 ? 12 : 0),
                  child: RecentLessonCard(
                    lessonNumber: index + 1,
                    title: lessonTitles[index],
                    subtitle: subtitles[index],
                    isCompleted: isRecentLessons && index == 0,
                    onTap: () =>
                        onLessonTap(lessonTitles[index], subtitles[index]),
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
  final VoidCallback? onTap;

  const RecentLessonCard({
    super.key,
    required this.lessonNumber,
    required this.title,
    required this.subtitle,
    this.isCompleted = false,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 242,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
        ),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: AppColors.cardBgWhite,
          ),
          padding: const EdgeInsets.all(6),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Image.asset('assets/images/home/dummy_image_4.png'),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '$lessonNumber. $title',
                          style: h2.copyWith(
                            color: AppColors.textColor,
                            fontSize: 16,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 4),
                        Text(
                          '    $subtitle',
                          style: h4.copyWith(
                            color: AppColors.textColor,
                            fontSize: 14,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                  SvgPicture.asset(
                    'assets/images/home/arrow_btn.svg',
                    width: 36,
                  ),
                ],
              ),
            ],
          ),
        ),
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
        lessonType: 'Quranic Lessons',
      ),
      CourseItem(
        title: 'Learn Arabic with Hadith',
        subtitle:
            'Learn the language of the Holy Quran and understand it without...',
        imagePath: 'assets/images/home/dummy_image_2.png',
        isCompleted: false,
        lessonType: 'Hadith Lessons', // Updated to match RecentLessonsSection
      ),
      CourseItem(
        title: 'Learn with Islamic Videos',
        subtitle: '',
        imagePath: 'assets/images/home/dummy_image_3.png',
        isCompleted: false,
        lessonType: 'Video Lessons',
      ),
      CourseItem(
        title: 'Learn from Imported content',
        subtitle: 'Master every word in the Quran and understand what...',
        imagePath: 'assets/images/home/dummy_image_1.png',
        isCompleted: false,
        lessonType: 'Imported Lessons',
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
  final String lessonType;

  CourseItem({
    required this.title,
    required this.subtitle,
    required this.imagePath,
    required this.isCompleted,
    required this.lessonType,
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
            SvgPicture.asset('assets/images/home/arrow_btn.svg'),
          ],
        ),
      ),
    );
  }
}
