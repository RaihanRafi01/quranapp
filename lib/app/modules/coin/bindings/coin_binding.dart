import 'package:get/get.dart';

import '../controllers/coin_controller.dart';

class CoinBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CoinController>(
      () => CoinController(),
    );
  }
}
