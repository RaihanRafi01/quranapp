import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:quranapp/app/modules/quiz/views/quiz_view.dart';
import '../../../../common/appColors.dart';
import '../../../../common/customFont.dart';
import '../controllers/vocabulary_controller.dart';
import 'vocabulary_settings_view.dart';

class MainVocabularyView extends GetView<VocabularyController> {

  const MainVocabularyView({super.key});

  @override
  Widget build(BuildContext context) {
    // Initialize the controller
    final VocabularyController vocabularyController = Get.put(VocabularyController());


    // Sample data for different tabs
    final List<Map<String, dynamic>> ourWeekWords = [
      {'arabic': 'يوم', 'english': 'day', 'isLearned': true, 'svgIcon': 'assets/images/vocabulary/tic_icon.svg'},
      {'arabic': 'المقصود', 'english': 'The one who is meant', 'isLearned': false, 'svgIcon': 'assets/images/vocabulary/review_icon.svg'},
    ];

    final List<Map<String, dynamic>> quizWords = [
      {'arabic': 'الى', 'english': 'to', 'isLearned': false, 'svgIcon': 'assets/images/vocabulary/quiz_q_icon.svg'},
      {'arabic': 'المستقيم', 'english': 'The straight path', 'isLearned': false, 'svgIcon': 'assets/images/vocabulary/quiz_q_icon.svg'},
    ];

    final List<Map<String, dynamic>> allWords = [
      {'arabic': 'الله', 'english': 'Allah', 'isLearned': false, 'svgIcon': 'assets/images/vocabulary/quiz_q_icon.svg'},
      {'arabic': 'سلام', 'english': 'In peace', 'isLearned': false, 'svgIcon': 'assets/images/vocabulary/review_icon.svg'},
      {'arabic': 'تمنحني', 'english': 'You seek help', 'isLearned': false, 'svgIcon': 'assets/images/vocabulary/tic_icon.svg'},
      {'arabic': 'مبارك', 'english': '', 'isLearned': false, 'svgIcon': 'assets/images/vocabulary/tic_icon.svg'},
    ];

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        scrolledUnderElevation: 0,
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: GestureDetector(
              onTap: () => Get.to(() => const VocabularySettingsView()),
              child: SvgPicture.asset('assets/images/home/settings_icon.svg'),
            ),
          ),
        ],
      ),
      body: Stack(
        children: [
          // Main content
          Column(
            children: [
              // Custom Toggle Buttons
              Text('Learned Words',style: h4.copyWith(fontSize: 20)),
              SizedBox(height: 20,),
              // Vocabulary List
              Expanded(
                child: Obx(() {
                  switch (vocabularyController.selectedTab.value) {
                    case 0:
                      return _buildVocabularyList(ourWeekWords);
                    case 1:
                      return _buildVocabularyList(quizWords);
                    case 2:
                      return _buildVocabularyList(allWords);
                    default:
                      return _buildVocabularyList(ourWeekWords);
                  }
                }),
              ),
            ],
          ),
          // Fixed button at the bottom right
          Positioned(
            bottom: 90,
            right: 16,
            child: SafeArea(
              child: Container(
                constraints: BoxConstraints(
                  maxWidth: MediaQuery.of(context).size.width,
                ),
                child: SizedBox(
                  width: MediaQuery.of(context).size.width * 0.3,
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [AppColors.btnYellow1, AppColors.btnYellow2],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      borderRadius: BorderRadius.circular(25),
                    ),
                    child: ElevatedButton(
                      onPressed: () {
                        Get.to(() => const QuizView());
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.transparent,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25),
                        ),
                        elevation: 0,
                        shadowColor: Colors.transparent,
                      ),
                      child: const Text(
                        'Review',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),

          Positioned(
            bottom: 90,
            left: 16,
            child: SafeArea(
              child: Container(
                constraints: BoxConstraints(
                  maxWidth: MediaQuery.of(context).size.width,
                ),
                child: SizedBox(
                  width: MediaQuery.of(context).size.width * 0.3,
                  child: Card(
                    color: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25), // Increased border radius for more rounding
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                        Icon(Icons.keyboard_arrow_left_outlined),
                        Text('1/75'),
                        Icon(Icons.keyboard_arrow_right_outlined),
                      ],),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildVocabularyList(List<Map<String, dynamic>> words) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return ListView.separated(
          padding: const EdgeInsets.all(16),
          itemCount: words.length,
          separatorBuilder: (context, index) => const Divider(height: 0.5, color: AppColors.btnClr3),
          itemBuilder: (context, index) {
            return _buildVocabularyItem(
              arabic: words[index]['arabic'],
              english: words[index]['english'],
              isLearned: words[index]['isLearned'],
              svgIcon: words[index]['svgIcon'],
            );
          },
        );
      },
    );
  }

  Widget _buildVocabularyItem({
    required String arabic,
    required String english,
    required bool isLearned,
    required String svgIcon,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Row(
        children: [
          PopupMenuButton<String>(
            offset: const Offset(130, -30),
            color: Colors.white,
            onSelected: (value) {
              switch (value) {
                case 'learned':
                  break;
                case 'ignore':
                  break;
                case 'review':
                  break;
              }
            },
            itemBuilder: (context) => [
              PopupMenuItem(
                value: 'learned',
                child: Row(
                  children: [
                    SvgPicture.asset('assets/images/vocabulary/tic_icon.svg'),
                    const SizedBox(width: 8),
                    const Text('Mark as learned'),
                  ],
                ),
              ),
              PopupMenuItem(
                value: 'ignore',
                child: Row(
                  children: [
                    SvgPicture.asset('assets/images/vocabulary/ignore_icon.svg'),
                    const SizedBox(width: 8),
                    const Text('Ignore word'),
                  ],
                ),
              ),
              PopupMenuItem(
                value: 'review',
                child: Row(
                  children: [
                    SvgPicture.asset('assets/images/vocabulary/review_icon.svg'),
                    const SizedBox(width: 8),
                    const Text('Review word'),
                  ],
                ),
              ),
            ],
            child: SvgPicture.asset(
              svgIcon,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      arabic,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: Colors.black87,
                      ),
                    ),
                    const SizedBox(width: 8),
                    SvgPicture.asset('assets/images/vocabulary/audio_icon.svg'),
                  ],
                ),
                if (english.isNotEmpty)
                  Padding(
                    padding: const EdgeInsets.only(top: 4),
                    child: Text(
                      english,
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey[600],
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}