import 'package:get/get.dart';

import '../controllers/hadith_lessons_controller.dart';

class HadithLessonsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HadithLessonsController>(
      () => HadithLessonsController(),
    );
  }
}
