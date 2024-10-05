import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:electronic_clothes_frontend/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/svg.dart';

import 'package:get/get.dart';

import '../controllers/user_details_page_controller.dart';

class UserDetailsPageView extends GetView<UserDetailsPageController> {
  const UserDetailsPageView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.sizeOf(context);
    return Scaffold(
      body: Obx(
        () => Visibility(
          visible: controller.ready.value,
          replacement: SizedBox(
            height: screenSize.height,
            width: screenSize.width,
            child: Center(
              child: SpinKitFadingCube(color: Colors.blueAccent,),
            ),
          ),
          child: Container(
            decoration: BoxDecoration(
                gradient: controller
                    .mainController.currentTheme.value.backgroundGradient.value),
            height: screenSize.height,
            width: screenSize.width,
            // child: DoodleAnimator(),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  UserDetailPageFloatingNavbar(),
                  const UserDetailsHeroSection(),
                  const UserDetailsSectionsBreadCrumb(),
                  const UserDetailsBloodAndPhoneSection(),
                  const UserDetailsContactsSection()
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class UserDetailPageFloatingNavbar extends GetWidget<UserDetailsPageController> {
  UserDetailPageFloatingNavbar({super.key});

  final mainController = Get.find<MainController>();

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.sizeOf(context);
    return Container(
      width: screenSize.width,
      margin: EdgeInsets.only(
          top: MediaQuery.paddingOf(context).top + 5, left: 5, right: 5),
      padding: const EdgeInsets.all(8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text('SOULIOUS', style: TextStyle(fontSize: screenSize.width * 0.05)),
          Row(
            children: [
              Container(
                  margin: const EdgeInsets.only(right: 15),
                  padding: const EdgeInsets.all(3),
                  child: InkResponse(
                    onTap: () {
                      Get.toNamed('/clothes-page');
                    },
                    child: SvgPicture.asset('assets/icons/shirt-light.svg',
                        height: screenSize.width * 0.065,
                        width: screenSize.width * 0.065,
                        fit: BoxFit.cover),
                  )),
              InkResponse(
                onTap: () => Get.toNamed('/register-page'),
                child: controller.userData['imageBinary'] != null ? CircleAvatar(
                radius: screenSize.width * 0.05,
                backgroundImage: MemoryImage(base64Decode(controller.userData['imageBinary'])),
              ) : CircleAvatar(
                radius: screenSize.width * 0.05,
                backgroundImage: NetworkImage(controller.userData['image']),
              ),
              )
            ],
          ),
        ],
      ),
    );
  }
}

class UserDetailsHeroSection extends GetWidget<UserDetailsPageController> {
  const UserDetailsHeroSection({super.key});

  @override
  Widget build(BuildContext context) {
    Map carouselData = {
      0: {
        'title': controller.userData['profession'],
        'subtitle': '${controller.userData['age']} years old',
        'imageUrl': '',
        'edit': 'Edit Your Profile'
      },
      1: {
        'title': 'View Access',
        'subtitle': 'Edit Who Can View Your Details',
        'imageUrl':
            'https://img.freepik.com/premium-vector/boy-girl-create-account-social-media-vector-young-man-woman-using-smartphone-create-account-website-communication-chatting-with-friends-characters-flat-cartoon-illustration_87720-6016.jpg?size=338&ext=jpg&ga=GA1.1.2008272138.1721865600&semt=ais_user',
        'edit': 'Edit Access'
      },
      2: {
        'title': 'Medical Reports',
        'subtitle': 'Add A Report To Make It Easy To Diagnose You',
        'imageUrl':
            'https://static.vecteezy.com/system/resources/previews/012/440/300/original/medical-report-medical-3d-illustration-png.png',
        'edit': 'Add A Report'
      }
    };

    final screenSize = MediaQuery.sizeOf(context);
    RxInt carouselIndex = 0.obs;
    PageController carouselPageController = PageController();
    Timer? carouselTimer;

    carouselPageController.addListener(() {
      carouselIndex.value = carouselPageController.page!.toInt();
    });

    void carouselLoop() {
      carouselTimer = Timer(const Duration(milliseconds: 3000), () {
        if (carouselIndex.value == 2) {
          carouselIndex.value = 0;
          carouselPageController.animateToPage(carouselIndex.value,
              duration: const Duration(milliseconds: 800),
              curve: Curves.linear);
          return;
        } else {
          carouselIndex.value++;
          carouselPageController.animateToPage(carouselIndex.value,
              duration: const Duration(milliseconds: 800),
              curve: Curves.linear);
        }

        carouselLoop();
      });
    }

    carouselLoop();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: const EdgeInsets.only(left: 20),
          child: Text('Hello,',
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: screenSize.width * 0.06)),
        ),
        Container(
          margin: const EdgeInsets.only(left: 20),
          child: Row(
            children: [
              Text(controller.userData['name'],
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: screenSize.width * 0.06)),
              Container(
                  margin: const EdgeInsets.only(left: 5),
                  child: Obx(() => SvgPicture.asset(
                        controller.mainController.currentTheme.value
                            .handWaveIcon.value,
                        height: screenSize.width * 0.07,
                        width: screenSize.width * 0.07,
                      )))
            ],
          ),
        ),
        SizedBox(
          width: screenSize.width,
          height: screenSize.height * 0.28,
          child: PageView(
            controller: carouselPageController,
            scrollDirection: Axis.horizontal,
            children: List.generate(
              3,
              (index) => Container(
                height: screenSize.height * 0.25,
                width: screenSize.width,
                margin: const EdgeInsets.fromLTRB(10, 20, 10, 20),
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(Radius.circular(15)),
                  color: const Color.fromARGB(234, 4, 87, 83),
                  boxShadow: [
                    const BoxShadow(
                      color: Color.fromARGB(115, 4, 87, 83),
                      blurRadius: 5,
                      offset: Offset(0, 4),
                    ).scale(2),
                  ],
                ),
                child: Row(
                  children: [
                    Container(
                      height: double.infinity,
                      width: screenSize.width * 0.38,
                      decoration: BoxDecoration(
                          borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(15),
                              bottomLeft: Radius.circular(15)),
                          color: Colors.white,
                          image: index == 0 ? controller.userData['imageBinary'] != null ? DecorationImage(image: MemoryImage(base64Decode(controller.userData['imageBinary'])), fit: BoxFit.cover) : DecorationImage(image: NetworkImage(controller.userData['image']), fit: BoxFit.cover) : DecorationImage(
                              image:
                                  NetworkImage(carouselData[index]['imageUrl']),
                              fit: BoxFit.cover)),
                    ),
                    Container(
                        padding: const EdgeInsets.all(10),
                        decoration: const BoxDecoration(
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(15),
                                bottomLeft: Radius.circular(15))),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Obx(
                                  () => SizedBox(
                                    width: screenSize.width * 0.5,
                                    child: Text(carouselData[index]['title'],
                                        style: TextStyle(
                                            color: controller.isLight.value
                                                ? Colors.white
                                                : Colors.black,
                                            fontWeight: FontWeight.bold,
                                            fontSize:
                                                screenSize.width * 0.038)),
                                  ),
                                ),
                                Obx(
                                  () => SizedBox(
                                    width: screenSize.width * 0.5,
                                    child: Text(carouselData[index]['subtitle'],
                                        style: TextStyle(
                                            color: controller.isLight.value
                                                ? Colors.white
                                                : Colors.black,
                                            fontSize:
                                                screenSize.width * 0.034)),
                                  ),
                                ),
                              ],
                            ),

                            //google button and bio
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                if (index == 0) const Row(),
                                Obx(
                                  () => Row(
                                    children: [
                                      Container(
                                        margin: const EdgeInsets.only(top: 8),
                                        child: Text(carouselData[index]['edit'],
                                            style: TextStyle(
                                                color: controller.isLight.value
                                                    ? Colors.white
                                                    : Colors.blueAccent,
                                                decoration:
                                                    TextDecoration.underline,
                                                decorationColor:
                                                    controller.isLight.value
                                                        ? Colors.white
                                                        : Colors.blueAccent,
                                                fontSize:
                                                    screenSize.width * 0.03)),
                                      ),
                                      InkResponse(
                                        onTap: () {
                                          if (index == 0) {
                                            controller
                                                    .editGeneralDetails.value =
                                                !controller
                                                    .editGeneralDetails.value;
                                          }
                                        },
                                        child: Container(
                                          margin: const EdgeInsets.only(
                                              top: 7, left: 5),
                                          child: index == 2
                                              ? Icon(
                                                  Icons.add,
                                                  size:
                                                      screenSize.width * 0.038,
                                                  color: Colors.white,
                                                )
                                              : Obx(
                                                  () => Icon(
                                                    controller
                                                            .editGeneralDetails
                                                            .value
                                                        ? Icons.remove_red_eye
                                                        : Icons.edit,
                                                    size:
                                                        screenSize.width * 0.03,
                                                    color:
                                                        controller.isLight.value
                                                            ? Colors.white
                                                            : Colors.blueAccent,
                                                  ),
                                                ),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ],
                            )
                          ],
                        )),
                  ],
                ),
              ),
            ),
          ),
        ),
        Container(
            alignment: Alignment.center,
            margin: const EdgeInsets.only(top: 15),
            child: SizedBox(
              width: screenSize.width * 0.35,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(
                  3,
                  (index) => Obx(
                    () => InkResponse(
                        onTap: () async {
                          carouselIndex.value = index;
                          carouselPageController.animateToPage(index,
                              duration: const Duration(milliseconds: 250),
                              curve: Curves.linear);
                          // if (carouselTimer != null) {
                          //   carouselTimer!.cancel();
                          //   await Future.delayed(const Duration(seconds: 2),
                          //       () => carouselLoop());
                          // }
                        },
                        child: AnimatedSize(
                          duration: const Duration(milliseconds: 800),
                          child: Container(
                            height: 5,
                            width: carouselIndex.value == index
                                ? (screenSize.width * 0.3) * 0.4
                                : 5,
                            margin: const EdgeInsets.symmetric(horizontal: 2),
                            decoration: const BoxDecoration(
                              color: Colors.blueAccent,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(5000)),
                            ),
                          ),
                        )),
                  ),
                ),
              ),
            )),
      ],
    );
  }
}

