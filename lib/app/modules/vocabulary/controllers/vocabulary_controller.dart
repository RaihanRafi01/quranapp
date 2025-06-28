import 'package:get/get.dart';

class VocabularyController extends GetxController {
  var tabIndex = 0.obs;

  RxBool isDarkTheme = false.obs;
  RxBool isEnglish = true.obs;
  RxBool showAbout = false.obs;

  void toggleTheme(bool value) => isDarkTheme.value = value;
  void toggleLanguage(bool value) => isEnglish.value = value;
  void toggleAbout(bool value) => showAbout.value = value;

  final count = 0.obs;
  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void increment() => count.value++;
}
