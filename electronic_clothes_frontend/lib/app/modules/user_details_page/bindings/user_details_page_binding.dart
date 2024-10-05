import 'package:get/get.dart';

import '../controllers/user_details_page_controller.dart';

class UserDetailsPageBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<UserDetailsPageController>(
      () => UserDetailsPageController(),
    );
  }
}
