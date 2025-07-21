import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../../common/appColors.dart';
import '../../../../common/customFont.dart';
import '../../../../common/widgets/customButton.dart';
import '../controllers/setup_profile_controller.dart';

class SetupProfileView extends GetView<SetupProfileController> {
  const SetupProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() => Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              _buildCurrentScreen(),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        color: Colors.transparent,
        elevation: 0,
        child: CustomButton(
          label: 'Continue',
          onPressed: () {
            print('Button pressed, current step: ${controller.currentStep.value}');
            if (controller.currentStep.value == 7) {
              print('Completing onboarding');
              controller.completeOnboarding();
            } else if (controller.currentStep.value == 1) {
              print('Moving from step 1 to step 2');
              controller.nextStep();
            } else if (controller.isStepValid()) {
              print('Step ${controller.currentStep.value} is valid, moving to next');
              controller.nextStep();
            } else {
              print('Step ${controller.currentStep.value} is invalid');
            }
          },
          color: controller.currentStep.value == 7 || controller.currentStep.value == 1 || controller.isStepValid()
              ? AppColors.btnClr1
              : AppColors.btnClr2,
          txtClr: controller.currentStep.value == 7 || controller.currentStep.value == 1 || controller.isStepValid()
              ? AppColors.btnTxt1
              : AppColors.btnTxt2,
        ),
      ),
    ));
  }

  Widget _buildCurrentScreen() {
    print('Building screen for step: ${controller.currentStep.value}');
    switch (controller.currentStep.value) {
      case 0:
        return _buildLanguageScreen();
      case 1:
        return _buildGoalScreen1();
      case 2:
        return _buildGoalScreen2();
      case 3:
        return _buildGoalScreen3();
      case 4:
        return _buildGoalScreen4();
      case 5:
        return _buildGoalScreen5();
      case 6:
        return _buildGoalScreen6();
      case 7:
        return _buildAchievementScreen();
      default:
        return _buildLanguageScreen();
    }
  }

  Widget _buildLanguageScreen() {
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GestureDetector(
                onTap: () {
                  Get.back();
                },
                child: Text('< Back',
                    style: h3.copyWith(color: AppColors.textBlue, fontSize: 16)),
              ),
              Text('1/8',
                  style: h1.copyWith(color: AppColors.textColor, fontSize: 20)),
            ],
          ),
          const SizedBox(height: 40),
          Text(
            'Which language would you like to learn?',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 40),
          _buildLanguageOption(
              'assets/images/flags/en_flag.png',
              'Spanish',
              '300 million native speakers worldwide'),
          const SizedBox(height: 16),
          _buildLanguageOption(
              'assets/images/flags/de_flag.png',
              'German',
              'Most spoken native language in Europe'),
          const SizedBox(height: 80), // Space to prevent content cutoff
        ],
      ),
    );
  }

  Widget _buildLanguageOption(
      String imagePath, String language, String description) {
    bool isSelected = controller.selectedLanguage.value == language;
    return GestureDetector(
      onTap: () => controller.selectLanguage(language),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          border: Border.all(
            color: AppColors.borderClr,
            width: isSelected ? 2 : 1,
          ),
          borderRadius: BorderRadius.circular(12),
          color: isSelected ? AppColors.btnClr3 : Colors.white,
        ),
        child: Row(
          children: [
            Image.asset(
              imagePath,
              width: 39,
              height: 39,
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    language,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    description,
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey[600],
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


  Widget _buildGoalScreenTemplate({
    required String step,
    required String title,
    required List<GoalOption> options,
    bool isStep2Layout = false,
  }) {
    return Obx(() => Padding(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GestureDetector(
                onTap: controller.previousStep,
                child: Text('< Back',
                    style: h3.copyWith(color: AppColors.textBlue, fontSize: 16)),
              ),
              Text(step,
                  style: h1.copyWith(color: AppColors.textColor, fontSize: 20)),
            ],
          ),
          const SizedBox(height: 40),
          Center(
            child: Text(
              textAlign: TextAlign.center,
              title,
              style: h3.copyWith(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
          ),
          const SizedBox(height: 40),
          ...options.map((option) => Padding(
            padding: const EdgeInsets.only(bottom: 16),
            child: isStep2Layout
                ? _buildGoalOptionStep2(option, controller.currentStep.value)
                : _buildGoalOption(option, controller.currentStep.value),
          )),
          const SizedBox(height: 50),
          Center(
            child: Text(
              textAlign: TextAlign.center,
              controller.getStatsForStep(controller.currentStep.value),
              style: h3.copyWith(
                fontSize: 16,
                color: AppColors.textColor,
              ),
            ),
          ),
          const SizedBox(height: 80), // Space to prevent content cutoff
        ],
      ),
    ));
  }
  Widget _buildGoalScreen1() {
    return _buildGoalScreenTemplate(
      step: '2/8',
      title: 'Learn Our basic Arabic for — with the Quran Memory App',
      options: [
        GoalOption(
            'assets/images/goal/book_image.svg',
            'Build a deep vocabulary',
            'Learn by reading and listening to the Qur’an, Hadith, and Islamic movies. Learn Qur’anic Arabic naturally no grammar rules, no textbooks.',
            false),
        GoalOption(
            'assets/images/goal/listen_image.svg',
            'Become a fluent listener',
            'Listen until you understand the Qur’an, Hadith, and Islamic scholars without needing a translation. Master the Quranic Arabic language in just six months.',
            false),
        GoalOption(
            'assets/images/goal/fire_image.svg',
            'Make Qur’anic learning a habit',
            'Use daily goals, challenges & reminders to stay consistent. The Prophet ﷺ said: The best deeds are those done regularly, even if they are small.',
            false),
      ],
      isStep2Layout: true,
    );
  }

  Widget _buildGoalScreen2() {
    return _buildGoalScreenTemplate(
      step: '3/8',
      title: 'How much time do you commit to learning Quran?',
      options: [
        GoalOption('', '15 minutes', 'Casual', false),
        GoalOption('', '30 minutes', 'Regular', false),
        GoalOption('', '45 minutes', 'Serious', false),
        GoalOption('', '60 minutes', 'Intense', false),
      ],
    );
  }

  Widget _buildGoalScreen3() {
    return _buildGoalScreenTemplate(
      step: '4/8',
      title: 'Why are you learning to commit to learning Quran?',
      options: [
        GoalOption('', '15 minutes', 'Casual', false),
        GoalOption('', '30 minutes', 'Regular', false),
        GoalOption('', '45 minutes', 'Serious', false),
        GoalOption('', '60 minutes', 'Intense', false),
      ],
    );
  }

  Widget _buildGoalScreen4() {
    return _buildGoalScreenTemplate(
      step: '5/8',
      title: 'How much time do you commit to learning Quran?',
      options: [
        GoalOption('', '15 minutes', 'Casual', false),
        GoalOption('', '30 minutes', 'Regular', false),
        GoalOption('', '45 minutes', 'Serious', false),
        GoalOption('', '60 minutes', 'Intense', false),
      ],
    );
  }

  Widget _buildGoalScreen5() {
    return _buildGoalScreenTemplate(
      step: '6/8',
      title: 'How much time do you commit to learning Quran?',
      options: [
        GoalOption('', '15 minutes', 'Casual', false),
        GoalOption('', '30 minutes', 'Regular', false),
        GoalOption('', '45 minutes', 'Serious', false),
        GoalOption('', '60 minutes', 'Intense', false),
      ],
    );
  }

  Widget _buildGoalScreen6() {
    return _buildGoalScreenTemplate(
      step: '7/8',
      title: 'How much time do you commit to learning Quran?',
      options: [
        GoalOption('', '15 minutes', 'Casual', false),
        GoalOption('', '30 minutes', 'Regular', false),
        GoalOption('', '45 minutes', 'Serious', false),
        GoalOption('', '60 minutes', 'Intense', false),
      ],
    );
  }

  Widget _buildGoalOption(GoalOption option, int step) {
    bool isSelected = controller.selectedGoalStep[step] == option.title;
    return GestureDetector(
      onTap: () => controller.selectGoal(option.title, step),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          border: Border.all(
            color: AppColors.borderClr,
            width: isSelected ? 2 : 1,
          ),
          borderRadius: BorderRadius.circular(12),
          color: isSelected ? AppColors.btnClr3 : Colors.white,
        ),
        child: Row(
          children: [
            if (option.icon.isNotEmpty) ...[
              SvgPicture.asset(
                option.icon,
              ),
              const SizedBox(width: 16),
            ],
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(4.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      option.title,
                      style: h3.copyWith(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Colors.black87,
                      ),
                    ),
                    if (option.description.isNotEmpty) ...[
                      const SizedBox(height: 4),
                      Text(
                        option.description,
                        style: h3.copyWith(
                          fontSize: 14,
                          color: Colors.grey[600],
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            ),
            Text(
              option.level,
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey[600],
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildGoalOptionStep2(GoalOption option, int step) {
    bool isSelected = controller.selectedGoalStep[step] == option.title;
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        border: Border.all(
          color: AppColors.borderClr,
          width: isSelected ? 2 : 1,
        ),
        borderRadius: BorderRadius.circular(12),
        color: isSelected ? AppColors.btnClr3 : Colors.white,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SvgPicture.asset(
            option.icon,
            width: 24,
            height: 24,
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  option.title,
                  style: h3.copyWith(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  option.description,
                  style: h3.copyWith(
                    fontSize: 14,
                    color: Colors.grey[600],
                  ),
                  softWrap: true,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAchievementScreen() {
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GestureDetector(
                onTap: controller.previousStep,
                child: Text(
                  '< Back',
                  style: h3.copyWith(color: AppColors.textBlue, fontSize: 20),
                ),
              ),
              Text(
                '8/8',
                style: h1.copyWith(color: AppColors.textColor, fontSize: 20),
              ),
            ],
          ),
          const SizedBox(height: 40),
          Text(
            'Achieve your goals',
            style: h1.copyWith(
              fontSize: 26,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 40),
          Text(
            'Get daily reminders to maintain your 60 min/day commitment to learning Quranic.',
            style: h3.copyWith(
              fontSize: 16,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 70),
          SvgPicture.asset('assets/images/goal/goal_image.svg'),
          const SizedBox(height: 80), // Space to prevent content cutoff
        ],
      ),
    );
  }
}

class GoalOption {
  final String icon;
  final String title;
  final String description;
  final String level;
  final bool isSelected;


  GoalOption(this.icon, this.title, this.description, this.isSelected,
      [this.level = '']);
}