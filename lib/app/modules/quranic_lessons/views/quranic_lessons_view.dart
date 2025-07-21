import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:quranapp/app/modules/quiz/views/quiz_view.dart';
import 'package:quranapp/app/modules/quranic_lessons/views/quranicLessonsSettings_view.dart';
import 'package:quranapp/app/modules/vocabulary/views/vocabulary_view.dart';
import '../../../../common/appColors.dart';
import '../../../../common/customFont.dart';
import '../controllers/quranic_lessons_controller.dart';

class QuranicLessonsView extends StatelessWidget {
  final String title;
  final String subtitle;

  const QuranicLessonsView({
    super.key,
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(QuranicLessonsController());

    return Scaffold(
      backgroundColor: Colors.white,
      body: _buildLessonsList(controller),
    );
  }

  Widget _buildLessonsList(QuranicLessonsController controller) {
    return SafeArea(
      child: Column(
        children: [
          // Custom App Bar
          Container(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h), // Responsive padding
            child: Row(
              children: [
                IconButton(
                  icon: Icon(
                    Icons.arrow_back_ios,
                    size: 24.sp, // Responsive icon size
                    color: AppColors.textBlue2,
                  ),
                  onPressed: () => Get.back(),
                ),
                const Spacer(),
                GestureDetector(
                  onTap: () {
                    Get.to(() => const QuranicLessonsSettingsView());
                  },
                  child: SvgPicture.asset(
                    'assets/images/home/settings_icon.svg',
                    width: 24.w, // Responsive SVG width
                    height: 24.h, // Responsive SVG height
                  ),
                ),
              ],
            ),
          ),

          // Lesson Items
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 20.w), // Responsive padding
              child: Stack(
                children: [
                  Column(
                    children: [
                      _buildLessonItem(
                        controller,
                        ayahNumber: "1",
                        arabicWords: ["الرَّحْمَنِ", "اللَّهِ", "بِسْمِ"],
                        englishWords: ["The Most Gracious", "God", "In the name of"],
                        duration: "1:50",
                        isFirst: true,
                      ),
                      SizedBox(height: 24.h), // Responsive spacing
                      _buildLessonItem(
                        controller,
                        ayahNumber: "2",
                        arabicWords: ["الرَّحْمَنِ", "اللَّهِ", "بِسْمِ"],
                        englishWords: ["The Most Gracious", "God", "In the name of"],
                        duration: "2:15",
                        isFirst: false,
                      ),
                      SizedBox(height: 24.h), // Responsive spacing
                      _buildLessonItem(
                        controller,
                        ayahNumber: "3",
                        arabicWords: ["الرَّحْمَنِ", "اللَّهِ", "بِسْمِ"],
                        englishWords: ["The Most Gracious", "God", "In the name of"],
                        duration: "2:15",
                        isFirst: false,
                      ),
                      SizedBox(height: 24.h), // Responsive spacing
                      _buildLessonItem(
                        controller,
                        ayahNumber: "4",
                        arabicWords: ["الرَّحْمَنِ", "اللَّهِ", "بِسْمِ"],
                        englishWords: ["The Most Gracious", "God", "In the name of"],
                        duration: "2:15",
                        isFirst: false,
                      ),
                    ],
                  ),
                  Positioned(
                    top: 100.h, // Responsive positioning
                    left: 80.w, // Responsive positioning
                    right: 80.w, // Responsive positioning
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12.r), // Responsive border radius
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          // Info Icon and Duration
                          Padding(
                            padding: EdgeInsets.all(20.w), // Responsive padding
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                SvgPicture.asset(
                                  'assets/images/vocabulary/info_icon.svg',
                                  width: 24.w, // Responsive SVG width
                                  height: 24.h, // Responsive SVG height
                                ),
                                Container(
                                  padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 2.h), // Responsive padding
                                  decoration: BoxDecoration(
                                    color: Colors.orange,
                                    borderRadius: BorderRadius.circular(10.r), // Responsive border radius
                                  ),
                                  child: Row(
                                    children: [
                                      SvgPicture.asset(
                                        'assets/images/vocabulary/lock_icon.svg',
                                        width: 16.w, // Responsive SVG width
                                        height: 16.h, // Responsive SVG height
                                      ),
                                      SizedBox(width: 4.w), // Responsive spacing
                                      Text(
                                        "1/50",
                                        style: h4.copyWith(
                                          color: Colors.white,
                                          fontSize: 18.sp, // Responsive font size
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 50.h), // Responsive spacing
                          SvgPicture.asset(
                            'assets/images/vocabulary/audio_icon.svg',
                            color: AppColors.textBlue2,
                            width: 24.w, // Responsive SVG width
                            height: 24.h, // Responsive SVG height
                          ),
                          SizedBox(height: 16.h), // Responsive spacing
                          Text(
                            "سُبْحَانَ اللَّهِ",
                            style: h4.copyWith(
                              fontSize: 24.sp, // Responsive font size
                              color: AppColors.textBlue2,
                            ),
                          ),
                          SizedBox(height: 8.h), // Responsive spacing
                          // Main Translation
                          Text(
                            "Glory be to Allah",
                            style: h2.copyWith(
                              fontSize: 18.sp, // Responsive font size
                              color: Colors.black87,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          SizedBox(height: 50.h), // Responsive spacing
                          Container(
                            height: 50.h, // Responsive height
                            width: double.maxFinite,
                            decoration: BoxDecoration(
                              color: AppColors.textBlue2,
                              borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(10.r), // Responsive border radius
                                bottomRight: Radius.circular(10.r), // Responsive border radius
                              ),
                            ),
                            child: Center(
                              child: Text(
                                'Add to Quiz List',
                                style: h4.copyWith(
                                  fontSize: 18.sp, // Responsive font size
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Bottom Navigation Buttons
          Obx(() {
            return Container(
              padding: EdgeInsets.all(20.w), // Responsive padding
              child: controller.isPlayerRowVisible.value
                  ? _buildPlayerRow(controller) // New row when play icon is clicked
                  : _buildNavigationRow(controller), // Original navigation row
            );
          }),
        ],
      ),
    );
  }

  Widget _buildNavigationRow(QuranicLessonsController controller) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        GestureDetector(
          onTap: () {
            controller.togglePlayerRow(); // Toggle to player row on play icon click
          },
          child: SvgPicture.asset(
            'assets/images/lessons/play_icon.svg',
            width: 24.w, // Responsive SVG width
            height: 24.h, // Responsive SVG height
          ),
        ),
        GestureDetector(
          onTap: () {},
          child: SvgPicture.asset(
            'assets/images/lessons/word_icon.svg',
            width: 24.w, // Responsive SVG width
            height: 24.h, // Responsive SVG height
          ),
        ),
        GestureDetector(
          onTap: () {
            Get.to(() => const VocabularyView());
          },
          child: SvgPicture.asset(
            'assets/images/lessons/voca_icon.svg',
            width: 24.w, // Responsive SVG width
            height: 24.h, // Responsive SVG height
          ),
        ),
      ],
    );
  }

  Widget _buildPlayerRow(QuranicLessonsController controller) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        GestureDetector(
          onTap: () {
            Get.find<QuranicLessonsController>().togglePlayerRow(); // Toggle back to navigation row
          },
          child: SvgPicture.asset(
            'assets/images/lessons/play_black_icon.svg',
            width: 24.w, // Responsive SVG width
            height: 24.h, // Responsive SVG height
          ),
        ),
        GestureDetector(
          onTap: () {},
          child: SvgPicture.asset(
            'assets/images/lessons/previous_icon.svg',
            width: 24.w, // Responsive SVG width
            height: 24.h, // Responsive SVG height
          ),
        ),
        GestureDetector(
          onTap: () {},
          child: SvgPicture.asset(
            'assets/images/lessons/play_white_icon.svg',
            width: 24.w, // Responsive SVG width
            height: 24.h, // Responsive SVG height
          ),
        ),
        GestureDetector(
          onTap: () {},
          child: SvgPicture.asset(
            'assets/images/lessons/next_icon.svg',
            width: 24.w, // Responsive SVG width
            height: 24.h, // Responsive SVG height
          ),
        ),
        GestureDetector(
          onTap: () {},
          child: SvgPicture.asset(
            'assets/images/lessons/speed_icon.svg',
            width: 24.w, // Responsive SVG width
            height: 24.h, // Responsive SVG height
          ),
        ),
        GestureDetector(
          onTap: () => controller.navigateToSettings(),
          child: SvgPicture.asset(
            'assets/images/lessons/settings_icon.svg',
            width: 24.w, // Responsive SVG width
            height: 24.h, // Responsive SVG height
          ),
        ),
      ],
    );
  }

  Widget _buildLessonItem(
      QuranicLessonsController controller, {
        required String ayahNumber,
        required List<String> arabicWords,
        required List<String> englishWords,
        required String duration,
        required bool isFirst,
      }) {
    return Container(
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Ayah Number
          Row(
            children: [
              Text(
                ayahNumber,
                style: h4.copyWith(
                  fontSize: 18.sp, // Responsive font size
                  color: AppColors.textColor5,
                ),
              ),
              const Spacer(),
            ],
          ),
          SizedBox(height: 16.h), // Responsive spacing
          // Arabic Words with English Translation
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              for (int index = 0; index < arabicWords.length; index++) ...[
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      arabicWords[index],
                      style: TextStyle(
                        fontSize: 20.sp, // Responsive font size
                        fontWeight: FontWeight.w500,
                        color: Colors.black,
                        height: 1.3,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 8.h), // Responsive spacing
                    Text(
                      englishWords[index],
                      style: h4.copyWith(
                        fontSize: 12.sp, // Responsive font size
                        color: AppColors.textColor5,
                        height: 1.2,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
                if (index < arabicWords.length - 1) SizedBox(width: 20.w), // Responsive spacing
              ],
            ],
          ),
          SizedBox(height: 20.h), // Responsive spacing
          // Description Text
          Text(
            "In the name of Allah, the Most Gracious, the Most Merciful",
            style: h4.copyWith(
              fontSize: 14.sp, // Responsive font size
              color: AppColors.textColor6,
              height: 1.4,
            ),
          ),
          SizedBox(height: 20.h), // Responsive spacing
          Divider(
            height: 0.5.h, // Responsive height
            color: AppColors.borderClr2,
            thickness: 0.5.w, // Responsive thickness
          ),
        ],
      ),
    );
  }
}