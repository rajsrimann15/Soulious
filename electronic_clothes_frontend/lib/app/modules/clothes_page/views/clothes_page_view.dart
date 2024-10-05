import 'package:electronic_clothes_frontend/app/modules/medical_reports_page/views/medical_reports_page_view.dart';
import 'package:electronic_clothes_frontend/app/modules/user_details_page/views/user_details_page_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'package:get/get.dart';

import '../controllers/clothes_page_controller.dart';

class ClothesPageView extends GetView<ClothesPageController> {
  const ClothesPageView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    controller.ownedClothes.forEach((element) =>
        precacheImage(NetworkImage(element['imageUrl']), context,
            onError: (obejct, stack) {
          print('error');
        }));
    controller.clothGallery.forEach((element) =>
        precacheImage(NetworkImage(element['imageUrl']), context,
            onError: (obejct, stack) {
          print('error');
        }));

        
    final screenSize = MediaQuery.sizeOf(context);
    return Scaffold(
      body: SizedBox(
        height: screenSize.height,
        width: screenSize.width,
        child: SingleChildScrollView(
          child: Column(
            children: [
              ClothesPageNavSection(),
              ClothesPageHeroSection(),
              ClothesPageContentSection()
            ],
          ),
        ),
      ),
    );
  }
}

class ClothesPageNavSection extends GetWidget<ClothesPageController> {
  const ClothesPageNavSection({super.key});

  @override
  Widget build(BuildContext context) {
    RxBool showTextTransition = false.obs;
    Future.delayed(const Duration(milliseconds: 1500),
        () => showTextTransition.value = true);
    final screenSize = MediaQuery.sizeOf(context);
    return Container(
      width: screenSize.width,
      margin: EdgeInsets.only(
          top: MediaQuery.paddingOf(context).top + 5, left: 5, right: 5),
      padding: const EdgeInsets.all(8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Text('SOULIOUS',
                      style: TextStyle(fontSize: screenSize.width * 0.05)),
                  Obx(() => AnimatedSize(
                        duration: const Duration(milliseconds: 800),
                        child: Container(
                          margin: const EdgeInsets.only(left: 10, top: 3),
                          child: Text('Clothes',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontFamily: 'vegan',
                                fontSize: showTextTransition.value
                                    ? screenSize.width * 0.05
                                    : 0.0,
                              )),
                        ),
                      ))
                ],
              ),
              Row(
                children: [
                  Container(
                      margin: const EdgeInsets.only(right: 10),
                      padding: const EdgeInsets.all(3),
                      child: InkResponse(
                        onTap: () {
                          Get.toNamed('/medical-reports-page');
                        },
                        child: SvgPicture.asset('assets/icons/cart-icon.svg',
                            height: screenSize.width * 0.07,
                            width: screenSize.width * 0.07,
                            fit: BoxFit.cover),
                      )),
                  Container(
                      padding: const EdgeInsets.all(3),
                      child: InkResponse(
                        onTap: () {
                          Get.toNamed('/medical-reports-page');
                        },
                        child: SvgPicture.asset('assets/icons/scan-icon.svg',
                            height: screenSize.width * 0.07,
                            width: screenSize.width * 0.07,
                            fit: BoxFit.cover),
                      )),
                ],
              ),
            ],
          ),
          Obx(
            () => AnimatedCrossFade(
              duration: const Duration(milliseconds: 500),
              crossFadeState: controller.isYourClothesSection.value
                  ? CrossFadeState.showFirst
                  : CrossFadeState.showSecond,
              firstChild: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    margin: const EdgeInsets.only(top: 15),
                    child: Text('Your\nSoulious Clothes',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: screenSize.width * 0.06,
                        )),
                  ),
                  Container(
                      padding: const EdgeInsets.all(3),
                      child: InkResponse(
                        onTap: () {
                          controller.isYourClothesSection.value = false;
                          controller.pageController.animateToPage(1,
                              duration: const Duration(milliseconds: 500),
                              curve: Curves.easeInOut);
                        },
                        child: Icon(Icons.keyboard_arrow_right,
                            size: screenSize.width * 0.08),
                      )),
                ],
              ),
              secondChild: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                      padding: const EdgeInsets.all(3),
                      child: InkResponse(
                        onTap: () {
                          controller.isYourClothesSection.value = true;
                          controller.pageController.animateToPage(0,
                              duration: const Duration(milliseconds: 500),
                              curve: Curves.easeInOut);
                        },
                        child: Icon(Icons.keyboard_arrow_left,
                            size: screenSize.width * 0.08),
                      )),
                  Container(
                    margin: const EdgeInsets.only(top: 15),
                    child: Text('Shop\nSoulious Clothes',
                        textAlign: TextAlign.right,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: screenSize.width * 0.06,
                        )),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class ClothesPageHeroSection extends GetWidget<ClothesPageController> {
  const ClothesPageHeroSection({super.key});

  Widget _heroSectionContainer(
      Size screenSize, Function heroSectionActionFunction,
      {String heroSectionTitle = 'Take your specials',
      String heroSectionSubtitle = 'Manage Your Soulious Clothes',
      String heroSectionActionButtonText = 'Add A Cloth',
      String heroSectionBackgroundImageUrl =
          'assets/images/your-dress-placeholder.jpg'}) {
    return Container(
      height: screenSize.height * 0.18,
      margin: const EdgeInsets.fromLTRB(15, 10, 15, 20),
      width: screenSize.width,
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: const BorderRadius.all(Radius.circular(15)),
          image: DecorationImage(
              image: AssetImage(heroSectionBackgroundImageUrl),
              fit: BoxFit.cover),
          boxShadow: [bottomShadow]),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(heroSectionTitle,
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: screenSize.width * 0.035,
                  )),
              Container(
                margin: const EdgeInsets.only(top: 3),
                child: Text(heroSectionSubtitle,
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: screenSize.width * 0.03,
                    )),
              ),
            ],
          ),
          InkResponse(
            onTap: () => heroSectionActionFunction(),
            child: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(color: Colors.black26),
                  borderRadius: const BorderRadius.all(Radius.circular(5))),
              child: Text(heroSectionActionButtonText,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: screenSize.width * 0.035,
                  )),
            ),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.sizeOf(context);
    return Obx(
      () => AnimatedCrossFade(
        duration: const Duration(milliseconds: 500),
        crossFadeState: controller.isYourClothesSection.value
            ? CrossFadeState.showFirst
            : CrossFadeState.showSecond,
        firstChild: _heroSectionContainer(screenSize, () {}),
        secondChild: _heroSectionContainer(
            screenSize, controller.heroSectionActionFunction,
            heroSectionTitle: controller.heroSectionTitle,
            heroSectionSubtitle: controller.heroSectionSubtitle,
            heroSectionActionButtonText: controller.heroSectionActionButtonText,
            heroSectionBackgroundImageUrl:
                controller.heroSectionBackgroundImageUrl),
      ),
    );
  }
}