class UserDetailsSectionsBreadCrumb extends StatefulWidget {
  const UserDetailsSectionsBreadCrumb({super.key});

  @override
  State<UserDetailsSectionsBreadCrumb> createState() =>
      _UserDetailsSectionsBreadCrumbState();
}

class _UserDetailsSectionsBreadCrumbState
    extends State<UserDetailsSectionsBreadCrumb> with TickerProviderStateMixin {
  final controller = Get.find<UserDetailsPageController>();
  late AnimationController animationController;
  late Animation animation;
  late bool limitExceeded;

  
  RxDouble target = 0.0.obs;
  RxDouble tabsToday = 0.0.obs;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    target.value = controller.userData['tabCount'] / 100;
    tabsToday.value = controller.userData['currentDayTabCount'] / 100;

    animationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 800));
    animation = Tween<double>(begin: 0.0, end: target.value)
        .animate(animationController);
    limitExceeded = target >= 0.60;
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.sizeOf(context);
    RxInt breadCrumbIndex = 0.obs;

    Future.delayed(const Duration(milliseconds: 2000),
        () => animationController.forward());

    return Container(
      margin: const EdgeInsets.only(top: 15, left: 15, right: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: const EdgeInsets.only(bottom: 5),
            child: Text(controller.userData['name'],
                style: TextStyle(
                    fontWeight: FontWeight.w400,
                    color: controller
                        .mainController.currentTheme.value.textColor.value,
                    fontSize: screenSize.width * 0.05)),
          ),
          Container(
            width: screenSize.width * 0.85,
            margin: const EdgeInsets.only(bottom: 10),
            child: Text('"${controller.userData['bio']}"',
                style: TextStyle(
                    fontWeight: FontWeight.w400,
                    color: controller
                        .mainController.currentTheme.value.textColor.value,
                    fontSize: screenSize.width * 0.04)),
          ),
          Row(
            children: List.generate(
                5,
                (index) => Obx(
                      () => InkResponse(
                        onTap: () {
                          breadCrumbIndex.value = index;
                        },
                        child: index % 2 != 0
                            ? Container(
                                margin: const EdgeInsets.only(
                                    bottom: 4, left: 8, right: 8),
                                child: Icon(
                                  Icons.circle,
                                  color: controller.mainController.currentTheme
                                      .value.textColor.value,
                                  size: 5,
                                ),
                              )
                            : InkResponse(
                                onTap: () => Get.toNamed([
                                  '/contacts-page',
                                  '/user-details-page',
                                  '/medical-reports-page',
                                  '/user-details-page',
                                  '/document-summarization-page',
                                ][index]),
                                child: Container(
                                  padding: const EdgeInsets.only(bottom: 2),
                                  child: Text(
                                      [
                                        'Edit View Access',
                                        'Medical Reports',
                                        'Report Summarization'
                                      ][index ~/ 2],
                                      style: TextStyle(
                                          color: controller
                                              .mainController
                                              .currentTheme
                                              .value
                                              .textColor
                                              .value
                                              .withOpacity(0.6),
                                          fontSize: screenSize.width * 0.028)),
                                ),
                              ),
                      ),
                    )),
          ),
          Container(
            margin: const EdgeInsets.only(top: 15),
            padding: const EdgeInsets.all(15),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: const BorderRadius.all(Radius.circular(15)),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.shade300,
                  blurRadius: 5,
                  offset: const Offset(0, 4),
                ).scale(2)
              ],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('No of tabs',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: controller.mainController.currentTheme.value
                                .textColor.value
                                .withOpacity(0.7),
                            fontSize: screenSize.width * 0.03)),
                    Container(
                      margin: const EdgeInsets.only(top: 5, bottom: 15),
                      child: Row(
                        children: [
                          Container(
                            margin: const EdgeInsets.only(right: 10),
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(8)),
                                color: controller.mainController.currentTheme
                                    .value.frostBackgroundColor.value),
                            child: Text(
                                '${(target.value * 100).toStringAsFixed(0)} / 100',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: screenSize.width * 0.025)),
                          ),
                          Text('Tabs',
                              style: TextStyle(
                                  color: controller.mainController.currentTheme
                                      .value.textColor.value,
                                  fontSize: screenSize.width * 0.028))
                        ],
                      ),
                    ),
                    SizedBox(
                      width: screenSize.width * 0.6,
                      child: Text('The tap history details can be viewed.',
                          style: TextStyle(
                              color: controller.mainController.currentTheme
                                  .value.textColor.value,
                              fontSize: screenSize.width * 0.025)),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 5),
                      margin: const EdgeInsets.only(top: 3),
                      decoration: BoxDecoration(
                          borderRadius: const BorderRadius.all(Radius.circular(5)),
                          border: Border.all(
                              color: controller.mainController.currentTheme
                                  .value.textColor.value
                                  .withOpacity(0.5)),
                          color: Colors.white),
                      child: Text('View Tab Details',
                          style: TextStyle(
                              color: controller.mainController.currentTheme
                                  .value.textColor.value,
                              fontSize: screenSize.width * 0.025)),
                    )
                  ],
                ),
                Expanded(
                    child: Container(
                        alignment: Alignment.center,
                        child: Column(
                          children: [
                            Stack(alignment: Alignment.center, children: [
                              SizedBox(
                                width: screenSize.height * 0.1,
                                height: screenSize.height * 0.1,
                                child: AnimatedBuilder(
                                    animation: animationController,
                                    builder: (context, widget) {
                                      return CircularProgressIndicator(
                                        valueColor:
                                            const AlwaysStoppedAnimation<Color>(
                                                Color.fromARGB(
                                                    255, 255, 121, 37)),
                                        strokeWidth: 6,
                                        strokeCap: StrokeCap.round,
                                        backgroundColor:
                                            const Color.fromARGB(255, 217, 217, 217),
                                        value: animation.value,
                                      );
                                    }),
                              ),
                              limitExceeded
                                  ? Text('!',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: const Color.fromARGB(
                                              255, 186, 27, 27),
                                          fontSize: screenSize.width * 0.1))
                                  : Column(
                                      children: [
                                        Text('Today',
                                            style: TextStyle(
                                                color: controller
                                                    .mainController
                                                    .currentTheme
                                                    .value
                                                    .textColor
                                                    .value,
                                                fontWeight: FontWeight.bold,
                                                fontSize:
                                                    screenSize.width * 0.023)),
                                        Text(
                                            (tabsToday.value * 100)
                                                .toStringAsFixed(0),
                                            style: TextStyle(
                                                color: const Color.fromARGB(
                                                    255, 255, 121, 37),
                                                fontWeight: FontWeight.bold,
                                                fontSize:
                                                    screenSize.width * 0.04)),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Text(
                                                '${(target.value * 100).toStringAsFixed(0)} / ',
                                                style: TextStyle(
                                                    color: controller
                                                        .mainController
                                                        .currentTheme
                                                        .value
                                                        .textColor
                                                        .value,
                                                    fontSize: screenSize.width *
                                                        0.025)),
                                            Text('100',
                                                style: TextStyle(
                                                    color: controller
                                                        .mainController
                                                        .currentTheme
                                                        .value
                                                        .textColor
                                                        .value,
                                                    fontSize: screenSize.width *
                                                        0.022))
                                          ],
                                        ),
                                      ],
                                    )
                            ]),
                            Container(
                              margin: const EdgeInsets.only(top: 10),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text('Last 24 hours / ',
                                      style: TextStyle(
                                          color: controller
                                              .mainController
                                              .currentTheme
                                              .value
                                              .textColor
                                              .value,
                                          fontSize: screenSize.width * 0.025)),
                                  Text('total tabs',
                                      style: TextStyle(
                                          color: controller
                                              .mainController
                                              .currentTheme
                                              .value
                                              .textColor
                                              .value,
                                          fontSize: screenSize.width * 0.025))
                                ],
                              ),
                            )
                          ],
                        )))
              ],
            ),
          )
        ],
      ),
    );
  }
}

