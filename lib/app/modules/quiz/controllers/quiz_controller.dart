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
    if (isAnswerSubmitted.value || checkedPairs.containsKey(item) || checkedPairs.containsValue(item)) return;

    if (selectedItems.contains(item)) {
      selectedItems.remove(item);
      selectedPairs.clear(); // Clear pairs if an item is deselected
    } else {
      if (selectedItems.length < 2) {
        selectedItems.add(item);
        if (selectedItems.length == 2) {
          String first = selectedItems[0];
          String second = selectedItems[1];
          bool firstIsEnglish = getCurrentPairs().keys.contains(first);
          bool secondIsEnglish = getCurrentPairs().keys.contains(second);

          if (firstIsEnglish != secondIsEnglish) {
            String english = firstIsEnglish ? first : second;
            String arabic = firstIsEnglish ? second : first;
            selectedPairs[english] = arabic;
          } else {
            // If both are English or both are Arabic, clear the second selection
            selectedItems.removeLast();
            selectedPairs.clear();
          }
        }
      }
    }
    print('Selected items: $selectedItems, Selected pairs: $selectedPairs');
  }


  void checkPair() {
    print('Check paired Called');
    if (selectedItems.length == 2) {
      String first = selectedItems[0];
      String second = selectedItems[1];
      Map<String, String> currentPairs = getCurrentPairs();

      String english = currentPairs.containsKey(first) ? first : second;
      String arabic = currentPairs.containsKey(first) ? second : first;

      bool isValidPair = currentPairs[english] == arabic;

      checkedPairs[english] = arabic;
      isCorrect.value = isValidPair;
      isAnswerSubmitted.value = true;

      // Do not clear selectedItems immediately to allow UI to show feedback
      selectedPairs.clear();

      // Check if all pairs are matched
      if (checkedPairs.length == currentPairs.length) {
        bool allCorrect = true;
        for (var entry in currentPairs.entries) {
          if (checkedPairs[entry.key] != entry.value) {
            allCorrect = false;
            break;
          }
        }
        isCorrect.value = allCorrect;
      }

      print('Checked pair: $english -> $arabic, isCorrect: $isValidPair, checkedPairs: $checkedPairs');
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