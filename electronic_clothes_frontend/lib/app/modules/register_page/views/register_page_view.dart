import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:electronic_clothes_frontend/app/modules/medical_reports_page/views/medical_reports_page_view.dart';
import 'package:electronic_clothes_frontend/main.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_holo_date_picker/date_picker.dart';
import 'package:flutter_holo_date_picker/flutter_holo_date_picker.dart';
import 'package:flutter_svg/svg.dart';

import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:infinite_carousel/infinite_carousel.dart';
import 'package:lottie/lottie.dart';
import 'package:numberpicker/numberpicker.dart';

import '../controllers/register_page_controller.dart';

//top padding is defined by individual widgets and not the main container

class RegisterPageView extends GetView<RegisterPageController> {
  const RegisterPageView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RegisterPageHeroImageSection(),
    );
  }
}

class RegisterPageHeroImageSection extends GetWidget<RegisterPageController> {
  const RegisterPageHeroImageSection({super.key});

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.sizeOf(context);
    final enables = [false.obs, false.obs, false.obs, false.obs, false.obs];

    for (var index = 0; index < enables.length; index++) {
      if (index == 3 || index == 4) {
        Future.delayed(Duration(milliseconds: 1500 * index),
            () => enables[index].value = true);
        continue;
      }
      Future.delayed(Duration(milliseconds: 1200 * index),
          () => enables[index].value = true);
    }
    RxString data = ''.obs;

    return Container(
      decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage('assets/images/register-hero-2.jpg'),
              fit: BoxFit.cover)),
      height: screenSize.height,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Obx(() => Text(data.value)),
          Obx(
            () => AnimatedOpacity(
              duration: const Duration(milliseconds: 500),
              opacity: enables[0].value ? 1.0 : 0.0,
              child: Container(
                margin: EdgeInsets.only(top: screenSize.height * 0.15),
                child: Text('Wearable Wellness,',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: screenSize.width * .08, color: Colors.white)),
              ),
            ),
          ),
          Obx(() => AnimatedOpacity(
              duration: const Duration(milliseconds: 500),
              opacity: enables[1].value ? 1.0 : 0.0,
              child: Text('Wearable Wisdom.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: screenSize.width * .08, color: Colors.white)))),
          Container(
            margin: EdgeInsets.only(top: screenSize.height * 0.3),
            child: Column(
              children: [
                Obx(() => AnimatedOpacity(
                    duration: const Duration(milliseconds: 500),
                    opacity: enables[2].value ? 1.0 : 0.0,
                    child: Text('That is',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: screenSize.width * .08,
                            color: Colors.white)))),
                Obx(() => AnimatedOpacity(
                    duration: const Duration(milliseconds: 500),
                    opacity: enables[3].value ? 1.0 : 0.0,
                    child: Text('Soulious',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            height: 1,
                            fontSize: screenSize.width * .13,
                            color: Colors.white)))),
                Obx(() => AnimatedOpacity(
                    duration: const Duration(milliseconds: 500),
                    opacity: enables[4].value ? 1.0 : 0.0,
                    child: Container(
                        margin: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 15),
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.white, width: 2.5),
                            borderRadius:
                                const BorderRadius.all(Radius.circular(18)),
                            color: Colors.grey.shade300),
                        width: screenSize.width,
                        child: Row(
                          children: List.generate(
                            2,
                            (index) => Expanded(
                                child: InkResponse(
                              onTap: () {
                                index == 0
                                    ? Get.to(() => RegisterSection())
                                    : Get.to(() => const LoginSection());
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(15)),
                                    color: index == 0 ? Colors.white : null),
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 15, vertical: 18),
                                child: Text(['Register', 'Login'][index],
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontSize: screenSize.width * .04)),
                              ),
                            )),
                          ),
                        ))))
              ],
            ),
          )
        ],
      ),
    );
  }
}

