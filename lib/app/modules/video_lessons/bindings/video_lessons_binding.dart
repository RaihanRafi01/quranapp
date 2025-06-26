import 'package:get/get.dart';

import '../controllers/video_lessons_controller.dart';

class VideoLessonsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<VideoLessonsController>(
      () => VideoLessonsController(),
    );
  }
}
