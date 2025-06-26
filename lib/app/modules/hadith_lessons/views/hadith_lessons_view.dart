import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:quranapp/app/modules/video_lessons/views/videoPlayer_view.dart';
import 'package:quranapp/common/customFont.dart';

import '../../../../common/appColors.dart';

class HadithLessonsView extends StatelessWidget {
  final String title;
  final String subtitle;
  final bool isHadith;

  const HadithLessonsView(
      {super.key,
      required this.title,
      required this.subtitle,
      required this.isHadith});

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
                      padding: const EdgeInsets.all(16),
                      child: Row(
                        children: [
                          GestureDetector(
                            onTap: () => Navigator.pop(context),
                            child: const Icon(Icons.close_rounded, size: 30),
                          ),
                          Expanded(
                            child: SliderTheme(
                              data: SliderTheme.of(context).copyWith(
                                activeTrackColor: Colors.green,
                                inactiveTrackColor: Colors.grey[300],
                                thumbColor: Colors.green,
                                trackHeight: 2,
                                thumbShape: const RoundSliderThumbShape(
                                    enabledThumbRadius: 8),
                              ),
                              child: Slider(
                                value: 20,
                                min: 10,
                                max: 30,
                                onChanged: (double value) {},
                              ),
                            ),
                          ),
                          const Icon(Icons.more_horiz_outlined, size: 30),
                        ],
                      ),
                    ),
                    HadithHeader(
                      imageUrl: 'assets/images/lessons/dummy_image_hadith.png',
                      hadithNumber: '2',
                      title: 'Sahih Al Bukhari',
                      subtitle: 'Kapitel 2 Hadithnr. 8',
                    ),
                    const SizedBox(height: 16),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: const Text(
                        '''
طريق الجنة من يشاء ويضل من يشاء فمن هداه فبفضله ومن أضله فبعدله لا يسألوا عما يفعلوه فمسألون لكن وجدت أن ذلك ليس مناسبا للسياق فوجدت أن المقصود أن هذه البهائم لها أعين تبصر بها مواطئ أقدامها وتعرف بها الطرق وتدل بها المسافات لكن ما يخلق من هذه المراكب الأخرى كالسيارات والطائرات والمراكب الفضائية
''',
                        style:
                            TextStyle(fontSize: 23, letterSpacing: 3, height: 2),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            // Fixed bottom row
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  isHadith
                      ? SvgPicture.asset(
                          'assets/images/lessons/play_rounded.svg')
                      : GestureDetector(
                    onTap: (){
                      Get.to(VideoPlayerScreen(title: title, subtitle: subtitle));
                    },
                          child: SvgPicture.asset(
                              'assets/images/lessons/video_icon.svg')),
                  SvgPicture.asset('assets/images/lessons/sentence_icon.svg'),
                  SvgPicture.asset('assets/images/lessons/book_icon.svg'),
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
        const SizedBox(width: 50),
        // Rounded image with overlay number
        Stack(
          alignment: Alignment.center,
          children: [
            Image.asset(
              imageUrl,
              fit: BoxFit.cover,
            ),
            Container(
              width: 30,
              height: 30,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                color: Colors.black.withOpacity(0.4),
              ),
              child: Center(
                child: Text(
                  hadithNumber,
                  style: h1.copyWith(
                    fontSize: 16,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(width: 12),
        // Title and subtitle
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: h1.copyWith(
                fontSize: 20,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              subtitle,
              style: h3.copyWith(
                fontSize: 14,
                color: Colors.black54,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
