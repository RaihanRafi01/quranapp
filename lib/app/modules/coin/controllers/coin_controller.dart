import 'package:get/get.dart';

class CoinController extends GetxController {
  // Toggle state for Today/All Time
  var isToday = true.obs;

  // Stats for Today
  var todayCoins = 8.obs;
  var todayLessons = 1.obs;
  var todayHoursListened = 0.0.obs;
  var todayMarkedLearned = 1.obs;
  var todayKnownWords = 0.obs;
  var todayStudyTime = '00:00'.obs;

  // Stats for All Time
  var allTimeCoins = 20.obs;
  var allTimeLessons = 10.obs;
  var allTimeHoursListened = 5.0.obs;
  var allTimeMarkedLearned = 15.obs;
  var allTimeKnownWords = 100.obs;
  var allTimeStudyTime = '10:30'.obs;

  // Function to toggle between Today and All Time
  void setToday(bool value) {
    isToday.value = value;
  }
}