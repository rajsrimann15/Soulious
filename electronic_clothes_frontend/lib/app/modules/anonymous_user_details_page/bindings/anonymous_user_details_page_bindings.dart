
import 'package:electronic_clothes_frontend/app/modules/anonymous_user_details_page/controllers/anonymous_user_details_page_controllers.dart';
import 'package:get/get.dart';


class AnonymousUserDetailsPageBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AnonymousUserDetailsPageController>(
      () => AnonymousUserDetailsPageController(),
    );
  }
}
