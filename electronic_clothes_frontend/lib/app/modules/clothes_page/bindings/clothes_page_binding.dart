import 'package:get/get.dart';

import '../controllers/clothes_page_controller.dart';

class ClothesPageBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ClothesPageController>(
      () => ClothesPageController(),
    );
  }
}
