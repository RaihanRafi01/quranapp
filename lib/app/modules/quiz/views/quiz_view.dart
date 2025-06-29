import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:quranapp/common/widgets/customButton.dart';
import '../../../../common/appColors.dart';
import '../../../../common/customFont.dart';
import '../controllers/quiz_controller.dart';

class QuizView extends GetView<QuizController> {
  const QuizView({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(QuizController());
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        bottom: false,
        child: Obx(() {
          if (controller.quizCompleted.value) {
            return _buildCompletionScreen();
          }
          return _buildQuizScreen();
        }),
      ),
    );
  }

  Widget _buildQuizScreen() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        // Progress Bar
        Obx(() => Padding(
          padding: const EdgeInsets.all(20),
          child: Row(
            children: [
              // Left icon
              GestureDetector(
                onTap: ()=> Get.back(),
                child: SvgPicture.asset(
                    'assets/images/lessons/close-circle_icon.svg'),
              ),
              const SizedBox(width: 20),
              // Progress Bar
              Expanded(
                child: LinearProgressIndicator(
                  value: controller.progress,
                  borderRadius: const BorderRadius.all(Radius.circular(10)),
                  backgroundColor: AppColors.btnClr2,
                  valueColor: const AlwaysStoppedAnimation<Color>(
                      AppColors.clrGreen2),
                  minHeight: 12,
                ),
              ),
              const SizedBox(width: 20),
              // Right icon
              Image.asset(
                'assets/images/lessons/emoji_icon.png',
                scale: 4,
              )
            ],
          ),
        )),
        const SizedBox(height: 20),

        // Question
        Padding(
          padding: const EdgeInsets.all(20),
          child: Text(
            controller.currentQuestion,
            style: h1.copyWith(
                fontSize: 22,
                color: AppColors.textColor4,
                fontWeight: FontWeight.w800),
          ),
        ),


        // Arabic text or question content
        if (controller.currentArabic.isNotEmpty) ...[
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                controller.currentArabic,
                style: h2.copyWith(
                  fontSize: 32,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(width: 12),
              SvgPicture.asset('assets/images/vocabulary/audio_icon.svg')
            ],
          ),
          const SizedBox(height: 30),
        ] else ...[
          const SizedBox(height: 10),
        ],

        // Options
        Expanded(
          child: Obx(() {
            switch (controller.currentQuestionType) {
              case 'matching':
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: _buildMatchingOptions(),
                );
              default:
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: _buildMultipleChoiceOptions(),
                );
            }
          }),
        ),

        // Bottom buttons
        Obx(() => _buildBottomButtons()),
      ],
    );
  }

  Widget _buildMatchingOptions() {
    Map<String, String> pairs = controller.getCurrentPairs();
    List<String> englishWords = pairs.keys.toList()..shuffle();
    List<String> arabicWords = pairs.values.toList()..shuffle();

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: ListView.builder(
            itemCount: englishWords.length,
            itemBuilder: (context, index) {
              return _buildMatchingItem(englishWords[index], true, pairs);
            },
          ),
        ),
        const SizedBox(width: 20),
        Expanded(
          child: ListView.builder(
            itemCount: arabicWords.length,
            itemBuilder: (context, index) {
              return _buildMatchingItem(arabicWords[index], false, pairs);
            },
          ),
        ),
      ],
    );
  }

  Widget _buildMatchingItem(
      String item, bool isEnglish, Map<String, String> pairs) {
    return Obx(() {
      bool isChecked = controller.checkedPairs.containsKey(item) ||
          controller.checkedPairs.containsValue(item);
      bool isSelected = controller.selectedItems.contains(item);
      bool isCorrectPair = false;
      bool isWrongPair = false;

      if (isChecked) {
        String? match;

        // Determine if item is English or Arabic
        if (controller.checkedPairs.containsKey(item)) {
          match = controller.checkedPairs[item];
          isCorrectPair = controller.getCurrentPairs()[item] == match;
        } else if (controller.checkedPairs.containsValue(item)) {
          match = controller.checkedPairs.entries
              .firstWhere((e) => e.value == item)
              .key;
          isCorrectPair = controller.getCurrentPairs()[match] == item;
        }

        isWrongPair = !isCorrectPair;
      }

      Color backgroundColor = Colors.white;
      Color borderColor = Colors.grey[300]!;
      Color textColor = Colors.black87;

      if (isChecked) {
        if (isCorrectPair) {
          backgroundColor = Colors.green[100]!;
          borderColor = Colors.green;
          textColor = Colors.green[800]!;
        } else if (isWrongPair) {
          backgroundColor = Colors.red[100]!;
          borderColor = Colors.red;
          textColor = Colors.red[800]!;
        }
      } else if (isSelected) {
        backgroundColor = Colors.blue[100]!;
        borderColor = Colors.blue;
        textColor = Colors.blue[800]!;
      }

      return InkWell(
        onTap: isChecked ? null : () => controller.selectMatchingItem(item),
        borderRadius: BorderRadius.circular(12),
        child: Container(
          margin: const EdgeInsets.symmetric(vertical: 8),
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: backgroundColor,
            border: Border.all(color: borderColor, width: 2),
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.1),
                spreadRadius: 1,
                blurRadius: 5,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Text(
            item,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: textColor,
            ),
            textAlign: TextAlign.center,
          ),
        ),
      );
    });
  }

  Widget _buildMultipleChoiceOptions() {
    return Column(
      children: [
        ...controller.currentOptions
            .map((option) => _buildOptionButton(option)),
      ],
    );
  }

  Widget _buildOptionButton(String option) {
    return Obx(() {
      Color backgroundColor = Colors.white;
      Color borderColor = Colors.grey[300]!;
      Color textColor = Colors.black87;

      if (controller.isAnswerSubmitted.value) {
        if (option == controller.correctAnswer) {
          backgroundColor = Colors.green[100]!;
          borderColor = Colors.green;
          textColor = Colors.green[800]!;
        } else if (option == controller.selectedAnswer.value &&
            !controller.isCorrect.value) {
          backgroundColor = Colors.red[100]!;
          borderColor = Colors.red;
          textColor = Colors.red[800]!;
        }
      } else if (option == controller.selectedAnswer.value) {
        backgroundColor = Colors.blue[50]!;
        borderColor = Colors.blue;
        textColor = Colors.blue[800]!;
      }

      return Container(
        width: double.infinity,
        margin: const EdgeInsets.only(bottom: 12),
        child: InkWell(
          onTap: () => controller.selectAnswer(option),
          borderRadius: BorderRadius.circular(12),
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
            decoration: BoxDecoration(
              color: backgroundColor,
              border: Border.all(color: borderColor, width: 2),
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.1),
                  spreadRadius: 1,
                  blurRadius: 5,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    option,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: textColor,
                    ),
                  ),
                ),
                if (controller.isAnswerSubmitted.value &&
                    option == controller.correctAnswer)
                  Icon(Icons.check, color: Colors.green[800], size: 20),
                if (controller.isAnswerSubmitted.value &&
                    option == controller.selectedAnswer.value &&
                    !controller.isCorrect.value)
                  Icon(Icons.close, color: Colors.red[800], size: 20),
              ],
            ),
          ),
        ),
      );
    });
  }

  Widget _buildBottomButtons() {
    if (!controller.isAnswerSubmitted.value) {
      bool canCheck = controller.currentQuestionType == 'matching' && controller.selectedItems.length == 2;

      return SizedBox(
        width: double.infinity,
        child: Padding(
          padding: const EdgeInsets.only(top: 10, left: 20, right: 20, bottom: 40),
          child: Column(
            children: [
              CustomButton(
                label: 'Check',
                onPressed: (controller.currentQuestionType == 'matching' && controller.checkedPairs.length < controller.getCurrentPairs().length)
                    ? (canCheck ? controller.checkPair : () {})
                    : (controller.selectedAnswer.value.isNotEmpty ? controller.submitAnswer : () {}),
                color: (controller.currentQuestionType == 'matching' && controller.checkedPairs.length < controller.getCurrentPairs().length)
                    ? (canCheck ? AppColors.clrGreen2 : AppColors.btnClr5)
                    : (controller.selectedAnswer.value.isNotEmpty ? AppColors.clrGreen2 : AppColors.btnClr5),
                txtClr: (controller.currentQuestionType == 'matching' && controller.checkedPairs.length < controller.getCurrentPairs().length)
                    ? (canCheck ? Colors.white : AppColors.btnTxt2)
                    : (controller.selectedAnswer.value.isNotEmpty ? Colors.white : AppColors.btnTxt5),
              ),
            ],
          ),
        ),
      );
    } else {
      return Container
        (color: controller.isCorrect.value
          ? AppColors.clrGreen3 // Green for correct
          : AppColors.clrRed2,
        child: Padding(
          padding: const EdgeInsets.only(top: 20 , left : 20 , right : 20 , bottom : 40),
          child: Column(
            children: [
              // Feedback container with improved styling
              Row(
                children: [
                  Container(
                    width: 26,
                    height: 26,
                    decoration: BoxDecoration(
                      color: controller.isCorrect.value
                          ? const Color(0xFF4CAF50)
                          : const Color(0xFFF44336),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      controller.isCorrect.value ? Icons.check : Icons.close,
                      color: Colors.white,
                      size: 18,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      controller.isCorrect.value ? 'Fantastic!' : 'Oops, that\'s incorrect',
                      style: h1.copyWith(
                        fontSize: 22,
                        fontWeight: FontWeight.w800,
                        color: controller.isCorrect.value
                            ? AppColors.clrGreen4 // Dark green text
                            : AppColors.clrRed4 , // Dark red text
                      ),
                    ),
                  ),
                  SvgPicture.asset('assets/images/home/share_icon.svg',color: controller.isCorrect.value
                      ? AppColors.clrGreen4 // Dark green text
                      : AppColors.clrRed4 ,),
                  const SizedBox(width: 12),
                  SvgPicture.asset('assets/images/home/flag_icon.svg',color: controller.isCorrect.value
                      ? AppColors.clrGreen4 // Dark green text
                      : AppColors.clrRed4,),
                ],
              ),

              SizedBox(height: 20),

              // Action button
              SizedBox(
                width: double.infinity,
                child: CustomButton(
                  label: controller.currentQuestionType == 'matching' &&
                      controller.checkedPairs.length < controller.getCurrentPairs().length || !controller.isCorrect.value
                      ? 'GOT IT'
                      : 'NEXT',
                  onPressed: () {
                    if (controller.currentQuestionType == 'matching' &&
                        controller.checkedPairs.length < controller.getCurrentPairs().length) {
                      controller.isAnswerSubmitted.value = false;
                      controller.selectedItems.clear();
                    } else {
                      controller.nextQuestion();
                    }
                  },
                  color: controller.isCorrect.value
                      ? AppColors.clrGreen2 // Green for correct
                      : AppColors.clrRed, // Red for incorrect
                  txtClr: Colors.white,
                ),
              ),
            ],
          ),
        ),
      );
    }
  }

  Widget _buildCompletionScreen() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.celebration,
              size: 80,
              color: Colors.amber[600],
            ),
            const SizedBox(height: 20),
            const Text(
              'Quiz Completed!',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              'Great job! You\'ve finished the quiz.',
              style: TextStyle(
                fontSize: 16,
                color: Colors.black54,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 40),
            SizedBox(
              width: double.infinity,
              child: CustomButton(
                label: 'Back to Home',
                onPressed: () => Get.back(),
                color: AppColors.clrGreen2,
                txtClr: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}