class ClothesPageContentSection extends GetWidget<ClothesPageController> {
  const ClothesPageContentSection({super.key});

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.sizeOf(context);
    return Container(
        width: screenSize.width,
        height: screenSize.height,
        margin: const EdgeInsets.symmetric(horizontal: 15),
        child: PageView.builder(
            controller: controller.pageController
              ..addListener(() => controller.isYourClothesSection.value =
                  (controller.pageController.page ?? 1.0).toInt() == 0
                      ? true
                      : false),
            scrollDirection: Axis.horizontal,
            itemCount: 2,
            itemBuilder: (context, outerIndex) => GridView.builder(
                shrinkWrap: true,
                itemCount: outerIndex == 0
                    ? controller.ownedClothes.length
                    : controller.clothGallery.length,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 20,
                    crossAxisSpacing: 20,
                    childAspectRatio: 0.6),
                itemBuilder: (context, innerIndex) => Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Container(
                            margin: const EdgeInsets.only(bottom: 5),
                            decoration: BoxDecoration(
                                color: Colors.white,
                                image: DecorationImage(
                                    image: NetworkImage(outerIndex == 0
                                        ? controller.ownedClothes
                                            .elementAt(innerIndex)['imageUrl']
                                        : controller.clothGallery
                                            .elementAt(innerIndex)['imageUrl']),
                                    fit: BoxFit.cover),
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(15)),
                                boxShadow: [bottomShadow]),
                          ),
                        ),
                        Text(
                            outerIndex == 0
                                ? controller.ownedClothes
                                    .elementAt(innerIndex)['title']
                                : controller.clothGallery
                                    .elementAt(innerIndex)['title'],
                            style: TextStyle(
                              overflow: TextOverflow.ellipsis,
                              fontWeight: FontWeight.bold,
                              color: Colors.black87,
                              fontSize: screenSize.width * 0.038,
                            )),
                        Text(
                            outerIndex == 0
                                ? controller.ownedClothes
                                    .elementAt(innerIndex)['chipId']
                                : controller.clothGallery
                                    .elementAt(innerIndex)['price'],
                            style: TextStyle(
                              overflow: TextOverflow.ellipsis,
                              fontWeight: FontWeight.bold,
                              color: Colors.black54,
                              fontSize: screenSize.width * 0.032,
                            )),
                      ],
                    ))));
  }
}