class LoginSection extends GetView<RegisterPageController> {
  const LoginSection({super.key});

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.sizeOf(context);
    Future.delayed(
        const Duration(milliseconds: 1500), () => controller.fadeInItems());
    return Scaffold(
        body: SizedBox(
      height: screenSize.height,
      width: screenSize.width,
      child: SingleChildScrollView(
          child: SizedBox(
              height: screenSize.height,
              width: screenSize.width,
              child: Stack(alignment: Alignment.center, children: [
                SizedBox(
                    width: screenSize.width,
                    height: screenSize.height,
                    child: Lottie.asset(
                        'assets/animations/gradient-background-animation.json',
                        fit: BoxFit.cover)),
                FadeInOutWidget(
                  enable: controller.widgetEnable,
                  bottomPositionMultiplier: 0.09,
                  height: screenSize.height * 0.18,
                  margin: const EdgeInsets.symmetric(horizontal: 30),
                  child: Wiggle(
                      height: screenSize.height * 0.25,
                      trigger: controller.wiggle,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          TextField(
                            controller:
                                RegisterPageController.loginEmailController,
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                                color: Colors.black87,
                                fontWeight: FontWeight.bold),
                            decoration: const InputDecoration(
                                filled: true,
                                fillColor: Colors.white,
                                border: OutlineInputBorder(
                                    borderSide: BorderSide.none,
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10))),
                                hintStyle:
                                    TextStyle(fontWeight: FontWeight.normal),
                                contentPadding: EdgeInsets.all(10),
                                hintText: 'Email'),
                          ),
                          Container(
                            margin: const EdgeInsets.only(top: 20),
                            child: TextField(
                              controller: RegisterPageController.loginPassword,
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                  color: Colors.black87,
                                  fontWeight: FontWeight.bold),
                              decoration: const InputDecoration(
                                  filled: true,
                                  fillColor: Colors.white,
                                  border: OutlineInputBorder(
                                      borderSide: BorderSide.none,
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(10))),
                                  hintStyle:
                                      TextStyle(fontWeight: FontWeight.normal),
                                  contentPadding: EdgeInsets.all(10),
                                  hintText: 'Password'),
                            ),
                          )
                        ],
                      )),
                ),
                FadeInOutWidget(
                    bottomPositionMultiplier: 0.05,
                    enable: controller.titleEnable,
                    child: Text('Please login to continue'.toString(),
                        style: TextStyle(fontSize: screenSize.width * 0.04))),
                FadeInOutWidget(
                    bottomPositionMultiplier: 0.01,
                    enable: controller.subtitleEnable,
                    child: Text('Login to continue exploring Soulious',
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: screenSize.width * 0.04))),
                FadeInOutWidget(
                  bottomPositionMultiplier: -0.05,
                  enable: controller.captionEnable,
                  height: screenSize.height * 0.7,
                  margin: const EdgeInsets.only(left: 20, right: 20),
                  child: SizedBox(
                    width: screenSize.width,
                    child: ElevatedButton(
                      onPressed: () async {
                        if ([
                          RegisterPageController.loginEmailController,
                          RegisterPageController.loginPassword
                        ][controller.contentIndex.value]
                            .text
                            .isEmpty) {
                          controller.wiggle.value = true;
                          controller.wiggle.update((value) {});
                          return;
                        } else {
                          await controller.login();
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xff6c5aee),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 12),
                      ),
                      child: Text(
                        'Login',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
              ]))),
    ));
  }
}

class RegisterSection extends StatefulWidget {
  RegisterSection({super.key});

  @override
  State<RegisterSection> createState() => _RegisterSectionState();
}

class _RegisterSectionState extends State<RegisterSection> {
  final controller = Get.find<RegisterPageController>();

  late Rx<Widget> widgetThatAppear;

