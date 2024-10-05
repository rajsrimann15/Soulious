import 'package:get/get.dart';

import '../controllers/document_page_controller.dart';

class DocumentPageBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DocumentPageController>(
      () => DocumentPageController(),
    );
  }
}
