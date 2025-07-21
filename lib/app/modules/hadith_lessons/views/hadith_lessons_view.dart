import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:quranapp/app/modules/video_lessons/views/videoPlayer_view.dart';
import 'package:quranapp/app/modules/vocabulary/views/vocabulary_view.dart';
import 'package:quranapp/common/customFont.dart';
import '../../../../common/appColors.dart';

class HadithLessonsView extends StatelessWidget {
  final String title;
  final String subtitle;
  final bool isHadith;

  const HadithLessonsView({
    super.key,
    required this.title,
    required this.subtitle,
    required this.isHadith,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            // Scrollable content
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.all(16.w), // Responsive padding
                      child: Row(
                        children: [
                          GestureDetector(
                            onTap: () => Navigator.pop(context),
                            child: Icon(Icons.close_rounded, size: 30.sp), // Responsive icon size
                          ),
                          Expanded(
                            child: SliderTheme(
                              data: SliderTheme.of(context).copyWith(
                                activeTrackColor: Colors.green,
                                inactiveTrackColor: Colors.grey[300],
                                thumbColor: Colors.green,
                                trackHeight: 2.h, // Responsive track height
                                thumbShape: RoundSliderThumbShape(
                                  enabledThumbRadius: 8.r, // Responsive thumb radius
                                ),
                              ),
                              child: Slider(
                                value: 20,
                                min: 10,
                                max: 30,
                                onChanged: (double value) {},
                              ),
                            ),
                          ),
                          Icon(Icons.more_horiz_outlined, size: 30.sp), // Responsive icon size
                        ],
                      ),
                    ),
                    HadithHeader(
                      imageUrl: 'assets/images/lessons/dummy_image_hadith.png',
                      hadithNumber: '2',
                      title: 'Sahih Al Bukhari',
                      subtitle: 'Kapitel 2 Hadithnr. 8',
                    ),
                    SizedBox(height: 16.h), // Responsive spacing
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16.w), // Responsive padding
                      child: Text(
                        '''
طريق الجنة من يشاء ويضل من يشاء فمن هداه فبفضله ومن أضله فبعدله لا يسألوا عما يفعلوه فمسألون لكن وجدت أن ذلك ليس مناسبا للسياق فوجدت أن المقصود أن هذه البهائم لها أعين تبصر بها مواطئ أقدامها وتعرف بها الطرق وتدل بها المسافات لكن ما يخلق من هذه المراكب الأخرى كالسيارات والطائرات والمراكب الفضائية
''',
                        style: TextStyle(
                          fontSize: 23.sp, // Responsive font size
                          letterSpacing: 3.w, // Responsive letter spacing
                          height: 2,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            // Fixed bottom row
            Padding(
              padding: EdgeInsets.all(16.w), // Responsive padding
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  isHadith
                      ? SvgPicture.asset(
                    'assets/images/lessons/play_rounded.svg',
                    width: 40.w, // Responsive width
                    height: 40.h, // Responsive height
                  )
                      : GestureDetector(
                    onTap: () {
                      Get.to(VideoPlayerScreen(title: title, subtitle: subtitle));
                    },
                    child: SvgPicture.asset(
                      'assets/images/lessons/video_icon.svg',
                      width: 40.w, // Responsive width
                      height: 40.h, // Responsive height
                    ),
                  ),
                  SvgPicture.asset(
                    'assets/images/lessons/sentence_icon.svg',
                    width: 40.w, // Responsive width
                    height: 40.h, // Responsive height
                  ),
                  GestureDetector(
                    onTap: () => Get.to(const VocabularyView(initialTabIndex: 1)),
                    child: SvgPicture.asset(
                      'assets/images/lessons/book_icon.svg',
                      width: 40.w, // Responsive width
                      height: 40.h, // Responsive height
                    ),
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

class HadithHeader extends StatelessWidget {
  final String imageUrl;
  final String hadithNumber;
  final String title;
  final String subtitle;

  const HadithHeader({
    super.key,
    required this.imageUrl,
    required this.hadithNumber,
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(width: 50.w), // Responsive spacing
        // Rounded image with overlay number
        Stack(
          alignment: Alignment.center,
          children: [
            Image.asset(
              imageUrl,
              fit: BoxFit.cover,
              width: 80.w, // Responsive width
              height: 80.h, // Responsive height
            ),
            Container(
              width: 30.w, // Responsive width
              height: 30.h, // Responsive height
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30.r), // Responsive border radius
                color: Colors.black.withOpacity(0.4),
              ),
              child: Center(
                child: Text(
                  hadithNumber,
                  style: h1.copyWith(
                    fontSize: 16.sp, // Responsive font size
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
        SizedBox(width: 12.w), // Responsive spacing
        // Title and subtitle
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: h1.copyWith(fontSize: 20.sp), // Responsive font size
            ),
            SizedBox(height: 4.h), // Responsive spacing
            Text(
              subtitle,
              style: h3.copyWith(
                fontSize: 14.sp, // Responsive font size
                color: Colors.black54,
              ),
            ),
          ],
        ),
      ],
    );
  }
}