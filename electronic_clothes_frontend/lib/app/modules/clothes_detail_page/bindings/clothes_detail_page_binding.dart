import 'package:get/get.dart';

import '../controllers/clothes_detail_page_controller.dart';

class ClothesDetailPageBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ClothesDetailPageController>(
      () => ClothesDetailPageController(),
    );
  }
}
