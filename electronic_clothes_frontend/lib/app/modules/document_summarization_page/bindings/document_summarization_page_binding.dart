import 'package:get/get.dart';

import '../controllers/document_summarization_page_controller.dart';

class DocumentSummarizationPageBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DocumentSummarizationPageController>(
      () => DocumentSummarizationPageController(),
    );
  }
}
