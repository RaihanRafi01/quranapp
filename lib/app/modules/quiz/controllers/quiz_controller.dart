import 'package:get/get.dart';

class QuizController extends GetxController {
  var currentQuestionIndex = 0.obs;
  var selectedAnswer = ''.obs;
  var isAnswerSubmitted = false.obs;
  var isCorrect = false.obs;
  var quizCompleted = false.obs;

  // For matching questions
  var selectedPairs = <String, String>{}.obs;
  var checkedPairs = <String, String>{}.obs; // Track checked pairs
  var correctPairs = <String, String>{}.obs;
  var selectedItems = <String>[].obs;

  List<Map<String, dynamic>> questions = [
    {
      'question': 'Choose the correct translation',
      'arabic': 'زیتون',
      'options': ['Avocado', 'Olives', 'Broccoli', 'Okra'],
      'correct': 'Olives',
      'type': 'multiple_choice'
    },
    {
      'question': 'Choose the correct translation',
      'arabic': 'رنج',
      'options': ['Avocado', 'Oranges', 'Broccoli', 'Okra'],
      'correct': 'Oranges',
      'type': 'multiple_choice'
    },
    {
      'question': 'Tap the pairs',
      'arabic': '',
      'options': [],
      'correct': '',
      'type': 'matching',
      'pairs': {
        'four': 'أربعة',
        'football': 'كرة القدم',
        'three': 'ثلاثة',
        'German': 'ألماني',
        'like': 'مثل'
      }
    },
    // Add more questions as needed
  ];

  void selectAnswer(String answer) {
    if (!isAnswerSubmitted.value) {
      selectedAnswer.value = answer;
    }
  }

  void selectMatchingItem(String item) {
    if (isAnswerSubmitted.value || checkedPairs.containsKey(item)) return;

    if (selectedItems.contains(item)) {
      selectedItems.remove(item);
    } else {
      selectedItems.add(item);

      if (selectedItems.length == 2) {
        String first = selectedItems[0];
        String second = selectedItems[1];
        selectedPairs[first] = second;
      }
    }
  }

  void checkPair() {
    if (selectedItems.length == 2) {
      String first = selectedItems[0];
      String second = selectedItems[1];
      Map<String, String> currentPairs = getCurrentPairs();

      // Check if the selected pair is valid (English -> Arabic or Arabic -> English)
      bool isValidPair = false;
      for (var entry in currentPairs.entries) {
        if ((entry.key == first && entry.value == second) ||
            (entry.key == second && entry.value == first)) {
          isValidPair = true;
          break;
        }
      }

      // Update checkedPairs and set isCorrect
      checkedPairs[first] = second;
      isCorrect.value = isValidPair;
      isAnswerSubmitted.value = true; // Show result UI

      // Clear selections for the next pair
      selectedPairs.clear();
      selectedItems.clear();

      // Check if all pairs are matched
      if (checkedPairs.length == currentPairs.length) {
        // Verify all pairs are correct
        bool allCorrect = true;
        for (var entry in currentPairs.entries) {
          if (checkedPairs[entry.key] != entry.value) {
            allCorrect = false;
            break;
          }
        }
        isCorrect.value = allCorrect;
      }
    }
  }

  void nextQuestion() {
    if (currentQuestionIndex.value < questions.length - 1) {
      currentQuestionIndex.value++;
      selectedAnswer.value = '';
      isAnswerSubmitted.value = false;
      isCorrect.value = false;
      selectedPairs.clear();
      checkedPairs.clear();
      correctPairs.clear();
      selectedItems.clear();
    } else {
      quizCompleted.value = true;
    }
  }

  bool canSubmitMatching() {
    Map<String, String> currentPairs = getCurrentPairs();
    if (checkedPairs.length != currentPairs.length) return false;
    for (var entry in currentPairs.entries) {
      if (checkedPairs[entry.key] != entry.value) {
        return false;
      }
    }
    return true;
  }

  void submitAnswer() {
    if (currentQuestionType == 'matching') {
      isAnswerSubmitted.value = true;
      Map<String, String> currentPairs = getCurrentPairs();
      correctPairs.value = currentPairs;

      // Check if all pairs are checked and correct
      bool allChecked = true;
      for (String key in currentPairs.keys) {
        if (!checkedPairs.containsKey(key) ||
            checkedPairs[key] != currentPairs[key]) {
          allChecked = false;
          break;
        }
      }
      isCorrect.value = allChecked && checkedPairs.length == currentPairs.length;
    } else {
      if (selectedAnswer.value.isNotEmpty) {
        isAnswerSubmitted.value = true;
        isCorrect.value = selectedAnswer.value == questions[currentQuestionIndex.value]['correct'];
      }
    }
  }


  Map<String, String> getCurrentPairs() {
    if (currentQuestionType == 'matching') {
      return Map<String, String>.from(questions[currentQuestionIndex.value]['pairs'] ?? {});
    }
    return {};
  }


  String get currentQuestion => questions[currentQuestionIndex.value]['question'];
  String get currentArabic => questions[currentQuestionIndex.value]['arabic'];
  List<String> get currentOptions => List<String>.from(questions[currentQuestionIndex.value]['options']);
  String get correctAnswer => questions[currentQuestionIndex.value]['correct'];
  String get currentQuestionType => questions[currentQuestionIndex.value]['type'] ?? 'multiple_choice';
  double get progress => (currentQuestionIndex.value + 1) / questions.length;
}