class UserDetailsBloodAndPhoneSection
    extends GetWidget<UserDetailsPageController> {
  const UserDetailsBloodAndPhoneSection({super.key});

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.sizeOf(context);
    return Container(
      width: screenSize.width,
      padding: const EdgeInsets.symmetric(vertical: 10),
      margin: const EdgeInsets.only(top: 10, left: 15, right: 15),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: List.generate(
          2,
          (index) => Expanded(
              child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 10),
            height: screenSize.height * 0.22,
            child: CustomPaint(
              painter: ShieldPainter(
                  bgColor: [
                Colors.white,
                const Color.fromARGB(255, 229, 238, 98)
              ][index]),
              child: Container(
                padding: const EdgeInsets.all(10),
                margin:
                    EdgeInsets.fromLTRB(10, 15, 10, screenSize.height * 0.05),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: const EdgeInsets.only(bottom: 10),
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                          color: [
                            const Color.fromARGB(255, 229, 238, 98),
                            Colors.white
                          ][index],
                          borderRadius:
                              const BorderRadius.all(Radius.circular(500))),
                      child: SvgPicture.asset(
                          [
                            'assets/icons/blood-icon.svg',
                            'assets/icons/phone-icon.svg'
                          ][index],
                          fit: BoxFit.contain,
                          height: screenSize.height * 0.035,
                          width: screenSize.height * 0.035),
                    ),
                    Container(
                      margin: const EdgeInsets.only(left: 5),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(['Blood Type', 'Phone'][index],
                              style: TextStyle(
                                  color: controller.mainController.currentTheme
                                      .value.textColor.value
                                      .withOpacity(0.7),
                                  fontSize: screenSize.width * 0.03)),
                          Text(
                              [
                                '${controller.userData['bloodGroup'].toString()[0]} ${controller.mainController.user['bloodGroup'].toString()[1] == '+' ? 'positive' : 'negative'}',
                                controller.userData['phone'].toString()
                              ][index],
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: controller.mainController.currentTheme
                                      .value.textColor.value
                                      .withOpacity(0.6),
                                  fontSize: screenSize.width * 0.04)),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          )),
        ),
      ),
    );
  }
}

