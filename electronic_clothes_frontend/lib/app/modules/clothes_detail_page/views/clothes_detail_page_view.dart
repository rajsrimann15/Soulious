import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/clothes_detail_page_controller.dart';

class ClothesDetailPageView extends GetView<ClothesDetailPageController> {
  const ClothesDetailPageView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ClothesDetailPageView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'ClothesDetailPageView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
