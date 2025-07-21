import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
          padding: EdgeInsets.all(20.w), // Responsive padding
          child: Row(
            children: [
              // Left icon
              GestureDetector(
                onTap: () => Get.back(),
                child: SvgPicture.asset(
                  'assets/images/lessons/close-circle_icon.svg',
                  width: 24.w, // Responsive SVG width
                  height: 24.h, // Responsive SVG height
                ),
              ),
              SizedBox(width: 20.w), // Responsive spacing
              // Progress Bar
              Expanded(
                child: LinearProgressIndicator(
                  value: controller.progress,
                  borderRadius: BorderRadius.all(Radius.circular(10.r)), // Responsive border radius
                  backgroundColor: AppColors.btnClr2,
                  valueColor: const AlwaysStoppedAnimation<Color>(
                      AppColors.clrGreen2),
                  minHeight: 12.h, // Responsive height
                ),
              ),
              SizedBox(width: 20.w), // Responsive spacing
              // Right icon
              Image.asset(
                'assets/images/lessons/emoji_icon.png',
                scale: 4,
                width: 24.w, // Responsive image width
                height: 24.h, // Responsive image height
              ),
            ],
          ),
        )),
        SizedBox(height: 20.h), // Responsive spacing

        // Question
        Padding(
          padding: EdgeInsets.all(20.w), // Responsive padding
          child: Text(
            controller.currentQuestion,
            style: h1.copyWith(
              fontSize: 22.sp, // Responsive font size
              color: AppColors.textColor4,
              fontWeight: FontWeight.w800,
            ),
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
                  fontSize: 32.sp, // Responsive font size
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(width: 12.w), // Responsive spacing
              SvgPicture.asset(
                'assets/images/vocabulary/audio_icon.svg',
                width: 24.w, // Responsive SVG width
                height: 24.h, // Responsive SVG height
              ),
            ],
          ),
          SizedBox(height: 30.h), // Responsive spacing
        ] else ...[
          SizedBox(height: 10.h), // Responsive spacing
        ],

        // Options
        Expanded(
          child: Obx(() {
            switch (controller.currentQuestionType) {
              case 'matching':
                return Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.w), // Responsive padding
                  child: _buildMatchingOptions(),
                );
              default:
                return Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.w), // Responsive padding
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
        SizedBox(width: 20.w), // Responsive spacing
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
        borderRadius: BorderRadius.circular(12.r), // Responsive border radius
        child: Container(
          margin: EdgeInsets.symmetric(vertical: 8.h), // Responsive margin
          padding: EdgeInsets.all(12.w), // Responsive padding
          decoration: BoxDecoration(
            color: backgroundColor,
            border: Border.all(color: borderColor, width: 2.w), // Responsive border width
            borderRadius: BorderRadius.circular(12.r), // Responsive border radius
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.1),
                spreadRadius: 1.w, // Responsive spread radius
                blurRadius: 5.w, // Responsive blur radius
                offset: Offset(0, 2.h), // Responsive offset
              ),
            ],
          ),
          child: Text(
            item,
            style: TextStyle(
              fontSize: 16.sp, // Responsive font size
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
    return SingleChildScrollView(
      child: Column(
        children: [
          ...controller.currentOptions
              .map((option) => _buildOptionButton(option)),
        ],
      ),
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
        margin: EdgeInsets.only(bottom: 12.h), // Responsive margin
        child: InkWell(
          onTap: () => controller.selectAnswer(option),
          borderRadius: BorderRadius.circular(12.r), // Responsive border radius
          child: Container(
            padding: EdgeInsets.symmetric(vertical: 16.h, horizontal: 20.w), // Responsive padding
            decoration: BoxDecoration(
              color: backgroundColor,
              border: Border.all(color: borderColor, width: 2.w), // Responsive border width
              borderRadius: BorderRadius.circular(12.r), // Responsive border radius
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.1),
                  spreadRadius: 1.w, // Responsive spread radius
                  blurRadius: 5.w, // Responsive blur radius
                  offset: Offset(0, 2.h), // Responsive offset
                ),
              ],
            ),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    option,
                    style: TextStyle(
                      fontSize: 16.sp, // Responsive font size
                      fontWeight: FontWeight.w500,
                      color: textColor,
                    ),
                  ),
                ),
                if (controller.isAnswerSubmitted.value &&
                    option == controller.correctAnswer)
                  Icon(Icons.check, color: Colors.green[800], size: 20.sp), // Responsive icon size
                if (controller.isAnswerSubmitted.value &&
                    option == controller.selectedAnswer.value &&
                    !controller.isCorrect.value)
                  Icon(Icons.close, color: Colors.red[800], size: 20.sp), // Responsive icon size
              ],
            ),
          ),
        ),
      );
    });
  }

  Widget _buildBottomButtons() {
    if (!controller.isAnswerSubmitted.value) {
      bool canCheck =
          controller.currentQuestionType == 'matching' && controller.selectedItems.length == 2;

      return SizedBox(
        width: double.infinity,
        child: Padding(
          padding: EdgeInsets.only(top: 10.h, left: 20.w, right: 20.w, bottom: 40.h), // Responsive padding
          child: Column(
            children: [
              CustomButton(
                label: 'Check',
                onPressed: (controller.currentQuestionType == 'matching' &&
                    controller.checkedPairs.length < controller.getCurrentPairs().length)
                    ? (canCheck ? controller.checkPair : () {})
                    : (controller.selectedAnswer.value.isNotEmpty ? controller.submitAnswer : () {}),
                color: (controller.currentQuestionType == 'matching' &&
                    controller.checkedPairs.length < controller.getCurrentPairs().length)
                    ? (canCheck ? AppColors.clrGreen2 : AppColors.btnClr5)
                    : (controller.selectedAnswer.value.isNotEmpty ? AppColors.clrGreen2 : AppColors.btnClr5),
                txtClr: (controller.currentQuestionType == 'matching' &&
                    controller.checkedPairs.length < controller.getCurrentPairs().length)
                    ? (canCheck ? Colors.white : AppColors.btnTxt2)
                    : (controller.selectedAnswer.value.isNotEmpty ? Colors.white : AppColors.btnTxt5),
                width: double.infinity, // Full-width button
                height: 50.h, // Responsive height
              ),
            ],
          ),
        ),
      );
    } else {
      return Container(
        color: controller.isCorrect.value ? AppColors.clrGreen3 : AppColors.clrRed2,
        child: Padding(
          padding: EdgeInsets.only(top: 20.h, left: 20.w, right: 20.w, bottom: 40.h), // Responsive padding
          child: Column(
            children: [
              // Feedback container with improved styling
              Row(
                children: [
                  Container(
                    width: 26.w, // Responsive width
                    height: 26.h, // Responsive height
                    decoration: BoxDecoration(
                      color: controller.isCorrect.value ? const Color(0xFF4CAF50) : const Color(0xFFF44336),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      controller.isCorrect.value ? Icons.check : Icons.close,
                      color: Colors.white,
                      size: 18.sp, // Responsive icon size
                    ),
                  ),
                  SizedBox(width: 12.w), // Responsive spacing
                  Expanded(
                    child: Text(
                      controller.isCorrect.value ? 'Fantastic!' : 'Oops, that\'s incorrect',
                      style: h1.copyWith(
                        fontSize: 22.sp, // Responsive font size
                        fontWeight: FontWeight.w800,
                        color: controller.isCorrect.value ? AppColors.clrGreen4 : AppColors.clrRed4,
                      ),
                    ),
                  ),
                  SvgPicture.asset(
                    'assets/images/home/share_icon.svg',
                    color: controller.isCorrect.value ? AppColors.clrGreen4 : AppColors.clrRed4,
                    width: 24.w, // Responsive SVG width
                    height: 24.h, // Responsive SVG height
                  ),
                  SizedBox(width: 12.w), // Responsive spacing
                  SvgPicture.asset(
                    'assets/images/home/flag_icon.svg',
                    color: controller.isCorrect.value ? AppColors.clrGreen4 : AppColors.clrRed4,
                    width: 24.w, // Responsive SVG width
                    height: 24.h, // Responsive SVG height
                  ),
                ],
              ),

              SizedBox(height: 20.h), // Responsive spacing

              // Action button
              SizedBox(
                width: double.infinity,
                child: CustomButton(
                  label: controller.currentQuestionType == 'matching' &&
                      controller.checkedPairs.length < controller.getCurrentPairs().length ||
                      !controller.isCorrect.value
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
                  color: controller.isCorrect.value ? AppColors.clrGreen2 : AppColors.clrRed,
                  txtClr: Colors.white,
                  width: double.infinity, // Full-width button
                  height: 50.h, // Responsive height
                ),
              ),
            ],
          ),
        ),
      );
    }
  }

  Widget _buildCompletionScreen() {
    final results = controller.answerResults; // [{term: 'إفطار', correct: 0, wrong: 1}, ...]

    return Center(
      child: Padding(
        padding: EdgeInsets.all(20.w), // Responsive padding
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Row(
              children: [
                // Left icon
                GestureDetector(
                  onTap: () => Get.back(),
                  child: SvgPicture.asset(
                    'assets/images/lessons/close-circle_icon.svg',
                    width: 24.w, // Responsive SVG width
                    height: 24.h, // Responsive SVG height
                  ),
                ),
                SizedBox(width: 20.w), // Responsive spacing
                // Progress Bar
                Expanded(
                  child: LinearProgressIndicator(
                    value: controller.progress,
                    borderRadius: BorderRadius.all(Radius.circular(10.r)), // Responsive border radius
                    backgroundColor: AppColors.btnClr2,
                    valueColor: const AlwaysStoppedAnimation<Color>(
                        AppColors.clrGreen2),
                    minHeight: 12.h, // Responsive height
                  ),
                ),
                SizedBox(width: 20.w), // Responsive spacing
                // Right icon
                SvgPicture.asset(
                  'assets/images/home/settings_icon.svg',
                  width: 24.w, // Responsive SVG width
                  height: 24.h, // Responsive SVG height
                ),
              ],
            ),

            // Sad emoji
            Text(
              '😢',
              style: TextStyle(fontSize: 48.sp), // Responsive font size
            ),

            SizedBox(height: 12.h), // Responsive spacing

            // Encouraging message
            Text(
              "You'll do better next time!",
              style: h2.copyWith(
                fontSize: 18.sp, // Responsive font size
                color: AppColors.clrGreen5,
              ),
            ),

            SizedBox(height: 16.h), // Responsive spacing

            // Progress
            Text(
              "${controller.correctAnswersCount}/${controller.totalQuestions}",
              style: h2.copyWith(
                fontSize: 16.sp, // Responsive font size
                color: AppColors.clrGreen5,
              ),
            ),

            SizedBox(height: 24.h), // Responsive spacing

            // Terms Studied
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Terms Studied",
                style: h2.copyWith(
                  fontSize: 18.sp, // Responsive font size
                ),
              ),
            ),
            SizedBox(height: 12.h), // Responsive spacing

            // Answer Result Cards
            ...results.map((result) {
              final term = result['term'] as String;
              final translation = result['translation'] as String;
              final correct = result['correct'] as int;
              final wrong = result['wrong'] as int;

              return Container(
                margin: EdgeInsets.symmetric(vertical: 6.h), // Responsive margin
                padding: EdgeInsets.all(12.w), // Responsive padding
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey[300]!, width: 1.w), // Responsive border width
                  borderRadius: BorderRadius.circular(12.r), // Responsive border radius
                  color: Colors.white,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Term and audio icon
                    Column(
                      children: [
                        Row(
                          children: [
                            Text(
                              term,
                              style: h4.copyWith(fontSize: 18.sp), // Responsive font size
                            ),
                            SizedBox(width: 8.w), // Responsive spacing
                            SvgPicture.asset(
                              'assets/images/vocabulary/audio_icon.svg',
                              width: 24.w, // Responsive SVG width
                              height: 24.h, // Responsive SVG height
                            ),
                          ],
                        ),
                        Text(
                          translation,
                          style: h4.copyWith(fontSize: 18.sp, color: Colors.black87), // Responsive font size
                        ),
                      ],
                    ),

                    // Correct and wrong badges
                    Row(
                      children: [
                        _buildResultBadge(correct, AppColors.clrGreen5),
                        SizedBox(width: 4.w), // Responsive spacing
                        _buildResultBadge(wrong, AppColors.clrRed4),
                      ],
                    ),
                  ],
                ),
              );
            }).toList(),

            SizedBox(height: 30.h), // Responsive spacing

            // Close Button
            CustomButton(
              label: 'Close',
              onPressed: () => Get.back(),
              color: AppColors.btnClr1,
              txtClr: AppColors.btnTxt1,
              width: double.infinity, // Full-width button
              height: 50.h, // Responsive height
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildResultBadge(int count, Color color) {
    return Container(
      width: 24.w, // Responsive width
      height: 24.h, // Responsive height
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(20.r), // Responsive border radius
      ),
      child: Text(
        count.toString(),
        style: TextStyle(
          fontSize: 14.sp, // Responsive font size
          color: color,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}