class UserDetailsGeneralDetailsSection
    extends GetWidget<UserDetailsPageController> {
  const UserDetailsGeneralDetailsSection({super.key});

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.sizeOf(context);
    return Container(
      margin: const EdgeInsets.only(top: 15),
      width: screenSize.width,
      child: Column(
        children: List.generate(
            7,
            (index) => Container(
                margin:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                child: index == 1
                    ? Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: List.generate(
                            3,
                            (index) => index == 1
                                ? Container(
                                    height: screenSize.height * 0.05,
                                    width: 2,
                                    alignment: Alignment.center,
                                    margin: const EdgeInsets.only(right: 15),
                                    decoration: const BoxDecoration(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(15)),
                                      color: Colors.grey,
                                    ),
                                  )
                                : Expanded(
                                    child: Container(
                                      margin: index == 0
                                          ? const EdgeInsets.only(right: 5)
                                          : null,
                                      child: GoogleLoginStyleInputButton(
                                          hintText: [
                                            controller
                                                .mainController.user['age']
                                                .toString(),
                                            "",
                                            formatDate(controller.mainController
                                                .user['dateOfBirth'])
                                          ][index],
                                          placeHolder: [
                                            'Age',
                                            "",
                                            "Date Of Birth"
                                          ][index]),
                                    ),
                                  )),
                      )
                    : GoogleLoginStyleInputButton(
                        maxLines: [6, 7].contains(index) ? 3 : null,
                        hintText: index == 2
                            ? formatDate(
                                controller.mainController.user['dateOfBirth'])
                            : controller
                                .mainController
                                .user[[
                                "name",
                                "placeholder dont take in account",
                                "bloodGroup",
                                "profession",
                                "email",
                                "phone",
                                "address",
                              ][index]]
                                .toString(),
                        placeHolder: [
                          'Name',
                          "place holder dont take in account",
                          "Blood Group",
                          "Profession",
                          "Email",
                          "Phone",
                          "Address",
                        ][index]))),
      ),
    );
  }
}

