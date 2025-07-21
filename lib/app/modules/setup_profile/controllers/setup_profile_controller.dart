import 'package:get/get.dart';
import 'package:quranapp/app/modules/dashboard/views/dashboard_view.dart';

class SetupProfileController extends GetxController {
  var currentStep = 0.obs;
  var selectedLanguage = ''.obs;
  var selectedGoals = <String>[].obs;
  var selectedGoalStep = <int, String>{}.obs;
  var statsMap = <int, Map<String, String>>{}.obs;
  void nextStep() {
    if (currentStep.value < 7) {
      print('Before increment: currentStep = ${currentStep.value}');
      currentStep.value++;
      print('After increment: currentStep = ${currentStep.value}');
    } else {
      print('Cannot increment, already at max step: ${currentStep.value}');
    }
  }

  @override
  void onInit() {
    super.onInit();
    // Initialize stats for each step and goal
    statsMap.value = {
      2: {
        '15 minutes': '1500 Words\nGet Started. Understand 34% of the Quran',
        '30 minutes': '2000 Words\nIntermediate. Understand 50% of the Quran',
        '45 minutes': '2500 Words\nAdvanced. Understand 75% of the Quran',
        '60 minutes': '3000 Words\nGood level. Understand 100% of the Quran',
      },
      3: {
        '15 minutes': '1500 Words\nGet Started. Understand 34% of the Quran',
        '30 minutes': '2000 Words\nIntermediate. Understand 50% of the Quran',
        '45 minutes': '2500 Words\nAdvanced. Understand 75% of the Quran',
        '60 minutes': '3000 Words\nGood level. Understand 100% of the Quran',
      },
      4: {
        '15 minutes': '1500 Words\nBeginner. Understand 34% of the Quran',
        '30 minutes': '2000 Words\nIntermediate. Understand 50% of the Quran',
        '45 minutes': '2500 Words\nAdvanced. Understand 75% of the Quran',
        '60 minutes': '3000 Words\nGood level. Understand 100% of the Quran',
      },
      5: {
        '15 minutes': '1500 Words\nBeginner. Understand 34% of the Quran',
        '30 minutes': '2000 Words\nIntermediate. Understand 50% of the Quran',
        '45 minutes': '2500 Words\nAdvanced. Understand 75% of the Quran',
        '60 minutes': '3000 Words\nGood level. Understand 100% of the Quran',
      },
      6: {
        '15 minutes': '1500 Words\nJoin the community with basic understanding',
        '30 minutes': '2000 Words\nEngage with intermediate community insights',
        '45 minutes': '2500 Words\nContribute to community discussions',
        '60 minutes': '3000 Words\nBe a leader in community opinions and writings',
      },
    };
  }

  void previousStep() {
    if (currentStep.value > 0) {
      currentStep.value--;
    }
  }

  void selectLanguage(String language) {
    selectedLanguage.value = language;
  }

  void selectGoal(String goal, int step) {
    selectedGoalStep[step] = goal;
    selectedGoals.add(goal);
  }

  bool isStepValid() {
    switch (currentStep.value) {
      case 0:
        return selectedLanguage.value.isNotEmpty;
      case 1:
      case 2:
      case 3:
      case 4:
      case 5:
      case 6:
        return selectedGoalStep[currentStep.value] != null;
      default:
        return true;
    }
  }
  String getStatsForStep(int step) {
    if (step == 1) {
      // Step 2/8 has fixed stats
      return '';
    }
    final selectedGoal = selectedGoalStep[step] ?? '';
    return statsMap[step]?[selectedGoal] ??  '2500 Words\nAdvanced. Understand 75% of the Quran';
  }

  void completeOnboarding() {
    Get.offAll(DashboardView());
  }
}