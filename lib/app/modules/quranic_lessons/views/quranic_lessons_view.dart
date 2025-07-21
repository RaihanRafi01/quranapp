import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:quranapp/app/modules/quiz/views/quiz_view.dart';
import 'package:quranapp/app/modules/quranic_lessons/views/quranicLessonsSettings_view.dart';
import 'package:quranapp/app/modules/vocabulary/views/vocabulary_view.dart';
import '../../../../common/appColors.dart';
import '../../../../common/customFont.dart';
import '../controllers/quranic_lessons_controller.dart';

// Main Quranic Lessons View
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
      body: _buildLessonsList(controller)
    );
  }

  Widget _buildLessonsList(QuranicLessonsController controller) {
    return SafeArea(
      child: Column(
        children: [
          // Custom App Bar
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            child: Row(
              children: [
                IconButton(
                  icon: const Icon(Icons.arrow_back_ios, size: 24, color: AppColors.textBlue2),
                  onPressed: () => Get.back(),
                ),
                const Spacer(),
                GestureDetector(
                  onTap: (){
                    Get.to(QuranicLessonsSettingsView());
                  },
                    child: SvgPicture.asset('assets/images/home/settings_icon.svg'))
              ],
            ),
          ),

          // Lesson Items
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 20),
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
                      const SizedBox(height: 24),
                      _buildLessonItem(
                        controller,
                        ayahNumber: "2",
                        arabicWords: ["الرَّحْمَنِ", "اللَّهِ", "بِسْمِ"],
                        englishWords: ["The Most Gracious", "God", "In the name of"],
                        duration: "2:15",
                        isFirst: false,
                      ),
                      const SizedBox(height: 24),
                      _buildLessonItem(
                        controller,
                        ayahNumber: "3",
                        arabicWords: ["الرَّحْمَنِ", "اللَّهِ", "بِسْمِ"],
                        englishWords: ["The Most Gracious", "God", "In the name of"],
                        duration: "2:15",
                        isFirst: false,
                      ),
                      const SizedBox(height: 24),
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
                    top: 100,
                    left: 80,
                    right: 80,
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          // Info Icon and Duration
                          Padding(
                            padding: const EdgeInsets.all(20),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                SvgPicture.asset('assets/images/vocabulary/info_icon.svg'),
                                Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                                  decoration: BoxDecoration(
                                    color: Colors.orange,
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Row(
                                    children: [
                                      SvgPicture.asset('assets/images/vocabulary/lock_icon.svg'),
                                      SizedBox(width: 4),
                                      Text(
                                        "1/50",
                                        style: h4.copyWith(
                                          color: Colors.white,
                                          fontSize: 18,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 50),
                          SvgPicture.asset('assets/images/vocabulary/audio_icon.svg',color: AppColors.textBlue2,),
                          SizedBox(height: 16),
                          Text(
                            "سُبْحَانَ اللَّهِ",
                            style: h4.copyWith(
                              fontSize: 24,
                              color: AppColors.textBlue2,
                            ),
                          ),
                          const SizedBox(height: 8),
                          // Main Translation
                          Text(
                            "Glory be to Allah",
                            style: h2.copyWith(
                              fontSize: 18,
                              color: Colors.black87,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: 50),
                          Container(
                            height: 50,
                            width: double.maxFinite,
                            decoration: BoxDecoration(
                              color: AppColors.textBlue2,
                              borderRadius: const BorderRadius.only(
                                bottomLeft: Radius.circular(10), // Rounded bottom-left corner
                                bottomRight: Radius.circular(10), // Rounded bottom-right corner
                              ),
                            ),
                            child: Center(
                              child: Text(
                                'Add to Quiz List',
                                style: h4.copyWith(
                                  fontSize: 18,
                                  color: Colors.white, // Adjust text color for visibility on cyan
                                ),
                              ),
                            ),
                          ),
                          // Add to Quiz List Button
                          /*SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                              onPressed: () => controller.showPlayer(),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: AppColors.textBlue2,
                                foregroundColor: Colors.white,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.only(bottomLeft: Radius.circular(10),bottomRight: Radius.circular(10)),
                                ),
                                elevation: 0,
                              ),
                              child: const Text(
                                "Add to Quiz List",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ),*/
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Bottom Navigation Buttons
          // Bottom Navigation Buttons
          Obx(() {
            return Container(
              padding: const EdgeInsets.all(20),
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
          child: SvgPicture.asset('assets/images/lessons/play_icon.svg'),
        ),
        GestureDetector(
          onTap: () {},
          child: SvgPicture.asset('assets/images/lessons/word_icon.svg'),
        ),
        GestureDetector(
          onTap: () {
            Get.to(VocabularyView());
          },
          child: SvgPicture.asset('assets/images/lessons/voca_icon.svg'),
        ),
      ],
    );
  }

  Widget _buildPlayerRow(QuranicLessonsController controller) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        // Example widgets for the new row
        GestureDetector(
          onTap: () {
            Get.find<QuranicLessonsController>().togglePlayerRow(); // Toggle back to navigation row
          },
          child: SvgPicture.asset('assets/images/lessons/play_black_icon.svg'),
        ),
        GestureDetector(
          onTap: () {},
          child: SvgPicture.asset('assets/images/lessons/previous_icon.svg'),
        ),
        GestureDetector(
          onTap: () {},
          child: SvgPicture.asset('assets/images/lessons/play_white_icon.svg'),
        ),
        GestureDetector(
          onTap: () {},
          child: SvgPicture.asset('assets/images/lessons/next_icon.svg'),
        ),
        GestureDetector(
          onTap: () {},
          child: SvgPicture.asset('assets/images/lessons/speed_icon.svg'),
        ),
        GestureDetector(
          onTap: ()=> controller.navigateToSettings(),
          child: SvgPicture.asset('assets/images/lessons/settings_icon.svg'),
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
                  fontSize: 18,
                  color: AppColors.textColor5,
                ),
              ),
              const Spacer(),
            ],
          ),
          const SizedBox(height: 16),
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
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                        color: Colors.black,
                        height: 1.3,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      englishWords[index],
                      style: h4.copyWith(
                        fontSize: 12,
                        color: AppColors.textColor5,
                        height: 1.2,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
                if (index < arabicWords.length - 1) const SizedBox(width: 20), // Fixed width gap between Columns
              ],
            ],
          ),
          const SizedBox(height: 20),
          // Description Text
          Text(
            "In the name of Allah, the Most Gracious, the Most Merciful",
            style: h4.copyWith(
              fontSize: 14,
              color: AppColors.textColor6,
              height: 1.4,
            ),
          ),
          const SizedBox(height: 20),
          const Divider(height: 0.5, color: AppColors.borderClr2),
        ],
      ),
    );
  }
}