class UserDetailsContactsSection extends GetWidget<UserDetailsPageController> {
  const UserDetailsContactsSection({super.key});

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.sizeOf(context);
    RxInt contactIndex = 0.obs;
    return FrostedBackground(
        borderRadius: 15,
        child: Container(
          padding: const EdgeInsets.all(10),
          width: screenSize.width,
          margin: const EdgeInsets.only(left: 15, right: 15, bottom: 20),
          decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                        offset: const Offset(0, 4),
                        color: Colors.grey.shade300,
                        blurRadius: 3)
                    .scale(3)
              ],
              borderRadius: const BorderRadius.all(Radius.circular(15))),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: const EdgeInsets.all(5),
                child: Text('Contacts',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: controller
                            .mainController.currentTheme.value.textColor.value
                            .withOpacity(0.7),
                        fontSize: screenSize.width * 0.038)),
              ),
              Container(
                padding: const EdgeInsets.all(5),
                margin: const EdgeInsets.only(top: 10),
                decoration: BoxDecoration(
                    color: Colors.grey.shade100,
                    borderRadius: const BorderRadius.all(Radius.circular(5))),
                child: Row(
                  children: List.generate(
                      2,
                      (index) => Obx(() => Expanded(
                              child: InkResponse(
                            onTap: () => contactIndex.value = index,
                            child: AnimatedContainer(
                              duration: const Duration(milliseconds: 250),
                              alignment: Alignment.center,
                              padding: const EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                  color: index == contactIndex.value
                                      ? Colors.white
                                      : Colors.grey.shade100,
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(5))),
                              child: Text(['Family', 'Doctors'][index],
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: contactIndex.value == index
                                          ? controller
                                              .mainController
                                              .currentTheme
                                              .value
                                              .textColor
                                              .value
                                          : controller
                                              .mainController
                                              .currentTheme
                                              .value
                                              .textColor
                                              .value
                                              .withOpacity(0.6),
                                      fontSize: screenSize.width * 0.028)),
                            ),
                          )))),
                ),
              ),
              Obx(() {
                final count = contactIndex.value == 0
                    ? controller.userData['contacts'].length
                    : controller.userData['consultedDoctors'].length;

                final data = contactIndex.value == 0
                    ? controller.mainController.user['contacts']
                    : controller.mainController.user['consultedDoctors'];
                
                return GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: 15,
                      childAspectRatio: 0.95,
                      crossAxisSpacing: 15),
                  itemCount: count,
                  itemBuilder: (context, index) => Stack(
                    alignment: Alignment.topCenter,
                    children: [
                      CircleAvatar(
                        radius: screenSize.width * 0.18,
                        backgroundImage: data.elementAt(index)['imageUrl'] != null ?
                            NetworkImage(data.elementAt(index)['imageUrl']) : null,
                      ),
                      Positioned(
                        bottom: 0,
                        left: 5,
                        right: 5,
                        child: FrostedBackground(
                          borderRadius: 8,
                          child: Container(
                            width: screenSize.width,
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                                color: controller.mainController.currentTheme
                                    .value.frostBackgroundColor.value,
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(8))),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  margin: const EdgeInsets.only(bottom: 3),
                                  child: Text(data.elementAt(index)['name'],
                                      style: TextStyle(
                                          overflow: TextOverflow.ellipsis,
                                          fontWeight: FontWeight.bold,
                                          color: controller.isLight.value
                                              ? Colors.white
                                              : Colors.black,
                                          fontSize: screenSize.width * 0.035)),
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Container(
                                      padding: const EdgeInsets.all(5),
                                      decoration: const BoxDecoration(
                                          color: Colors.white,
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(500))),
                                      child: SvgPicture.asset(
                                          'assets/icons/phone-icon.svg',
                                          fit: BoxFit.contain,
                                          height: screenSize.height * 0.02,
                                          width: screenSize.height * 0.02),
                                    ),
                                    Text(data.elementAt(index)['phone'],
                                        style: TextStyle(
                                            overflow: TextOverflow.ellipsis,
                                            fontWeight: FontWeight.bold,
                                            color: controller.isLight.value
                                                ? Colors.white
                                                : Colors.black,
                                            fontSize:
                                                screenSize.width * 0.035)),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                );
              })
            ],
          ),
        ));
  }
}

