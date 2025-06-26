import 'package:get/get.dart';

import '../views/home_view.dart';

class HomeController extends GetxController {
  var selectedCourse = Rx<CourseItem?>(null);

  void selectCourse(CourseItem course) {
    selectedCourse.value = course;
  }

  void clearSelection() {
    selectedCourse.value = null;
  }
}