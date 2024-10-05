import 'package:downloadsfolder/downloadsfolder.dart';
import 'package:electronic_clothes_frontend/app/modules/medical_reports_page/views/medical_reports_page_view.dart';
import 'package:electronic_clothes_frontend/app/modules/user_details_page/views/user_details_page_view.dart';
import 'package:electronic_clothes_frontend/main.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/svg.dart';

import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

import '../controllers/contacts_page_controller.dart';

class ContactsPageView extends GetView<ContactsPageController> {
  const ContactsPageView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.sizeOf(context);
    return Scaffold(
      body: Container(
        height: screenSize.height,
        width: screenSize.width,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              UserDetailPageFloatingNavbar(),
              const ContactsPageHeroSection(),
              const ContactPageContentSection()
            ],
          ),
        ),
      ),
    );
  }
}

class ContactsPageHeroSection extends GetWidget<ContactsPageController> {
  const ContactsPageHeroSection({super.key});

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.sizeOf(context);
    RxDouble borderRadius = 10.0.obs;
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Your',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: screenSize.width * 0.06)),
                  Row(
                    children: [
                      Text('Contacts',
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
                ],
              ),
              InkResponse(
                child: Icon(
                  CupertinoIcons.add,
                  size: screenSize.width * 0.1,
                ),
              )
            ],
          ),
          Container(
              margin: const EdgeInsets.only(top: 15),
              child: Obx(() {
                final searchController = TextEditingController();
                RxBool cancel = false.obs;
                return TextField(
                  onTap: () => borderRadius.value = 20,
                  onTapOutside: (tapDetails) => borderRadius.value = 5,
                  cursorColor: Colors.black54,
                  controller: searchController,
                  cursorWidth: 1,
                  onChanged: (text) {
                    if (text == "")
                      cancel.value = false;
                    else
                      cancel.value = true;
                    controller.filterUsers(text);
                  },
                  decoration: InputDecoration(
                      hintText: 'Search for contacts',
                      suffixIcon: Obx(() => cancel.value
                          ? InkResponse(
                              onTap: () {
                                searchController.text = "";
                                controller.filterUsers("");
                              },
                              child: const Icon(Icons.close))
                          : const Icon(CupertinoIcons.search)),
                      focusColor: Colors.black54,
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                              Radius.circular(borderRadius.value)),
                          borderSide: const BorderSide(
                              color: Colors.black54, width: 1)),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                              Radius.circular(borderRadius.value))),
                      contentPadding: const EdgeInsets.symmetric(
                          horizontal: 15, vertical: 8)),
                );
              })),
          Container(
            width: screenSize.width,
            margin: const EdgeInsets.only(top: 25),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Total Contacts',
                    style: TextStyle(
                        color: Colors.black45,
                        fontSize: screenSize.width * 0.06,
                        fontWeight: FontWeight.bold)),
                Row(
                  children: [
                    FrostedBackground(
                        borderRadius: 8,
                        child: Container(
                          width: screenSize.width * 0.25,
                          padding: const EdgeInsets.all(8),
                          margin: const EdgeInsets.only(top: 10),
                          decoration: BoxDecoration(
                              color: controller.mainController.currentTheme
                                  .value.frostBackgroundColor.value
                                  .withOpacity(1),
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(8))),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Text('12',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: screenSize.width * 0.028)),
                              Text('Contacts',
                                  style: TextStyle(
                                      color: Colors.black54,
                                      fontSize: screenSize.width * 0.028)),
                            ],
                          ),
                        )),
                  ],
                ),
                Container(
                    margin: const EdgeInsets.only(top: 10),
                    height: screenSize.height * 0.2,
                    child: Row(
                      children: [
                        Expanded(
                          flex: 6,
                          child: Container(
                            margin: const EdgeInsets.only(right: 5),
                            padding: const EdgeInsets.only(top: 15, left: 15),
                            decoration: BoxDecoration(
                                color: const Color.fromARGB(255, 219, 223, 116),
                                boxShadow: [
                                  const BoxShadow(
                                          offset: Offset(0, 4),
                                          color: Color.fromARGB(
                                              255, 253, 255, 207),
                                          blurRadius: 3)
                                      .scale(3)
                                ],
                                borderRadius: const BorderRadius.all(
                                    Radius.circular(25))),
                            child: Stack(
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text('Total Reads Access',
                                        style: TextStyle(
                                            color: Colors.black54,
                                            fontWeight: FontWeight.bold,
                                            fontSize: screenSize.width * 0.03)),
                                    Text('25 Contacts Given Access',
                                        style: TextStyle(
                                            color: Colors.black54,
                                            fontWeight: FontWeight.bold,
                                            fontSize: screenSize.width * 0.05)),
                                    Container(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 10, vertical: 5),
                                      margin: const EdgeInsets.only(top: 3),
                                      decoration: BoxDecoration(
                                          borderRadius: const BorderRadius.all(
                                              Radius.circular(5)),
                                          border: Border.all(
                                              color: controller
                                                  .mainController
                                                  .currentTheme
                                                  .value
                                                  .textColor
                                                  .value
                                                  .withOpacity(0.5)),
                                          color: Colors.white),
                                      child: Text('View Access Details',
                                          style: TextStyle(
                                              fontSize:
                                                  screenSize.width * 0.025)),
                                    )
                                  ],
                                ),
                                Positioned(
                                  bottom: -screenSize.width * 0.1,
                                  right: -screenSize.width * 0.1,
                                  child: Lottie.asset(
                                    'assets/animations/contact-animation.json',
                                    height: screenSize.width * 0.4,
                                    repeat: false,
                                    fit: BoxFit.cover,
                                    width: screenSize.width * 0.4,
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ],
                    ))
              ],
            ),
          )
        ],
      ),
    );
  }
}