class UserDetailsReportSection extends GetWidget<UserDetailsPageController> {
  const UserDetailsReportSection({super.key});

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.sizeOf(context);
    return Container(
      margin: const EdgeInsets.only(top: 10, left: 10, right: 10, bottom: 20),
      width: screenSize.width,
      child: Column(
        children: [
          Row(
            children: [
              Container(
                margin: const EdgeInsets.only(right: 10, left: 5),
                child: SvgPicture.asset(
                  'assets/icons/folder-icon.svg',
                  height: screenSize.width * 0.06,
                  width: screenSize.width * 0.06,
                ),
              ),
              Text('Documents',
                  style: TextStyle(
                      color: controller
                          .mainController.currentTheme.value.textColor.value,
                      fontSize: screenSize.width * 0.05)),
            ],
          ),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 15),
            child: GridView.builder(
                shrinkWrap: true,
                itemCount: controller
                    .mainController.user['medicalInfo']['reports'].length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    childAspectRatio: 1.2,
                    crossAxisCount: 2,
                    mainAxisSpacing: 15,
                    crossAxisSpacing: 15),
                itemBuilder: (context, index) {
                  RxBool openMenu = false.obs;
                  return Stack(
                    alignment: Alignment.topRight,
                    children: [
                      CustomPaint(
                          painter: FileShapePainter(
                              borderColor: controller.mainController
                                  .currentTheme.value.textColor.value
                                  .withOpacity(0.5)),
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                vertical: 10, horizontal: 15),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  margin:
                                      const EdgeInsets.symmetric(vertical: 10),
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Container(
                                        padding: const EdgeInsets.all(8),
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                const BorderRadius.all(
                                                    Radius.circular(5)),
                                            color: Colors.white,
                                            boxShadow: [
                                              BoxShadow(
                                                      blurRadius: 3,
                                                      color:
                                                          Colors.grey.shade300)
                                                  .scale(3)
                                            ]),
                                        child: SvgPicture.asset(
                                          'assets/icons/pdf-icon.svg',
                                          height: screenSize.width * 0.05,
                                          width: screenSize.width * 0.05,
                                        ),
                                      ),
                                      InkResponse(
                                        onTap: () =>
                                            openMenu.value = !openMenu.value,
                                        child: const Icon(Icons.more_horiz),
                                      )
                                    ],
                                  ),
                                ),
                                Container(
                                  margin: const EdgeInsets.only(top: 5),
                                  child: Text(
                                      controller.mainController
                                              .user['medicalInfo']['reports']
                                          [index]['reportTitle'],
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: controller
                                              .mainController
                                              .currentTheme
                                              .value
                                              .textColor
                                              .value,
                                          fontSize: screenSize.width * 0.03)),
                                ),
                                Container(
                                  margin: const EdgeInsets.only(top: 5),
                                  child: Text(
                                      'Uploaded on\n${formatDate(controller.mainController.user['medicalInfo']['reports'][index]['uploadedOn'])}',
                                      style: TextStyle(
                                          color: controller
                                              .mainController
                                              .currentTheme
                                              .value
                                              .textColor
                                              .value
                                              .withOpacity(0.6),
                                          fontSize: screenSize.width * 0.028)),
                                ),
                              ],
                            ),
                          )),
                      Positioned(
                        top: 50,
                        right: 15,
                        child: FrostedBackground(
                          borderRadius: 5,
                          child: Obx(
                            () => AnimatedSize(
                              reverseDuration: const Duration(microseconds: 0),
                              duration: const Duration(milliseconds: 250),
                              child: Container(
                                height: openMenu.value ? null : 0,
                                width: openMenu.value ? null : 0,
                                padding: const EdgeInsets.all(15),
                                decoration: BoxDecoration(
                                    color: controller
                                        .mainController
                                        .currentTheme
                                        .value
                                        .frostBackgroundColor
                                        .value),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: List.generate(
                                      2,
                                      (innerIndex) => InkResponse(
                                            onTap: () => Get.toNamed(
                                                '/document-page',
                                                arguments: {
                                                  'documentName':
                                                      controller.mainController
                                                                      .user[
                                                                  'medicalInfo']
                                                              ['reports'][index]
                                                          ['reportTitle'],
                                                  'documentUrl':
                                                      controller.mainController
                                                                      .user[
                                                                  'medicalInfo']
                                                              ['reports'][index]
                                                          ['reportDocument']
                                                }),
                                            child: Text(
                                                [
                                                  'View Document',
                                                  'Download'
                                                ][innerIndex],
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    height:
                                                        index == 0 ? 2 : null,
                                                    color:
                                                        controller.isLight.value
                                                            ? Colors.white
                                                            : null,
                                                    fontSize: screenSize.width *
                                                        0.032)),
                                          )),
                                ),
                              ),
                            ),
                          ),
                        ),
                      )
                    ],
                  );
                }),
          )
        ],
      ),
    );
  }
}

