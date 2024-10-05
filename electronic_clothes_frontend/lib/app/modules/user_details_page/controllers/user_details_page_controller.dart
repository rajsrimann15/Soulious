import 'dart:convert';

import 'package:electronic_clothes_frontend/main.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class UserDetailsPageController extends GetxController {
  MainController mainController = Get.find<MainController>();

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

    print('user detail ${userData}');
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
            "${MainController.url}/users/${await MainController.storage.read(key: 'userId')}"),
        headers: {
          'Authorization':
              'Bearer ${await MainController.storage.read(key: 'accessToken')}'
        });

    print(response.body);

    if (response.statusCode == 200) {
      userData.value = jsonDecode(response.body);
      ready.value = true;
    } else {
      print(response.body);
      Get.toNamed('/register-page');
    }
  }
}
