import 'package:get/get.dart';

class SetupProfileController extends GetxController {
  var currentStep = 0.obs;
  var selectedLanguage = ''.obs;
  var selectedGoals = <String>[].obs;
  var selectedGoalStep = <int, String>{}.obs;

  void nextStep() {
    if (currentStep.value < 7 && isStepValid()) {
      currentStep.value++;
    }
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

  void completeOnboarding() {
    Get.offAllNamed('/home'); // Adjust route as needed
  }
}