class UserDetailsHealthIssuesSection
    extends GetWidget<UserDetailsPageController> {
  const UserDetailsHealthIssuesSection({super.key});

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.sizeOf(context);
    return Container(
      margin: const EdgeInsets.only(top: 10, left: 10, right: 10, bottom: 20),
      width: screenSize.width,
      child: Column(
        children: [
          Row(
            children: [
              Container(
                margin: const EdgeInsets.only(right: 10, left: 5),
                child: SvgPicture.asset(
                  'assets/icons/health-icon.svg',
                  height: screenSize.width * 0.06,
                  width: screenSize.width * 0.06,
                ),
              ),
              Text('Health Issues',
                  style: TextStyle(
                      color: controller
                          .mainController.currentTheme.value.textColor.value,
                      fontSize: screenSize.width * 0.05)),
              Container(
                margin: const EdgeInsets.only(top: 15),
                child: Column(
                  children: List.generate(
                      controller.mainController.user['medicalInfo']['issues']
                          .length, (index) {
                    return Container();
                  }),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}

class GoogleLoginStyleInputButton extends GetWidget<UserDetailsPageController> {
  GoogleLoginStyleInputButton(
      {super.key,
      required this.hintText,
      required this.placeHolder,
      this.keepShadow = true,
      this.maxLines});

  String hintText, placeHolder;
  int? maxLines;
  bool keepShadow;

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.sizeOf(context);
    return Stack(
      alignment: Alignment.topLeft,
      clipBehavior: Clip.none,
      children: [
        Obx(
          () => AnimatedContainer(
            duration: const Duration(milliseconds: 250),
            padding: EdgeInsets.only(
                top: controller.editGeneralDetails.value ? 0 : 20),
            decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(Radius.circular(10)),
                boxShadow: keepShadow
                    ? [
                        BoxShadow(
                          color: Colors.grey.shade300,
                          blurRadius: 5,
                          offset: const Offset(0, 5),
                        ),
                        BoxShadow(
                          color: Colors.grey.shade100,
                          offset: const Offset(-5, 0),
                        )
                      ]
                    : null),
            child: TextField(
              maxLines: maxLines,
              decoration: InputDecoration(
                  contentPadding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  border: const OutlineInputBorder(borderSide: BorderSide.none),
                  hintText: hintText,
                  hintStyle: TextStyle(
                    color: controller
                        .mainController.currentTheme.value.textColor.value
                        .withOpacity(0.5),
                    fontWeight: FontWeight.w600,
                  )),
            ),
          ),
        ),
        Obx(
          () => AnimatedPositioned(
            duration: const Duration(milliseconds: 250),
            left: 10,
            top: controller.editGeneralDetails.value ? -12 : 10,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: AnimatedDefaultTextStyle(
                  duration: const Duration(milliseconds: 250),
                  style: TextStyle(
                      color: controller
                          .mainController.currentTheme.value.textColor.value
                          .withOpacity(0.5),
                      fontSize: controller.editGeneralDetails.value
                          ? screenSize.width * 0.038
                          : screenSize.width * 0.035),
                  child: Text(placeHolder)),
            ),
          ),
        ),
      ],
    );
  }
}

class FileShapePainter extends CustomPainter {
  FileShapePainter({required this.borderColor});

  Color borderColor;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill;

    final borderPaint = Paint()
      ..color = borderColor.withOpacity(0.15)
      ..strokeWidth = 1.2
      ..style = PaintingStyle.fill;

    final path = Path();

    //left line
    path.moveTo(0, 4);
    path.lineTo(0, size.height - 9);

    //bottomleft corner
    path.quadraticBezierTo(0, size.height, 9, size.height);

    //bottom line
    path.lineTo(size.width - 9, size.height);

    //bottom right corner
    path.quadraticBezierTo(
        size.width, size.height, size.width, size.height - 10);

    //right line
    path.lineTo(size.width, ((size.height) / 4) - 10);

    //top right corners

    //cross line
    path.lineTo((size.width * 3 / 4) + 20, 0);

    //top line
    path.lineTo(9, 0);

    //topleft corner
    path.quadraticBezierTo(0, 0, 0, 9);
    canvas.drawShadow(path, borderColor, 1, false);

    canvas.drawPath(path, paint);

    //border

    final borderPath = Path();

    borderPath.moveTo(0, 5);
    borderPath.quadraticBezierTo(0, 0, 5, 0);

    borderPath.moveTo(0, size.height - 5);
    borderPath.quadraticBezierTo(0, size.height, 5, size.height);

    borderPath.moveTo(size.width - 5, size.height);
    borderPath.quadraticBezierTo(
        size.width, size.height, size.width, size.height - 5);

    canvas.drawLine(
        const Offset(0, 4), Offset(0, size.height - 4), borderPaint);

    canvas.drawLine(Offset(4, size.height), Offset(size.width - 4, size.height),
        borderPaint);

    canvas.drawLine(Offset(size.width, size.height - 4),
        Offset(size.width, ((size.height) / 4) - 10), borderPaint);

    canvas.drawLine(Offset(size.width, ((size.height) / 4) - 10),
        Offset((size.width * 3 / 4) + 20, 0), borderPaint);

    canvas.drawLine(
        Offset((size.width * 3 / 4) + 20, 0), const Offset(4, 0), borderPaint);

    canvas.drawPath(borderPath, borderPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class ShieldPainter extends CustomPainter {
  ShieldPainter({required this.bgColor});

  Color bgColor;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = bgColor;
    final path = Path();

    path.moveTo(size.width * 0.15, 0);

    //top line
    path.lineTo(size.width * 0.85, 0);

    //topright curve
    path.quadraticBezierTo(size.width, 0, size.width, size.height * 0.15);

    //right line
    path.lineTo(size.width, size.height * 0.70);

    //bottomright curve
    path.quadraticBezierTo(
        size.width, size.height * 0.75, size.width * 0.95, size.height * 0.79);

    //bottom right diagonal line
    path.lineTo(size.width * 0.53, size.height * 0.95);

    //bottom center curve
    path.quadraticBezierTo(size.width * 0.5, size.height * 0.96,
        size.width * 0.48, size.height * 0.95);

    //bottom left diagonal line
    path.lineTo(size.width * 0.05, size.height * 0.79);

    //bottom left curve
    path.quadraticBezierTo(0, size.height * 0.75, 0, size.height * 0.7);

    //left line
    path.lineTo(0, size.height * 0.15);

    //topleft curve
    path.quadraticBezierTo(0, 0, size.width * 0.15, 0);

    //draw path
    path.close();
    canvas.drawShadow(path, const Color.fromARGB(164, 238, 238, 238), 5, true);
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    // TODO: implement shouldRepaint
    return false;
  }
}

class DoodlePainter extends CustomPainter {
  DoodlePainter(
      {required this.evenColumnMultiplier, required this.oddColumnMultiplier});

  double evenColumnMultiplier, oddColumnMultiplier;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = Colors.grey;

    const horizontalSections = 17;
    const verticalSections = 20;

    List coordinates = [];

    final verticalSpacing = size.height / verticalSections,
        horizontalSpacing = size.width / horizontalSections;

    for (int verticalCounter = 0;
        verticalCounter <= verticalSections;
        verticalCounter++) {
      for (int horizontalCounter = 0;
          horizontalCounter <= horizontalSections;
          horizontalCounter++) {
        if (horizontalCounter % 2 == 0) {
          coordinates.add(Offset(
              horizontalSpacing * horizontalCounter,
              (verticalSpacing * verticalCounter) +
                  verticalSpacing * evenColumnMultiplier));
          continue;
        }
        coordinates.add(Offset(
            horizontalSpacing * horizontalCounter,
            (verticalSpacing * verticalCounter) +
                verticalSpacing * oddColumnMultiplier));
      }
    }

    for (var coordinate in coordinates) {
      canvas.drawCircle(coordinate, size.width * 0.005, paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    // TODO: implement shouldRepaint
    return true;
  }
}

class DoodleAnimator extends StatefulWidget {
  const DoodleAnimator({super.key});

  @override
  State<DoodleAnimator> createState() => _DoodleAnimatorState();
}

class _DoodleAnimatorState extends State<DoodleAnimator>
    with TickerProviderStateMixin {
  late AnimationController animationController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    animationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 800));
    animationController.addStatusListener((status) {
      if (status == AnimationStatus.completed) animationController.reverse();
      if (status == AnimationStatus.dismissed) animationController.forward();
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    animationController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Future.delayed(
        const Duration(seconds: 1), () => animationController.forward());
    return DoodleRunner(listenable: animationController);
  }
}

class DoodleRunner extends AnimatedWidget {
  DoodleRunner({super.key, required super.listenable});

  static final evenColumnAnimation = Tween<double>(begin: 0.5, end: 0.0);
  static final oddColumnAnimation = Tween<double>(begin: 0.0, end: 0.5);

  @override
  Widget build(BuildContext context) {
    final animation = listenable as Animation<double>;
    return CustomPaint(
      painter: DoodlePainter(
          evenColumnMultiplier: evenColumnAnimation.evaluate(animation),
          oddColumnMultiplier: oddColumnAnimation.evaluate(animation)),
    );
  }
}
