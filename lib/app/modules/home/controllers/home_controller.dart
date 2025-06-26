import 'package:get/get.dart';
import '../views/home_view.dart';

class HomeController extends GetxController {
  var selectedCourse = Rx<CourseItem?>(null);
  var sectionTitle = RxString('Video Lessons');

  void selectCourse(CourseItem course) {
    selectedCourse.value = course;
    sectionTitle.value = course.lessonType;
  }

  void clearSelection() {
    selectedCourse.value = null;
    sectionTitle.value = 'Video Lessons'; // Reset to default
  }
}