class ContactPageContentSection extends GetWidget<ContactsPageController> {
  const ContactPageContentSection({super.key});

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.sizeOf(context);
    return Container(
      width: screenSize.width,
      margin: const EdgeInsets.only(top: 15, right: 15, left: 15),
      child: Obx(
        () => Visibility(
          visible: controller.ready.value,
          replacement: const SpinKitWave(
            color: Colors.grey,
          ),
          child: ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: (controller.contactsThatAppear.length / 2).ceil(),
              itemBuilder: (context, index) {
                RxBool contactOpened = false.obs;
                RxBool isEditing = false.obs;
                RxBool openEditing = false.obs;
                RxBool showUpdateButton = false.obs;
                RxMap contactDetail = Map.from({
                  "name": "",
                  "phone": "",
                  "imageUrl": '',
                  "impact": 50,
                  "viewAccess": false,
                  "relation": ''
                }).obs;
                RxBool viewAccess = (contactDetail['viewAccess'] as bool).obs;
                List<Rx<TextEditingController>> editingControllers =
                    List.generate(
                        3,
                        (index) => (TextEditingController()
                              ..text = [
                                contactDetail['name'],
                                contactDetail['relation'],
                                contactDetail['phone']
                              ][index])
                            .obs);
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Obx(
                      () => AnimatedSize(
                        duration: const Duration(milliseconds: 500),
                        child: Container(
                          height: contactOpened.value ? null : 0.0,
                          padding: const EdgeInsets.all(15),
                          margin: const EdgeInsets.only(bottom: 10),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(30)),
                              boxShadow: [bottomShadow]),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    padding: const EdgeInsets.all(10),
                                    decoration: BoxDecoration(
                                        borderRadius: const BorderRadius.all(
                                            Radius.circular(30)),
                                        border:
                                            Border.all(color: Colors.black54)),
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
                                                fontSize:
                                                    screenSize.width * 0.025)),
                                      ],
                                    ),
                                  ),
                                  InkResponse(
                                    onTap: () =>
                                        openEditing.value = !openEditing.value,
                                    child: Container(
                                      padding: const EdgeInsets.all(10),
                                      decoration: BoxDecoration(
                                          borderRadius: const BorderRadius.all(
                                              Radius.circular(30)),
                                          border: Border.all(
                                              color: Colors.black54)),
                                      child: Obx(
                                        () => AnimatedCrossFade(
                                            firstChild: const Icon(
                                              Icons.more_horiz,
                                              size: 15,
                                            ),
                                            secondChild: const Icon(
                                              Icons.keyboard_arrow_up,
                                              size: 15,
                                            ),
                                            crossFadeState: openEditing.value
                                                ? CrossFadeState.showSecond
                                                : CrossFadeState.showFirst,
                                            duration: const Duration(
                                                milliseconds: 500)),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                              Container(
                                width: screenSize.width,
                                margin:
                                    const EdgeInsets.only(top: 10, bottom: 10),
                                child: Stack(
                                  alignment: Alignment.center,
                                  children: [
                                    Container(
                                      margin: const EdgeInsets.only(top: 10),
                                      child: CircleAvatar(
                                        radius: screenSize.width * 0.1,
                                        backgroundImage: NetworkImage(
                                            contactDetail['imageUrl']),
                                      ),
                                    ),
                                    Positioned(
                                      top: 0,
                                      right: 0,
                                      child: Obx(
                                        () => AnimatedSize(
                                          duration:
                                              const Duration(milliseconds: 500),
                                          child: Container(
                                            padding: const EdgeInsets.all(10),
                                            height:
                                                openEditing.value ? null : 0.0,
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    const BorderRadius.all(
                                                        Radius.circular(10)),
                                                color: controller
                                                    .mainController
                                                    .currentTheme
                                                    .value
                                                    .frostBackgroundColor
                                                    .value),
                                            child: Obx(
                                              () => InkResponse(
                                                onTap: () {
                                                  showUpdateButton.value =
                                                      false;
                                                  isEditing.value =
                                                      !isEditing.value;
                                                },
                                                child: AnimatedContainer(
                                                  duration: const Duration(
                                                      milliseconds: 500),
                                                  child: Text(
                                                      isEditing.value
                                                          ? 'Stop Editing'
                                                          : 'Edit Contact',
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          color: Colors.black54,
                                                          fontSize:
                                                              screenSize.width *
                                                                  0.03)),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              Obx(
                                () => IntrinsicWidth(
                                  child: SizedBox(
                                    height: isEditing.value
                                        ? screenSize.width * 0.1
                                        : screenSize.width * 0.045,
                                    child: TextField(
                                      enabled: isEditing.value,
                                      controller: editingControllers[0].value,
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold,
                                          fontSize: screenSize.width * 0.045),
                                      onChanged: (text) {
                                        for (var editor in editingControllers) {
                                          if (editor.value.text == "") {
                                            showUpdateButton.value = false;
                                            return;
                                          }
                                        }
                                        showUpdateButton.value = true;
                                      },
                                      decoration: InputDecoration(
                                        border: isEditing.value
                                            ? const UnderlineInputBorder()
                                            : InputBorder.none,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Obx(
                                () => IntrinsicWidth(
                                  child: SizedBox(
                                    height: isEditing.value
                                        ? screenSize.width * 0.1
                                        : screenSize.width * 0.03,
                                    child: TextField(
                                      enabled: isEditing.value,
                                      controller: editingControllers[1].value,
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: screenSize.width * 0.03),
                                      onChanged: (text) {
                                        for (var editor in editingControllers) {
                                          if (editor.value.text == "") {
                                            showUpdateButton.value = false;
                                            return;
                                          }
                                        }
                                        showUpdateButton.value = true;
                                      },
                                      decoration: InputDecoration(
                                        border: isEditing.value
                                            ? const UnderlineInputBorder()
                                            : InputBorder.none,
                                      ),
                                    ),
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
                                    Text(
                                        viewAccess.value
                                            ? 'Has Access To Your Medical Documents'
                                            : 'Can\'t Access Your Medical Documents',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black54,
                                            fontSize: screenSize.width * 0.03)),
                                  ],
                                ),
                              ),
                              Container(
                                height: screenSize.height * 0.06,
                                margin: const EdgeInsets.only(top: 15),
                                child: Row(children: [
                                  Expanded(
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
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          const Icon(
                                            Icons.phone,
                                            size: 20,
                                          ),
                                          Obx(
                                            () => IntrinsicWidth(
                                              child: Container(
                                                margin: const EdgeInsets.only(
                                                    bottom: 8, left: 2),
                                                child: TextField(
                                                  enabled: isEditing.value,
                                                  maxLength: 14,
                                                  maxLengthEnforcement:
                                                      MaxLengthEnforcement
                                                          .truncateAfterCompositionEnds,
                                                  controller:
                                                      editingControllers[2]
                                                          .value,
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize:
                                                          screenSize.width *
                                                              0.03),
                                                  onChanged: (text) {
                                                    for (var editor
                                                        in editingControllers) {
                                                      if (editor.value.text ==
                                                          "") {
                                                        showUpdateButton.value =
                                                            false;
                                                        return;
                                                      }
                                                    }
                                                    showUpdateButton.value =
                                                        true;
                                                  },
                                                  decoration: InputDecoration(
                                                    counterText: "",
                                                    contentPadding:
                                                        const EdgeInsets.only(
                                                            bottom: 15),
                                                    border: isEditing.value
                                                        ? const UnderlineInputBorder()
                                                        : InputBorder.none,
                                                  ),
                                                ),
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
                                        viewAccess.value = !viewAccess.value;
                                        if (viewAccess.value ==
                                            contactDetail['viewAccess'])
                                          showUpdateButton.value = false;
                                        else
                                          showUpdateButton.value = true;
                                      },
                                      child: Container(
                                        padding: const EdgeInsets.all(8),
                                        margin: const EdgeInsets.only(right: 5),
                                        alignment: Alignment.center,
                                        height: double.infinity,
                                        decoration: BoxDecoration(
                                            color: Colors.grey.shade200,
                                            borderRadius:
                                                const BorderRadius.all(
                                                    Radius.circular(5000.0))),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Container(
                                              margin: const EdgeInsets.only(
                                                  right: 5),
                                              child: Obx(
                                                () => Icon(
                                                  viewAccess.value
                                                      ? Icons
                                                          .switch_access_shortcut
                                                      : Icons
                                                          .switch_access_shortcut_add,
                                                  size: 20,
                                                ),
                                              ),
                                            ),
                                            Obx(
                                              () => Text(
                                                  viewAccess.value
                                                      ? 'Remove Access'
                                                      : 'Allow Access',
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Colors.black54,
                                                      fontSize:
                                                          screenSize.width *
                                                              0.03)),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                  InkResponse(
                                    onTap: showUpdateButton.value
                                        ? () {}
                                        : () {
                                            contactDetail.value = Map.from({
                                              "name": "",
                                              "phone": "",
                                              "imageUrl": '',
                                              "impact": 50,
                                              "viewAccess": false,
                                              "relation": ''
                                            });
                                            contactOpened.value = false;
                                          },
                                    child: CircleAvatar(
                                        radius: screenSize.height * 0.03,
                                        backgroundColor: Colors.grey.shade200,
                                        child: Obx(
                                          () => AnimatedCrossFade(
                                            firstChild: const Icon(
                                              Icons.keyboard_arrow_down,
                                              color: Colors.black,
                                              size: 20,
                                            ),
                                            secondChild: const Icon(
                                              Icons.done,
                                              color: Colors.black,
                                              size: 20,
                                            ),
                                            crossFadeState:
                                                showUpdateButton.value
                                                    ? CrossFadeState.showSecond
                                                    : CrossFadeState.showFirst,
                                            duration: const Duration(
                                                milliseconds: 500),
                                          ),
                                        )),
                                  )
                                ]),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Row(
                      children: List.generate(2, (innerIndex) {
                        controller.childIndex += 1;
                        print(controller.childIndex);
                        final currentChild = controller.childIndex;
                        if (controller.childIndex >=
                            controller.contactsThatAppear.length)
                          return Expanded(child: Container());

                        return Expanded(
                          child: Container(
                            margin: innerIndex % 2 == 0
                                ? const EdgeInsets.only(right: 5, bottom: 20)
                                : const EdgeInsets.only(left: 5, bottom: 20),
                            padding: const EdgeInsets.all(15),
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(40)),
                                boxShadow: [bottomShadow]),
                            child: Stack(
                              alignment: Alignment.center,
                              children: [
                                Column(
                                  children: [
                                    Row(
                                      children: [
                                        CircleAvatar(
                                          backgroundImage: NetworkImage(
                                              controller.contactsThatAppear[
                                                      controller.childIndex]
                                                  ['imageUrl']),
                                          radius: screenSize.width * 0.07,
                                        ),
                                        Expanded(
                                          child: Container(
                                            margin:
                                                const EdgeInsets.only(left: 10),
                                            child: Text(
                                                controller.contactsThatAppear[
                                                        controller.childIndex]
                                                    ['name'],
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: screenSize.width *
                                                        0.035)),
                                          ),
                                        ),
                                      ],
                                    ),
                                    Container(
                                      margin: const EdgeInsets.only(top: 10),
                                      child: Row(
                                        children: [
                                          Text('Relation : ',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.black54,
                                                  fontSize:
                                                      screenSize.width * 0.03)),
                                          Text(
                                              controller.contactsThatAppear[
                                                      controller.childIndex]
                                                  ['relation'],
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize:
                                                      screenSize.width * 0.03))
                                        ],
                                      ),
                                    ),
                                    Container(
                                      height: screenSize.height * 0.06,
                                      margin: const EdgeInsets.only(top: 15),
                                      child: Row(children: [
                                        Expanded(
                                          child: Container(
                                            padding: const EdgeInsets.all(8),
                                            margin:
                                                const EdgeInsets.only(right: 5),
                                            alignment: Alignment.center,
                                            height: double.infinity,
                                            decoration: BoxDecoration(
                                                color: Colors.grey.shade200,
                                                borderRadius: const BorderRadius
                                                    .all(
                                                    Radius.circular(5000.0))),
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: List.generate(
                                                  2,
                                                  (impactIndex) => Text(
                                                      [
                                                        controller.contactsThatAppear[
                                                                controller
                                                                    .childIndex]
                                                            ['impact'],
                                                        'Impact Count'
                                                      ][impactIndex]
                                                          .toString(),
                                                      style: TextStyle(
                                                          color: [
                                                            null,
                                                            Colors.black54,
                                                          ][impactIndex],
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize: [
                                                            screenSize.width *
                                                                0.028,
                                                            screenSize.width *
                                                                0.025
                                                          ][impactIndex]))),
                                            ),
                                          ),
                                        ),
                                        InkResponse(
                                          onTap: () {
                                            contactDetail.value = Map.from(
                                                controller.contactsThatAppear[
                                                    currentChild]);
                                            for (int i = 0; i < 3; i++) {
                                              editingControllers[i].value.text =
                                                  [
                                                contactDetail['name'],
                                                contactDetail['relation'],
                                                contactDetail['phone']
                                              ][i];
                                            }
                                            isEditing.value = false;
                                            contactOpened.value = true;
                                            print(contactDetail);
                                          },
                                          child: CircleAvatar(
                                              radius: screenSize.height * 0.03,
                                              backgroundColor:
                                                  Colors.grey.shade200,
                                              child: const Icon(
                                                Icons.arrow_outward,
                                                color: Colors.black,
                                                size: 20,
                                              )),
                                        )
                                      ]),
                                    )
                                  ],
                                ),
                                Obx(
                                  () => AnimatedContainer(
                                    duration: const Duration(milliseconds: 500),
                                    height: mapEquals(
                                            contactDetail,
                                            controller.contactsThatAppear[
                                                currentChild])
                                        ? null
                                        : 0.0,
                                    child: AspectRatio(
                                      aspectRatio: 1,
                                      child: FrostedBackground(
                                          borderRadius: 20,
                                          child: CircleAvatar(
                                            backgroundColor:
                                                Colors.grey.shade200,
                                            child: const Icon(
                                              CupertinoIcons.info,
                                              color: Colors.blueAccent,
                                            ),
                                          )),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        );
                      }),
                    ),
                  ],
                );
              }),
        ),
      ),
    );
  }
}