  final registerData = {
    0: {
      'title': 'What shall we call you?',
      'subtitle': 'fill in your general details.',
      'category': 'name',
      'widget': TextField(
        controller: RegisterPageController.nameController,
        textAlign: TextAlign.center,
        style:
            const TextStyle(color: Colors.black87, fontWeight: FontWeight.bold),
        decoration: const InputDecoration(
            filled: true,
            fillColor: Colors.white,
            border: OutlineInputBorder(
                borderSide: BorderSide.none,
                borderRadius: BorderRadius.all(Radius.circular(10))),
            contentPadding: EdgeInsets.all(10),
            hintStyle: TextStyle(fontWeight: FontWeight.normal),
            hintText: 'Name'),
      )
    },
    1: {
      'title': 'How old are you?',
      'subtitle': 'Enter your age.',
      'category': 'age',
      'widget': Obx(() => NumberPicker(
          minValue: 3,
          maxValue: 120,
          axis: Axis.horizontal,
          value: RegisterPageController.age.value,
          onChanged: (value) {
            RegisterPageController.age.value = value;
          }))
    },
    2: {
      'title': 'When is that special date?',
      'subtitle': 'Tell us your date of birth.',
      'category': 'bio',
      'widget': DatePickerWidget(
        dateFormat: "dd/MMMM/yyyy",
        pickerTheme:
            const DateTimePickerTheme(backgroundColor: Colors.transparent),
        initialDate: DateTime.now(),
        lastDate: DateTime.now(),
        onChange: (dateTime, selectedIndex) =>
            RegisterPageController.dob.value = dateTime,
      )
    },
    3: {
      'title': 'Tell us a bit about yourself.',
      'subtitle': 'Write a short bio.',
      'category': 'bio',
      'widget': TextField(
        controller: RegisterPageController.bioController,
        textAlign: TextAlign.center,
        maxLines: 3,
        style:
            const TextStyle(color: Colors.black87, fontWeight: FontWeight.bold),
        decoration: const InputDecoration(
            filled: true,
            fillColor: Colors.white,
            border: OutlineInputBorder(
                borderSide: BorderSide.none,
                borderRadius: BorderRadius.all(Radius.circular(10))),
            hintStyle: TextStyle(fontWeight: FontWeight.normal),
            contentPadding: EdgeInsets.all(10),
            hintText: 'Bio'),
      )
    },
    4: {
      'title': 'What do you do for a living?',
      'subtitle': 'Enter your profession.',
      'category': 'profession',
      'widget': TextField(
        controller: RegisterPageController.professionController,
        textAlign: TextAlign.center,
        style:
            const TextStyle(color: Colors.black87, fontWeight: FontWeight.bold),
        decoration: const InputDecoration(
            filled: true,
            fillColor: Colors.white,
            border: OutlineInputBorder(
                borderSide: BorderSide.none,
                borderRadius: BorderRadius.all(Radius.circular(10))),
            hintStyle: TextStyle(fontWeight: FontWeight.normal),
            contentPadding: EdgeInsets.all(10),
            hintText: 'Profession'),
      )
    },
    5: {
      'title': 'How can we reach you?',
      'subtitle': 'Enter your phone number.',
      'category': 'phone',
      'widget': TextField(
        controller: RegisterPageController.phoneController,
        textAlign: TextAlign.center,
        style:
            const TextStyle(color: Colors.black87, fontWeight: FontWeight.bold),
        decoration: const InputDecoration(
            filled: true,
            fillColor: Colors.white,
            border: OutlineInputBorder(
                borderSide: BorderSide.none,
                borderRadius: BorderRadius.all(Radius.circular(10))),
            hintStyle: TextStyle(fontWeight: FontWeight.normal),
            contentPadding: EdgeInsets.all(10),
            hintText: 'Phone'),
      )
    },
    6: {
      'title': 'How can we mail you?',
      'subtitle': 'Enter your email address.',
      'category': 'phone',
      'widget': TextField(
        controller: RegisterPageController.emailController,
        textAlign: TextAlign.center,
        style:
            const TextStyle(color: Colors.black87, fontWeight: FontWeight.bold),
        decoration: const InputDecoration(
            filled: true,
            fillColor: Colors.white,
            border: OutlineInputBorder(
                borderSide: BorderSide.none,
                borderRadius: BorderRadius.all(Radius.circular(10))),
            hintStyle: TextStyle(fontWeight: FontWeight.normal),
            contentPadding: EdgeInsets.all(10),
            hintText: 'Email address'),
      )
    },
    7: {
      'title': 'Where is your house?',
      'subtitle': 'Tell us your address, it will be useful in some cases.',
      'category': 'phone',
      'widget': TextField(
        maxLines: 5,
        controller: RegisterPageController.addressController,
        textAlign: TextAlign.center,
        style:
            const TextStyle(color: Colors.black87, fontWeight: FontWeight.bold),
        decoration: const InputDecoration(
            filled: true,
            fillColor: Colors.white,
            border: OutlineInputBorder(
                borderSide: BorderSide.none,
                borderRadius: BorderRadius.all(Radius.circular(10))),
            hintStyle: TextStyle(fontWeight: FontWeight.normal),
            contentPadding: EdgeInsets.all(10),
            hintText: 'Address'),
      )
    },
    8: {
      'title': 'What is your blood type?',
      'subtitle': 'Tell your blood group, it will be useful in some cases.',
      'category': 'phone',
    },
    9: {
      'title': 'Show us your looks!',
      'subtitle': 'Upload a profile picture or leave empty.',
      'category': 'phone',
    },
    10: {
      'title': 'Who are your friends and family?',
      'subtitle': 'Add some contacts in handy.',
      'category': 'phone',
    },
    11: {
      'title': 'Tell us about your medical conditions.',
      'subtitle': 'Add some medical reports in handy.',
      'category': 'phone',
    },
    12: {
      'title': 'Tell us about your favourite doctors.',
      'subtitle': 'Add the doctors you frequently consult with.',
      'category': 'phone',
    },
    13: {
      'title': 'Set a password.',
      'subtitle': 'Make all your information secure',
      'category': 'phone',
      'widget': Column(children: [
        TextField(
          controller: RegisterPageController.password,
          textAlign: TextAlign.center,
          style: const TextStyle(
              color: Colors.black87, fontWeight: FontWeight.bold),
          decoration: const InputDecoration(
              filled: true,
              fillColor: Colors.white,
              border: OutlineInputBorder(
                  borderSide: BorderSide.none,
                  borderRadius: BorderRadius.all(Radius.circular(10))),
              hintStyle: TextStyle(fontWeight: FontWeight.normal),
              contentPadding: EdgeInsets.all(10),
              hintText: 'Password'),
        ),
        Container(
          margin: const EdgeInsets.only(top: 20),
          child: TextField(
            controller: RegisterPageController.confirmPassword,
            textAlign: TextAlign.center,
            style: const TextStyle(
                color: Colors.black87, fontWeight: FontWeight.bold),
            decoration: const InputDecoration(
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.all(Radius.circular(10))),
                hintStyle: TextStyle(fontWeight: FontWeight.normal),
                contentPadding: EdgeInsets.all(10),
                hintText: 'Confirm Password'),
          ),
        )
      ])
    }
  };

  Widget _bloodGroupSelector(Size screenSize) {
    return SizedBox(
      width: screenSize.width,
      child: Row(
        children: [
          Container(
            margin: const EdgeInsets.only(right: 10),
            child: SvgPicture.asset(
              'assets/icons/blood-icon.svg',
              width: screenSize.width * 0.2,
              fit: BoxFit.contain,
            ),
          ),
          Expanded(
            child: PageView.builder(
                controller: controller.bloodPageController,
                itemCount: 8,
                itemBuilder: (context, index) {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                          [
                            'A+',
                            'A-',
                            'B+',
                            'B-',
                            'O+',
                            'O-',
                            'AB+',
                            'AB-'
                          ][index],
                          style: TextStyle(fontSize: screenSize.width * 0.08)),
                      Container(
                        margin: const EdgeInsets.only(right: 10),
                        width: double.infinity,
                        child: Text(
                          [
                            'You can donate to\nA+, AB+, and AB-',
                            'You can donate to A-, A+, AB-, and AB+',
                            'You can donate to B+, AB+, and AB-',
                            'You can donate to B-, B+, AB-, and AB+',
                            'You are a universal red blood cell donor',
                            'You are a universal donor',
                            'You can donate to AB+ and AB-',
                            'You can donate to AB-'
                          ][index],
                          style: TextStyle(fontSize: screenSize.width * 0.03),
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

  Widget _profileSelector(Size screenSize) {
    return InkResponse(
      onTap: () async {
        final image =
            await ImagePicker().pickImage(source: ImageSource.gallery);
        controller.profileUrl.value = image?.path ?? "";
      },
      child: Obx(
        () => CircleAvatar(
          radius: screenSize.width * 0.23,
          backgroundImage: controller.profileUrl.value == ""
              ? null
              : FileImage(File(controller.profileUrl.value)),
          child: controller.profileUrl.value == ""
              ? const Icon(
                  Icons.person,
                  size: 32,
                )
              : null,
        ),
      ),
    );
  }

  Widget _contactItem(Size screenSize) {
    final contactPageController = PageController();
    return SizedBox(
      width: screenSize.width,
      height: screenSize.height * 0.47,
      child: Obx(
        () => PageView.builder(
            controller: contactPageController,
            itemCount: controller.contactEditors.value.length,
            itemBuilder: (context, index) {
              return Container(
                padding: const EdgeInsets.all(15),
                margin: const EdgeInsets.only(bottom: 10),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(30)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        InkResponse(
                          onTap: () {
                            contactPageController.previousPage(
                                duration: const Duration(milliseconds: 250),
                                curve: Curves.easeInOut);
                            controller.contactEditors.value.remove(index);
                            print(controller.contactEditors);
                            setState(() {
                              _setWidget(screenSize);
                            });
                          },
                          child: Container(
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(30)),
                                border: Border.all(color: Colors.black54)),
                            child: Row(
                              children: [
                                const Icon(
                                  Icons.close,
                                  size: 15,
                                ),
                                Text('Remove Contact',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black54,
                                        fontSize: screenSize.width * 0.025)),
                              ],
                            ),
                          ),
                        ),
                        InkResponse(
                          onTap: () {
                            controller.contactEditors.value
                                .addAll(Map<int, Map<String, Object>>.from({
                              controller.contactEditors.length: {
                                'nameEditor': TextEditingController()
                                  ..text = "Name",
                                'relationEditor': TextEditingController()
                                  ..text = "Relation",
                                'phoneEditor': TextEditingController()
                                  ..text = "+91xxxxxxxxxx",
                                'viewAccess': false.obs,
                                'profileUrl': "".obs,
                              }
                            }));

                            setState(() {
                              _setWidget(screenSize);
                            });
                            print(controller.contactEditors.value);
                            contactPageController.nextPage(
                                duration: const Duration(milliseconds: 250),
                                curve: Curves.easeInOut);
                          },
                          child: Container(
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(30)),
                                border: Border.all(color: Colors.black54)),
                            child: Row(
                              children: [
                                const Icon(
                                  Icons.add,
                                  size: 15,
                                ),
                                Text('Add A Contact',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black54,
                                        fontSize: screenSize.width * 0.025)),
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                    Container(
                      width: screenSize.width,
                      margin: const EdgeInsets.only(top: 10, bottom: 10),
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          Container(
                            margin: const EdgeInsets.only(top: 10),
                            child: InkResponse(
                              onTap: () async {
                                final image = await ImagePicker()
                                    .pickImage(source: ImageSource.gallery);
                                controller.contactEditors[index]!['profileUrl']
                                    .value = image?.path ?? "";
                              },
                              child: Obx(
                                () => CircleAvatar(
                                  radius: screenSize.width * 0.13,
                                  backgroundImage: controller
                                              .contactEditors[index]![
                                                  'profileUrl']
                                              .value ==
                                          ""
                                      ? null
                                      : FileImage(File(controller
                                          .contactEditors[index]!['profileUrl']
                                          .value)),
                                  child: controller
                                              .contactEditors[index]![
                                                  'profileUrl']
                                              .value ==
                                          ""
                                      ? const Icon(
                                          Icons.person,
                                          size: 32,
                                        )
                                      : null,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    IntrinsicWidth(
                      child: SizedBox(
                        height: screenSize.width * 0.1,
                        child: TextField(
                          controller:
                              controller.contactEditors[index]!['nameEditor'],
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: screenSize.width * 0.045),
                          decoration:
                              const InputDecoration(border: InputBorder.none),
                        ),
                      ),
                    ),
                    IntrinsicWidth(
                      child: SizedBox(
                        height: screenSize.width * 0.1,
                        child: TextField(
                          controller: controller
                              .contactEditors[index]!['relationEditor'],
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: screenSize.width * 0.03),
                          decoration:
                              const InputDecoration(border: InputBorder.none),
                        ),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(top: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            margin: const EdgeInsets.only(right: 5),
                            child: const Icon(
                              CupertinoIcons.info,
                              color: Colors.orangeAccent,
                              size: 18,
                            ),
                          ),
                          Obx(
                            () => Text(
                                controller.contactEditors[index]!['viewAccess']
                                        .value
                                    ? 'Has Access To Your Medical Documents'
                                    : 'Can\'t Access Your Medical Documents',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black54,
                                    fontSize: screenSize.width * 0.03)),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      height: screenSize.height * 0.06,
                      margin: const EdgeInsets.only(top: 15),
                      child: Row(children: [
                        Expanded(
                          child: Container(
                            padding: const EdgeInsets.fromLTRB(8, 8, 8, 4),
                            margin: const EdgeInsets.only(right: 5),
                            alignment: Alignment.center,
                            height: double.infinity,
                            decoration: BoxDecoration(
                                color: Colors.grey.shade200,
                                borderRadius: const BorderRadius.all(
                                    Radius.circular(5000.0))),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Icon(
                                  Icons.phone,
                                  size: 20,
                                ),
                                Expanded(
                                  child: Container(
                                    margin: const EdgeInsets.only(
                                        bottom: 8, left: 2),
                                    child: TextField(
                                      maxLength: 14,
                                      maxLengthEnforcement: MaxLengthEnforcement
                                          .truncateAfterCompositionEnds,
                                      controller: controller.contactEditors[
                                          index]!['phoneEditor'],
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: screenSize.width * 0.03),
                                      decoration: const InputDecoration(
                                          counterText: "",
                                          contentPadding:
                                              EdgeInsets.only(bottom: 15),
                                          border: InputBorder.none),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Expanded(
                          child: InkResponse(
                            onTap: () {
                              controller.contactEditors[index]!['viewAccess']
                                      .value =
                                  !controller
                                      .contactEditors[index]!['viewAccess']
                                      .value;
                            },
                            child: Container(
                              padding: const EdgeInsets.all(8),
                              margin: const EdgeInsets.only(right: 5),
                              alignment: Alignment.center,
                              height: double.infinity,
                              decoration: BoxDecoration(
                                  color: Colors.grey.shade200,
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(5000.0))),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Container(
                                    margin: const EdgeInsets.only(right: 5),
                                    child: Obx(
                                      () => Icon(
                                        controller
                                                .contactEditors[index]![
                                                    'viewAccess']
                                                .value
                                            ? Icons.switch_access_shortcut
                                            : Icons.switch_access_shortcut_add,
                                        size: 20,
                                      ),
                                    ),
                                  ),
                                  Obx(
                                    () => Expanded(
                                      child: Text(
                                          controller
                                                  .contactEditors[index]![
                                                      'viewAccess']
                                                  .value
                                              ? 'Remove Access'
                                              : 'Allow Access',
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: Colors.black54,
                                              fontSize:
                                                  screenSize.width * 0.026)),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        InkResponse(
                            onTap: () {},
                            child: CircleAvatar(
                              radius: screenSize.height * 0.03,
                              backgroundColor: Colors.grey.shade200,
                              child: const Icon(
                                Icons.done,
                                color: Colors.black,
                                size: 20,
                              ),
                            ))
                      ]),
                    ),
                  ],
                ),
              );
            }),
      ),
    );
  }

  Widget _documentAdder(Size screenSize) {
    return SizedBox(
      width: screenSize.width,
      height: screenSize.height * 0.55,
      child: Column(
        children: [
          DottedBorder(
            borderType: BorderType.RRect,
            radius: const Radius.circular(10),
            color: Colors.blueGrey,
            child: Container(
              width: screenSize.width,
              padding: const EdgeInsets.all(10),
              decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  color: Colors.white),
              child: Column(children: [
                SvgPicture.asset('assets/icons/upload-icon.svg',
                    height: screenSize.height * 0.07, fit: BoxFit.cover),
                Container(
                  margin: const EdgeInsets.only(top: 5),
                  child: Text('Upload your medical documents',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: screenSize.width * 0.035)),
                ),
                Text('Only pdf files are accepted',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: screenSize.width * 0.028)),
                Container(
                  margin: const EdgeInsets.only(top: 10),
                  child: ElevatedButton(
                      onPressed: () async {
                        final result = await FilePicker.platform.pickFiles(
                            allowMultiple: true,
                            type: FileType.custom,
                            allowedExtensions: ['pdf']);
                        if (result != null)
                          controller.medicalDocuments.value = result.files;
                        setState(() {
                          _setWidget(screenSize);
                        });
                      },
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blueAccent,
                          padding: const EdgeInsets.symmetric(
                              vertical: 10, horizontal: 15)),
                      child: Text('Choose Documents',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: screenSize.width * 0.03,
                              color: Colors.white))),
                )
              ]),
            ),
          ),
          Expanded(
              child: Obx(
            () => ListView.builder(
                itemCount: controller.medicalDocuments.value.length,
                itemBuilder: (context, index) {
                  return Container(
                    margin: const EdgeInsets.only(top: 10),
                    width: screenSize.width,
                    padding: const EdgeInsets.all(10),
                    decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        color: Colors.white),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Container(
                                margin: const EdgeInsets.only(right: 10),
                                child: SvgPicture.asset(
                                    "assets/icons/pdf-icon.svg",
                                    height: screenSize.height * 0.035,
                                    fit: BoxFit.cover),
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    width: screenSize.width * 0.6,
                                    child: Text(
                                        controller
                                            .medicalDocuments.value[index].name,
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize:
                                                screenSize.width * 0.035)),
                                  ),
                                  Text(
                                      '${(controller.medicalDocuments.value[index].size / (1024 * 1024)).toStringAsFixed(2)} MB',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          fontSize: screenSize.width * 0.03)),
                                ],
                              ),
                            ],
                          ),
                          InkResponse(
                              onTap: () {
                                controller.medicalDocuments.value
                                    .removeAt(index);
                                setState(() {
                                  _setWidget(screenSize);
                                });
                              },
                              child: Container(
                                  margin: const EdgeInsets.only(left: 5),
                                  child: const Icon(Icons.close)))
                        ]),
                  );
                }),
          ))
        ],
      ),
    );
  }

  Widget _doctorCard(Size screenSize, Map<String, dynamic> data) {
    return Container(
        alignment: Alignment.bottomCenter,
        padding: const EdgeInsets.all(10),
        width: screenSize.height * 0.4,
        height: screenSize.height * 0.3,
        child: Stack(
            clipBehavior: Clip.none,
            alignment: Alignment.bottomCenter,
            children: [
              CircleAvatar(
                radius: screenSize.width * 0.45,
                backgroundImage: NetworkImage(data['imageUrl']),
                child: data['imageUrl'] == null
                    ? const Icon(Icons.person, size: 20)
                    : null,
              ),
              Container(
                margin: const EdgeInsets.only(top: 50),
                height: screenSize.height * 0.08,
                padding: const EdgeInsets.all(10),
                decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(10))),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 25,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(data['name'],
                              style: TextStyle(
                                  fontSize: screenSize.width * 0.04,
                                  overflow: TextOverflow.ellipsis)),
                          Obx(
                            () => Checkbox(
                                value: data['selected'].value,
                                onChanged: (value) {
                                  for (var doctor in controller.doctors) {
                                    if (data['doctorId'] ==
                                        doctor['doctorId']) {
                                      doctor['selected'].value = value;
                                      return;
                                    }
                                  }
                                }),
                          )
                        ],
                      ),
                    ),
                    Text(data['workingIn'],
                        style: TextStyle(fontSize: screenSize.width * 0.03)),
                  ],
                ),
              )
            ]));
  }

  Widget _doctorAdder(Size screenSize) {
    final controller = Get.find<RegisterPageController>();
    return Column(
      children: [
        Container(
          margin: const EdgeInsets.only(bottom: 20),
          height: screenSize.height * 0.08,
          width: screenSize.width,
          child: TextField(
            onChanged: (text) {
              controller.filterDoctors(text.toLowerCase());
            },
            textAlign: TextAlign.left,
            style: const TextStyle(
                color: Colors.black87, fontWeight: FontWeight.bold),
            decoration: const InputDecoration(
                filled: true,
                prefixIcon: Icon(Icons.search),
                fillColor: Colors.white,
                border: OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.all(Radius.circular(10))),
                hintStyle:
                    TextStyle(fontWeight: FontWeight.normal, fontSize: 14),
                contentPadding: EdgeInsets.all(10),
                hintText: 'Search by Doctor Id, Name, Hospital'),
          ),
        ),
        SizedBox(
            width: screenSize.width,
            height: screenSize.height * 0.3,
            child: Obx(
              () => ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: controller.doctorsThatAppear.length,
                  itemBuilder: (context, index) {
                    return _doctorCard(screenSize,
                        controller.doctorsThatAppear.elementAt(index));
                  }),
            ))
      ],
    );
  }

  void _setWidget(Size screenSize) {
    if (controller.contentIndex.value == 8) {
      widgetThatAppear.value = _bloodGroupSelector(screenSize);
    } else if (controller.contentIndex.value == 9) {
      widgetThatAppear.value = _profileSelector(screenSize);
    } else if (controller.contentIndex.value == 10) {
      widgetThatAppear.value = _contactItem(screenSize);
    } else if (controller.contentIndex.value == 11) {
      widgetThatAppear.value = _documentAdder(screenSize);
    } else if (controller.contentIndex.value == 12) {
      widgetThatAppear.value = _doctorAdder(screenSize);
    } else {
      widgetThatAppear.value =
          registerData[controller.contentIndex.value]!['widget']! as Widget;
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(
        const Duration(milliseconds: 2500), () => controller.fadeInItems());
    widgetThatAppear = (registerData[0]!['widget'] as Widget).obs;
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.sizeOf(context);
    return Scaffold(
      body: SingleChildScrollView(
        child: SizedBox(
          height: screenSize.height,
          width: screenSize.width,
          child: Stack(
            alignment: Alignment.center,
            children: [
              SizedBox(
                  width: screenSize.width,
                  height: screenSize.height,
                  child: Lottie.asset(
                      'assets/animations/gradient-background-animation.json',
                      fit: BoxFit.cover)),
              Obx(() => FadeInOutWidget(
                    enable: controller.widgetEnable,
                    bottomPositionMultiplier:
                        controller.contentIndex.value == 12 ||
                                controller.contentIndex.value == 10 ||
                                controller.contentIndex.value == 11 ||
                                controller.contentIndex.value == 13
                            ? 0.05
                            : 0.15,
                    height: controller.contentIndex.value == 12
                        ? screenSize.height * 0.42
                        : controller.contentIndex.value == 10 ||
                                controller.contentIndex.value == 11
                            ? screenSize.height * 0.5
                            : controller.contentIndex.value == 2
                                ? screenSize.height * 0.2
                                : controller.contentIndex.value == 13
                                    ? screenSize.height * 0.18
                                    : controller.contentIndex.value == 8
                                        ? screenSize.height * 0.13
                                        : controller.contentIndex.value == 9
                                            ? screenSize.height * 0.08
                                            : null,
                    margin: const EdgeInsets.symmetric(horizontal: 30),
                    child: Wiggle(
                        height: controller.contentIndex.value == 12
                            ? screenSize.height * 0.42
                            : controller.contentIndex.value == 2
                                ? screenSize.height * 0.2
                                : controller.contentIndex.value == 13
                                    ? screenSize.height * 0.25
                                    : controller.contentIndex.value == 8
                                        ? screenSize.height * 0.13
                                        : null,
                        trigger: controller.wiggle,
                        child: widgetThatAppear.value),
                  )),
              Obx(
                () => FadeInOutWidget(
                    bottomPositionMultiplier:
                        controller.contentIndex.value == 12 ||
                                controller.contentIndex.value == 10 ||
                                controller.contentIndex.value == 11
                            ? -0.02
                            : 0.05,
                    enable: controller.titleEnable,
                    child: Text(
                        registerData[controller.contentIndex.value]!['title']!
                            .toString(),
                        style: TextStyle(fontSize: screenSize.width * 0.04))),
              ),
              Obx(
                () => FadeInOutWidget(
                    bottomPositionMultiplier:
                        controller.contentIndex.value == 12 ||
                                controller.contentIndex.value == 10 ||
                                controller.contentIndex.value == 11
                            ? -0.05
                            : 0.01,
                    enable: controller.subtitleEnable,
                    child: Text(
                        registerData[controller.contentIndex.value]!['subtitle']!
                            .toString(),
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: screenSize.width * 0.04))),
              ),
              Obx(
                () => FadeInOutWidget(
                  bottomPositionMultiplier: controller.contentIndex.value == 12 ||
                          controller.contentIndex.value == 10 ||
                          controller.contentIndex.value == 11
                      ? -0.12
                      : -0.05,
                  enable: controller.captionEnable,
                  height: screenSize.height * 0.7,
                  margin: const EdgeInsets.only(left: 20, right: 20),
                  child: SizedBox(
                    width: screenSize.width,
                    child: ElevatedButton(
                      onPressed: () async {
                        if (controller.contentIndex.value == 6 &&
                            await controller.emailExists()) {
                          MainController.showMessage(
                              'This email already exists, please try again with a different mail');
                          controller.wiggle.value = true;
                          controller.wiggle.update((value) {});
                          return;
                        }
      
                        if (controller.contentIndex.value == 11 &&
                            controller.medicalDocuments.value.isEmpty) {
                          controller.wiggle.value = true;
                          controller.wiggle.update((value) {});
                          return;
                        }
                        if (controller.contentIndex.value == 13 &&
                            ((RegisterPageController.password.text !=
                                    RegisterPageController
                                        .confirmPassword.text) ||
                                (RegisterPageController.password.text.isEmpty ||
                                    RegisterPageController
                                        .confirmPassword.text.isEmpty))) {
                          controller.wiggle.value = true;
                          controller.wiggle.update((value) {});
                          return;
                        }
                        if (controller.contentIndex.value == 13) {
                          await controller.register();
                          return;
                        }
                        if ([
                          RegisterPageController.nameController,
                          RegisterPageController.nameController,
                          RegisterPageController.nameController,
                          RegisterPageController.bioController,
                          RegisterPageController.professionController,
                          RegisterPageController.phoneController,
                          RegisterPageController.emailController,
                          RegisterPageController.addressController,
                          RegisterPageController.addressController,
                          RegisterPageController.addressController,
                          RegisterPageController.addressController,
                          RegisterPageController.addressController,
                          RegisterPageController.addressController,
                          RegisterPageController.addressController,
                        ][controller.contentIndex.value]
                            .text
                            .isEmpty) {
                          controller.wiggle.value = true;
                          controller.wiggle.update((value) {});
                          return;
                        }
                        await controller.fadeOutItems();
                        controller.contentIndex.value++;
                        _setWidget(screenSize);
                        await controller.fadeInItems();
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xff6c5aee),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 12),
                      ),
                      child: Obx(
                        () => Text(
                          controller.contentIndex.value == 13
                              ? 'Register'
                              : 'Confirm',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Obx(
                () => FadeInOutWidget(
                  bottomPositionMultiplier: controller.contentIndex.value == 12 ||
                          controller.contentIndex.value == 10 ||
                          controller.contentIndex.value == 11
                      ? -0.19
                      : -0.12,
                  enable: controller.backButtonEnable,
                  height: screenSize.height * 0.7,
                  margin: const EdgeInsets.only(left: 20, right: 20),
                  child: SizedBox(
                    width: screenSize.width,
                    child: ElevatedButton(
                      onPressed: () async {
                        await controller.fadeOutItems();
                        controller.contentIndex.value--;
                        _setWidget(screenSize);
                        await controller.fadeInItems();
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.grey.shade100,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 12),
                      ),
                      child: const Text(
                        'Back',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class FadeInOutWidget extends StatelessWidget {
  FadeInOutWidget(
      {super.key,
      required this.enable,
      required this.child,
      required this.bottomPositionMultiplier,
      this.height,
      this.margin});

  RxBool enable;
  Widget child;
  double? height;
  EdgeInsets? margin;
  double bottomPositionMultiplier;

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.sizeOf(context);
    return Obx(() => AnimatedPositioned(
          width: screenSize.width,
          bottom: enable.value
              ? (screenSize.height * 0.3 +
                  screenSize.height * bottomPositionMultiplier)
              : (screenSize.height * 0.3 +
                      screenSize.height * bottomPositionMultiplier) -
                  25.0,
          height: height == null ? screenSize.height * 0.08 : null,
          duration: const Duration(milliseconds: 600),
          child: AnimatedOpacity(
              duration: const Duration(milliseconds: 600),
              opacity: enable.value ? 1.0 : 0.0,
              child: Container(
                  alignment: Alignment.center, margin: margin, child: child)),
        ));
  }
}

class Wiggle extends StatefulWidget {
  final Widget child;
  final RxBool trigger;
  final double? height;

  const Wiggle(
      {super.key, required this.child, required this.trigger, this.height});

  @override
  State<Wiggle> createState() => _WiggleState();
}

class _WiggleState extends State<Wiggle> with TickerProviderStateMixin {
  late AnimationController translationAnimationController;
  late Animation translationAnimation;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    translationAnimationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 250))
      ..addListener(() {
        if (translationAnimation.status == AnimationStatus.completed) {
          translationAnimationController.reverse();
        }
      });

    translationAnimation = Tween<double>(begin: 0.0, end: -10)
        .animate(translationAnimationController);

    widget.trigger.listen((value) {
      if (value) {
        translationAnimationController.forward();
      }
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    translationAnimationController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: widget.height,
      child: AnimatedBuilder(
          animation: translationAnimation,
          builder: (context, oldwidget) {
            return Transform.translate(
                offset: Offset(translationAnimation.value, 0),
                child: widget.child);
          }),
    );
  }
}
