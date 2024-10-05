import 'dart:convert';

import 'package:electronic_clothes_frontend/main.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class AnonymousUserDetailsPageController extends GetxController {
  MainController mainController = Get.find<MainController>();

  // final id = Get.arguments['objectId'];
  final id = "66ffbe96a87d10e65f288314";

  RxBool editGeneralDetails = false.obs;

  late RxBool isLight;
  RxBool viewContact = false.obs;
  RxBool fileReady = false.obs;

  RxBool ready = false.obs;

  bool isTapped = false;

  RxMap userData = {}.obs;

  @override
  void onInit() {
    super.onInit();
    isLight =
        (mainController.currentTheme.value.CURRENTTHEME.value == 'light').obs;

    getUser();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  Future<void> getUser() async {
    final response = await http.get(
        Uri.parse(
            "${MainController.url}/users/$id"),
        headers: {
          'Authorization':
              'Bearer ${await MainController.storage.read(key: 'accessToken')}'
        });

    if (response.statusCode == 200) {
      userData.value = jsonDecode(response.body);
      print('user detail ${userData['contacts']}');
      ready.value = true;
    } else {
      print(response.body);
    }
  }
}
