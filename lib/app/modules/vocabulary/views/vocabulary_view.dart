import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:quranapp/app/modules/quiz/views/quiz_view.dart';
import '../../../../common/appColors.dart';
import '../controllers/vocabulary_controller.dart';
import 'vocabulary_settings_view.dart';

class VocabularyView extends GetView<VocabularyController> {
  const VocabularyView({super.key});

  @override
  Widget build(BuildContext context) {
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

    return DefaultTabController(
      length: 3,
      child: Scaffold(
        backgroundColor: Colors.grey[50],
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios, color: Colors.black87),
            onPressed: () => Get.back(),
          ),
          title: const Text(
            'Vocabulary',
            style: TextStyle(
              color: Colors.black87,
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
          ),
          centerTitle: true,
          actions: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: GestureDetector(
                onTap: ()=> Get.to(() => VocabularySettingsView()),
                  child: SvgPicture.asset('assets/images/home/settings_icon.svg')),
            )
          ],
          bottom: const TabBar(
            indicatorColor: Colors.orange,
            labelColor: Colors.black87,
            unselectedLabelColor: Colors.black54,
            labelStyle: TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
            unselectedLabelStyle: TextStyle(fontWeight: FontWeight.normal, fontSize: 14),
            tabs: [
              Tab(text: 'Our Week'),
              Tab(text: 'Quiz Words'),
              Tab(text: 'All'),
            ],
          ),
        ),
        body: Stack(
          children: [
            // Main content (TabBarView)
            Positioned.fill(
              child: TabBarView(
                children: [
                  _buildVocabularyList(ourWeekWords),
                  _buildVocabularyList(quizWords),
                  _buildVocabularyList(allWords),
                ],
              ),
            ),
            // Fixed button at the bottom right
            Positioned(
              bottom: 90, // Distance from the bottom
              right: 16, // Distance from the right edge
              child: SafeArea(
                child: Container(
                  constraints: BoxConstraints(
                    maxWidth: MediaQuery.of(context).size.width,
                  ),
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width * 0.3, // Takes 30% of the screen width
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
                          Get.to(QuizView());
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.transparent, // Transparent to show gradient
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(25),
                          ),
                          elevation: 0,
                          shadowColor: Colors.transparent, // Remove shadow to avoid overlap
                        ),
                        child: const Text(
                          'Start Quiz',
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
          ],
        ),
      ),
    );
  }

  Widget _buildVocabularyList(List<Map<String, dynamic>> words) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return ListView.separated(
          padding: const EdgeInsets.all(16),
          itemCount: words.length,
          separatorBuilder: (context, index) => const Divider(height: 1, color: Colors.grey),
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
          // SVG Icon
          SvgPicture.asset(
            svgIcon,
          ),
          const SizedBox(width: 16),
          // Word content
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
          // Action Menu
          PopupMenuButton<String>(
            color: Colors.white,
            icon: Icon(
              Icons.more_horiz,
              color: Colors.grey[600],
            ),
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
            onSelected: (value) {
              // Handle menu actions
              switch (value) {
                case 'learned':
                // Mark as learned
                  break;
                case 'ignore':
                // Ignore word
                  break;
                case 'review':
                // Review word
                  break;
              }
            },
          ),
        ],
      ),
    );
  }
}