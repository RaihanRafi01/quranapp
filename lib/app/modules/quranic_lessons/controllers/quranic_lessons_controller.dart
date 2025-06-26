import 'package:get/get.dart';

import '../views/quranicLessonsSettings_view.dart';

class QuranicLessonsController extends GetxController {
  var isPlaying = false.obs;
  var currentPosition = 0.0.obs;
  var totalDuration = 100.0.obs;
  var currentAyah = 1.obs;
  var isInPlayerMode = false.obs;
  var playbackSpeed = 1.0.obs;
  var isPlayerRowVisible = false.obs;
  var selectedView = "Arabic".obs; // Default view
  var selectedFont = "KQFOPCB Hafs, Uthmani/Madani".obs; // Default font
  var selectedTranslation = "English".obs; // Default translation

  void togglePlayerRow() {
    isPlayerRowVisible.toggle();
  }

  void navigateToSettings() {
    Get.to(() => QuranicLessonsSettingsView());
  }


  void togglePlayPause() {
    isPlaying.value = !isPlaying.value;
  }

  void showPlayer() {
    isInPlayerMode.value = true;
  }

  void hidePlayer() {
    isInPlayerMode.value = false;
  }

  void nextAyah() {
    if (currentAyah.value < 2) {
      currentAyah.value++;
    }
  }

  void previousAyah() {
    if (currentAyah.value > 1) {
      currentAyah.value--;
    }
  }

  void seekTo(double position) {
    currentPosition.value = position;
  }

  void changeSpeed() {
    if (playbackSpeed.value == 1.0) {
      playbackSpeed.value = 1.25;
    } else if (playbackSpeed.value == 1.25) {
      playbackSpeed.value = 1.5;
    } else {
      playbackSpeed.value = 1.0;
    }
  }
}