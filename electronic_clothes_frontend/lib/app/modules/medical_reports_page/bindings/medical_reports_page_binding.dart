import 'package:get/get.dart';

import '../controllers/medical_reports_page_controller.dart';

class MedicalReportsPageBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MedicalReportsPageController>(
      () => MedicalReportsPageController(),
    );
  }
}
