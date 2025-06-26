import 'package:get/get.dart';

import '../controllers/imported_lessons_controller.dart';

class ImportedLessonsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ImportedLessonsController>(
      () => ImportedLessonsController(),
    );
  }
}
