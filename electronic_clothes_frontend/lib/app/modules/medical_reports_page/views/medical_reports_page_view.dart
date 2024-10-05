import 'dart:async';

import 'package:electronic_clothes_frontend/app/modules/user_details_page/views/user_details_page_view.dart';
import 'package:electronic_clothes_frontend/main.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

import '../controllers/medical_reports_page_controller.dart';

final bottomShadow = BoxShadow(
        offset: const Offset(0, 4), color: Colors.grey.shade200, blurRadius: 3)
    .scale(3);

class MedicalReportsPageView extends GetView<MedicalReportsPageController> {
  const MedicalReportsPageView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.sizeOf(context);
    return Scaffold(
      body: SizedBox(
        width: screenSize.width,
        height: screenSize.height,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              UserDetailPageFloatingNavbar(),
              const MedicalReportsHeroSection(),
              MedicalReportsFilterSection(
                options: const [
                  'By Date',
                  'By Read Count',
                  'By Download Count'
                ],
                functions: const [null, null, null],
              ),
              MedicalReportsContentSection(),
            ],
          ),
        ),
      ),
    );
  }
}

class MedicalReportsHeroSection
    extends GetWidget<MedicalReportsPageController> {
  const MedicalReportsHeroSection({super.key});

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
                      Text('Medical Reports',
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
                return TextField(
                  onTap: () => borderRadius.value = 20,
                  onTapOutside: (tapDetails) => borderRadius.value = 5,
                  cursorColor: Colors.black54,
                  cursorWidth: 1,
                  onChanged: (text) => controller.filterDocuments(text),
                  decoration: InputDecoration(
                      hintText: 'Search for documents',
                      suffixIcon: const Icon(CupertinoIcons.search),
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
                Text('Total Reports',
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
                              Text('Documents',
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
                                    Text('Total Reads',
                                        style: TextStyle(
                                            color: Colors.black54,
                                            fontWeight: FontWeight.bold,
                                            fontSize: screenSize.width * 0.03)),
                                    Text('25 Reads',
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
                                      child: Text('View Read Details',
                                          style: TextStyle(
                                              fontSize:
                                                  screenSize.width * 0.025)),
                                    )
                                  ],
                                ),
                                Positioned(
                                  bottom: -screenSize.width * 0.1,
                                  right: -screenSize.width * 0.03,
                                  child: Lottie.asset(
                                    'assets/animations/book-animation.json',
                                    height: screenSize.width * 0.4,
                                    repeat: true,
                                    fit: BoxFit.cover,
                                    width: screenSize.width * 0.4,
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                        Expanded(
                            flex: 4,
                            child: Column(
                              children: [
                                Container(
                                  width: double.infinity,
                                  padding:
                                      const EdgeInsets.fromLTRB(15, 0, 15, 15),
                                  decoration: BoxDecoration(
                                      borderRadius: const BorderRadius.only(
                                          topLeft: Radius.circular(25),
                                          bottomLeft: Radius.circular(25),
                                          bottomRight: Radius.circular(25)),
                                      color: Colors.white,
                                      boxShadow: [bottomShadow]),
                                  child: Column(
                                    children: [
                                      Container(
                                        margin:
                                            const EdgeInsets.only(bottom: 10),
                                        padding: EdgeInsets.fromLTRB(10, 10, 10,
                                            screenSize.height * 0.065),
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                const BorderRadius.only(
                                                    bottomLeft:
                                                        Radius.circular(25),
                                                    bottomRight:
                                                        Radius.circular(25)),
                                            color: const Color.fromARGB(
                                                255, 219, 223, 116),
                                            boxShadow: [bottomShadow]),
                                        child: SvgPicture.asset(
                                            'assets/icons/download-icon.svg'),
                                      ),
                                      Text('Total Downloads',
                                          style: TextStyle(
                                              color: Colors.black54,
                                              fontWeight: FontWeight.bold,
                                              fontSize:
                                                  screenSize.width * 0.03))
                                    ],
                                  ),
                                ),
                                Expanded(
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 8, horizontal: 15),
                                    decoration: BoxDecoration(
                                        borderRadius: const BorderRadius.only(
                                            bottomLeft: Radius.circular(15),
                                            bottomRight: Radius.circular(15)),
                                        color: const Color.fromARGB(
                                            255, 219, 223, 116),
                                        boxShadow: [
                                          const BoxShadow(
                                                  offset: Offset(0, 4),
                                                  color: Color.fromARGB(
                                                      255, 253, 255, 207),
                                                  blurRadius: 3)
                                              .scale(3)
                                        ]),
                                    child: Text('47 downloads',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            color: Colors.black54,
                                            fontWeight: FontWeight.bold,
                                            fontSize:
                                                screenSize.width * 0.025)),
                                  ),
                                )
                              ],
                            ))
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

class MedicalReportsFilterSection extends StatelessWidget {
  MedicalReportsFilterSection(
      {super.key, required this.options, required this.functions});

  List options;
  List functions;

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.sizeOf(context);
    return Container(
      margin: const EdgeInsets.only(top: 30, left: 15, right: 15),
      width: screenSize.width,
      height: screenSize.height * 0.05,
      alignment: Alignment.center,
      child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: options.length + 1,
          itemBuilder: (context, index) => index == 0
              ? Container(
                  alignment: Alignment.center,
                  margin: const EdgeInsets.only(right: 15),
                  child: Text('Filter',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Colors.black54,
                          fontWeight: FontWeight.bold,
                          fontSize: screenSize.width * 0.04)))
              : InkResponse(
                  onTap: () => functions[index - 1](),
                  child: Container(
                    alignment: Alignment.center,
                    padding: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 20),
                    margin: const EdgeInsets.only(right: 5),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(5000)),
                        color: Colors.white,
                        border: Border.all(color: Colors.black12)),
                    child: Text(options[index - 1],
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: Colors.black54,
                            fontWeight: FontWeight.bold,
                            fontSize: screenSize.width * 0.03)),
                  ),
                )),
    );
  }
}

