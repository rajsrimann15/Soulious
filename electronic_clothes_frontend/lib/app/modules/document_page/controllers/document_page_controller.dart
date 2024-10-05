import 'dart:io';

import 'package:electronic_clothes_frontend/main.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';

class DocumentPageController extends GetxController {
  RxBool fileReady = false.obs;
  final documentUrl = Get.arguments['documentUrl'];
  final documentTitle = Get.arguments['documentName'];
  final mainController = Get.find<MainController>();
  RxDouble zoom = 0.0.obs;

  RxString path = ''.obs;

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }
}
