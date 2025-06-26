import 'package:get/get.dart';

import '../controllers/quranic_lessons_controller.dart';

class QuranicLessonsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<QuranicLessonsController>(
      () => QuranicLessonsController(),
    );
  }
}