class MedicalReportsContentSection
    extends GetWidget<MedicalReportsPageController> {
  MedicalReportsContentSection({super.key});

  final images = [
    [
      'https://t4.ftcdn.net/jpg/03/83/25/83/360_F_383258331_D8imaEMl8Q3lf7EKU2Pi78Cn0R7KkW9o.jpg',
      'https://t3.ftcdn.net/jpg/02/43/12/34/360_F_243123463_zTooub557xEWABDLk0jJklDyLSGl2jrr.jpg',
      'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQJ2xgHj4nViZBhvukuP0ioj0flbxwfniruzQ&s'
    ],
    [
      'https://st3.depositphotos.com/1037987/15097/i/450/depositphotos_150975580-stock-photo-portrait-of-businesswoman-in-office.jpg',
      'https://media-cldnry.s-nbcnews.com/image/upload/t_fit-1500w,f_auto,q_auto:best/rockcms/2024-04/240423-anne-hathaway-vl-1114a-96eedf.jpg',
      'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSZfiP1EqQ_pz6-cMH98Dgs2Ci0vXZl2Q_JEA&s'
    ],
    [
      'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQJ2xgHj4nViZBhvukuP0ioj0flbxwfniruzQ&s',
      'https://enoughproject.org/wp-content/uploads/2017/04/Ryan_Gosling-e1493121669188.jpg',
      'https://www.looper.com/img/gallery/why-alita-from-alita-battle-angel-looks-so-familiar/intro-1617116214.jpg'
    ]
  ];

  final colors = [Color(0xffd8dfe9), Color(0xffcfe1ca), Color(0xffe9eeea)];

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.sizeOf(context);
    return Container(
      width: screenSize.width,
      margin: const EdgeInsets.only(right: 10, left: 10),
      child: Obx(() => ListView.builder(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: controller.documentsToBeShown.value.length,
          itemBuilder: (context, outerIndex) => Container(
                margin: const EdgeInsets.only(bottom: 15),
                padding: const EdgeInsets.all(15),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                    color: colors[outerIndex],
                    boxShadow: [
                      BoxShadow(
                              offset: const Offset(0, 4),
                              color: colors[outerIndex].withOpacity(0.6),
                              blurRadius: 3)
                          .scale(2)
                    ]),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Obx(() {
                      RxBool showDialogue = false.obs;
                      return Stack(
                        clipBehavior: Clip.none,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Stack(
                                    alignment: Alignment.centerLeft,
                                    children: List.generate(
                                        controller
                                            .data[controller.documentsToBeShown
                                                .elementAt(outerIndex)]['reads']
                                            .length,
                                        (index) => index == 3
                                            ? Container(
                                                alignment: Alignment.center,
                                                height: screenSize.width * 0.1,
                                                width: screenSize.width * 0.1,
                                                margin: EdgeInsets.only(
                                                    left: index *
                                                        screenSize.width *
                                                        0.07),
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                        const BorderRadius.all(
                                                            Radius.circular(
                                                                5000)),
                                                    color: Colors.white,
                                                    border: Border.all(
                                                        color:
                                                            colors[outerIndex],
                                                        width: 2)),
                                                child: Text(
                                                  '+${controller.data[controller.documentsToBeShown.elementAt(outerIndex)]['reads'].length - 3}',
                                                  style: const TextStyle(
                                                      color: Colors.grey,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                              )
                                            : index > 3
                                                ? Container()
                                                : Container(
                                                    height:
                                                        screenSize.width * 0.1,
                                                    width:
                                                        screenSize.width * 0.1,
                                                    margin: EdgeInsets.only(
                                                        left: index *
                                                            screenSize.width *
                                                            0.07),
                                                    decoration: BoxDecoration(
                                                        borderRadius:
                                                            const BorderRadius
                                                                .all(
                                                                Radius.circular(
                                                                    5000)),
                                                        color: Colors.grey,
                                                        border: Border.all(
                                                            color: colors[
                                                                outerIndex],
                                                            width: 2)),
                                                    child: CircleAvatar(
                                                      backgroundImage:
                                                          NetworkImage(
                                                              images[outerIndex]
                                                                  [index]),
                                                    ),
                                                  )),
                                  ),
                                  Obx(
                                    () => InkResponse(
                                      onTap: () {
                                        showDialogue.value =
                                            !showDialogue.value;
                                      },
                                      child: CircleAvatar(
                                        backgroundColor: Colors.white,
                                        radius: screenSize.width * 0.05,
                                        child: AnimatedCrossFade(
                                          duration:
                                              const Duration(milliseconds: 250),
                                          crossFadeState: showDialogue.value
                                              ? CrossFadeState.showSecond
                                              : CrossFadeState.showFirst,
                                          firstChild: const Icon(
                                            Icons.more_horiz,
                                            color: Colors.grey,
                                          ),
                                          secondChild: const Icon(
                                            Icons.keyboard_arrow_up,
                                            color: Colors.grey,
                                          ),
                                        ),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                              Container(
                                margin: EdgeInsets.only(
                                    top: screenSize.height * 0.03),
                                child: Text('uploaded on',
                                    style: TextStyle(
                                        color: Colors.black54,
                                        fontWeight: FontWeight.bold,
                                        fontSize: screenSize.width * 0.025)),
                              ),
                              Text(
                                  formatDate(controller.data[controller
                                      .documentsToBeShown
                                      .elementAt(outerIndex)]['uploadedOn']),
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: screenSize.width * 0.03)),
                            ],
                          ),
                          Positioned(
                            right: 0.0,
                            top: screenSize.height * 0.055,
                            child: Obx(
                              () => FrostedBackground(
                                borderRadius: 10,
                                child: AnimatedSize(
                                  duration: const Duration(milliseconds: 250),
                                  curve: Curves.easeInOut,
                                  child: Container(
                                    width: showDialogue.value ? null : 0.0,
                                    height: showDialogue.value ? null : 0.0,
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 10, horizontal: 20),
                                    decoration: BoxDecoration(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(10)),
                                      color: ColorTheme
                                          .lightThemeFrostBackgroundColor,
                                    ),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      children: List.generate(
                                          2,
                                          (buttonIndex) => Container(
                                                margin:
                                                    const EdgeInsets.symmetric(
                                                        vertical: 3),
                                                child: InkResponse(
                                                  onTap: () => buttonIndex == 0
                                                      ? Get.toNamed(
                                                          '/document-page',
                                                          arguments: {
                                                              'documentUrl': controller
                                                                          .data[
                                                                      controller
                                                                          .documentsToBeShown
                                                                          .elementAt(
                                                                              outerIndex)]
                                                                  [
                                                                  'reportDocument'],
                                                              'documentName': controller
                                                                          .data[
                                                                      controller
                                                                          .documentsToBeShown
                                                                          .elementAt(
                                                                              outerIndex)]
                                                                  [
                                                                  'reportTitle']
                                                            })
                                                      : controller.downloadPdf(
                                                          controller.data[controller
                                                                  .documentsToBeShown
                                                                  .elementAt(
                                                                      outerIndex)]
                                                              ['reportTitle'],
                                                          controller.data[controller
                                                                  .documentsToBeShown
                                                                  .elementAt(
                                                                      outerIndex)]
                                                              ['reportDocument']),
                                                  child: Text(
                                                      [
                                                        'Open',
                                                        'Download'
                                                      ][buttonIndex],
                                                      style: TextStyle(
                                                          color: Colors.white,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize:
                                                              screenSize.width *
                                                                  0.03)),
                                                ),
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
                    Container(
                      margin: const EdgeInsets.only(top: 15),
                      width: screenSize.width * 0.8,
                      child: Text(
                          controller.data[controller.documentsToBeShown
                              .elementAt(outerIndex)]['reportTitle'],
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: screenSize.width * 0.05)),
                    ),
                    Container(
                      margin: const EdgeInsets.only(top: 5),
                      width: screenSize.width * 0.6,
                      child: Text(
                          'Regarding ${controller.data[controller.documentsToBeShown.elementAt(outerIndex)]['regarding']}',
                          style: TextStyle(
                              color: Colors.black54,
                              fontWeight: FontWeight.bold,
                              fontSize: screenSize.width * 0.032)),
                    ),
                    Row(
                        children: List.generate(
                            2,
                            (innerIndex) => Expanded(
                                  flex: [6, 4][innerIndex],
                                  child: Container(
                                    margin: (innerIndex == 1)
                                        ? const EdgeInsets.only(
                                            top: 10, left: 3)
                                        : const EdgeInsets.only(
                                            top: 10, right: 3),
                                    padding: const EdgeInsets.all(10),
                                    decoration: const BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(20))),
                                    child: Column(
                                      children: [
                                        Row(
                                          children: [
                                            Container(
                                              padding: const EdgeInsets.all(8),
                                              margin: const EdgeInsets.only(
                                                  right: 10),
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.all(
                                                          Radius.circular(
                                                              5000)),
                                                  color: Colors.white,
                                                  border: Border.all(
                                                      color: Colors.black12)),
                                              child: SvgPicture.asset(
                                                [
                                                  'assets/icons/download-icon.svg',
                                                  'assets/icons/book-icon.svg'
                                                ][innerIndex],
                                                height: screenSize.width * 0.04,
                                                width: screenSize.width * 0.04,
                                              ),
                                            ),
                                            Text(
                                                [
                                                  'Downloads',
                                                  'Reads'
                                                ][innerIndex],
                                                style: TextStyle(
                                                    color: Colors.black87,
                                                    fontSize: screenSize.width *
                                                        0.03))
                                          ],
                                        ),
                                        Container(
                                          margin: const EdgeInsets.only(top: 5),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: List.generate(
                                                2,
                                                (textIndex) => Text(
                                                    [
                                                      [
                                                        controller.data[
                                                                controller
                                                                    .documentsToBeShown
                                                                    .elementAt(
                                                                        outerIndex)]
                                                                [
                                                                'totalDownloads']
                                                            .toString(),
                                                        ' Donwloads'
                                                      ][textIndex],
                                                      [
                                                        controller.data[
                                                                controller
                                                                    .documentsToBeShown
                                                                    .elementAt(
                                                                        outerIndex)]
                                                                ['totalReads']
                                                            .toString(),
                                                        ' Reads'
                                                      ][textIndex]
                                                    ][innerIndex],
                                                    style: TextStyle(
                                                        fontWeight: [
                                                          FontWeight.bold,
                                                          null
                                                        ][textIndex],
                                                        fontSize:
                                                            screenSize.width *
                                                                0.04))),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                )))
                  ],
                ),
              ))),
    );
  }
}
