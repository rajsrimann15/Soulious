import 'package:electronic_clothes_frontend/app/modules/user_details_page/views/user_details_page_view.dart';
import 'package:flutter/cupertino.dart';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';

import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';

import '../controllers/document_summarization_page_controller.dart';

class DocumentSummarizationPageView
    extends GetView<DocumentSummarizationPageController> {
  const DocumentSummarizationPageView({Key? key}) : super(key: key);
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
              DocumentSummarizationPageHeroSection(),
              DocumentSummarizationPageContentSection()
            ],
          ),
        ),
      ),
    );
  }
}

class DocumentSummarizationPageHeroSection
    extends GetWidget<DocumentSummarizationPageController> {
  const DocumentSummarizationPageHeroSection({super.key});

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.sizeOf(context);
    return Container(
      margin: const EdgeInsets.only(right: 15, left: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Report',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: screenSize.width * 0.06)),
                  Row(
                    children: [
                      Text('Summarization',
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
                  Icons.save_alt,
                  size: screenSize.width * 0.1,
                ),
              )
            ],
          ),
          Container(
            margin: const EdgeInsets.only(top: 10, bottom: 20),
            child: Text(controller.document['reportTitle'].toString(),
                style: TextStyle(
                    color: Colors.black54,
                    fontWeight: FontWeight.bold,
                    fontSize: screenSize.width * 0.05)),
          ),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 5),
            height: screenSize.height * 0.05,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Reported Doctor',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: screenSize.width * 0.035)),
                    Text('Dr.Reeves',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: screenSize.width * 0.03)),
                  ],
                ),
                Container(
                  height: double.infinity,
                  margin: const EdgeInsets.symmetric(vertical: 5),
                  width: 2,
                  color: Colors.grey,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text('Total Reads',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: screenSize.width * 0.035)),
                    Text(controller.document['totalReads'].toString(),
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: screenSize.width * 0.03)),
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

class DocumentSummarizationPageContentSection extends StatefulWidget {
  const DocumentSummarizationPageContentSection({super.key});

  @override
  State<DocumentSummarizationPageContentSection> createState() =>
      _DocumentSummarizationPageContentSectionState();
}

class _DocumentSummarizationPageContentSectionState
    extends State<DocumentSummarizationPageContentSection> {
  final controller = Get.find<DocumentSummarizationPageController>();

  Widget _subtitle(text, width) {
    return Container(
      padding: const EdgeInsets.all(10),
      margin: const EdgeInsets.only(bottom: 10, right: 10, left: 10, top: 15),
      width: width,
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(10)),
        color: Colors.grey.shade200,
      ),
      child: Text(text,
          style:
              TextStyle(fontWeight: FontWeight.bold, fontSize: width * 0.04)),
    );
  }

  Widget _doubleContexts(subtitle1, subtitle2, context1, context2, icon1, icon2,
      evidence1, evidence2, width, 
      {isLoading = false}) {
        
    return Container(
        margin: const EdgeInsets.only(top: 30, left: 20, right: 20),
        width: width,
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          SizedBox(
            width: width,
            child: Row(
              children: List.generate(
                  2,
                  (index) => SizedBox(
                        width: width * 0.42,
                        child: Row(
                          children: [
                            Container(
                              decoration: isLoading
                                  ? const BoxDecoration(
                                      color: Colors.white,
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(5)))
                                  : null,
                              padding: const EdgeInsets.all(8),
                              margin: const EdgeInsets.only(right: 5),
                              child: Icon(
                                IconData([icon1, icon2][index],
                                    fontFamily: 'MaterialIcons'),
                                size: 18,
                              ),
                            ),
                            Expanded(
                              child: isLoading
                                  ? Container(
                                      margin: const EdgeInsets.only(right: 15),
                                      height: 10,
                                      decoration: isLoading
                                          ? const BoxDecoration(
                                              color: Colors.white,
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(2)))
                                          : null,
                                    )
                                  : Text([subtitle1, subtitle2][index],
                                      style: TextStyle(
                                          fontSize: width * 0.032,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black54)),
                            )
                          ],
                        ),
                      )),
            ),
          ),
          Container(
            margin: const EdgeInsets.only(top: 15),
            width: width,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: List.generate(
                  2,
                  (index) => Container(
                        width: width * 0.41,
                        margin:
                            isLoading ? null : const EdgeInsets.only(left: 15),
                        child: isLoading
                            ? Container(
                                width: double.infinity,
                                height: 30,
                                margin: const EdgeInsets.only(right: 15),
                                decoration: isLoading
                                    ? const BoxDecoration(
                                        color: Colors.white,
                                        borderRadius:
                                            BorderRadius.all(Radius.circular(5)))
                                    : null,
                              )
                            : Text([context1, context2][index],
                                style: TextStyle(fontSize: width * 0.028)),
                      )),
            ),
          )
        ]),
    );
  }

  Widget _context(subtitle, context, evidences, width, {isLoading = false}) { 
    return Container(
        margin: const EdgeInsets.only(top: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _subtitle(subtitle, width),
            Container(
                width: isLoading ? width * 0.8 : width,
                height: isLoading ? 20 : null,
                decoration: isLoading
                    ? const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(5)))
                    : null,
                margin: isLoading
                    ? const EdgeInsets.only(right: 20, left: 10)
                    : const EdgeInsets.symmetric(horizontal: 30),
                child: isLoading
                    ? null
                    : Text(context, style: TextStyle(fontSize: width * 0.032))),
            Container(
              width: width,
              margin:
                  EdgeInsets.only(top: 15, left: isLoading ? 10 : 20, right: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: List.generate(
                    evidences.length,
                    (index) => Container(
                          margin: const EdgeInsets.only(bottom: 10),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              if (!isLoading)
                                Container(
                                  margin:
                                      const EdgeInsets.only(right: 10, top: 5),
                                  child: Icon(
                                    IconData(evidences[index]['icon'],
                                        fontFamily: 'MaterialIcons'),
                                    size: 15,
                                  ),
                                ),
                              Expanded(
                                child: isLoading
                                    ? Container(
                                        margin:
                                            EdgeInsets.only(right: width * 0.05),
                                        decoration: isLoading
                                            ? const BoxDecoration(
                                                color: Colors.white,
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(5)))
                                            : null,
                                        height: 10,
                                      )
                                    : Text(context,
                                        style:
                                            TextStyle(fontSize: width * 0.028)),
                              )
                            ],
                          ),
                        )),
              ),
            )
          ],
        ),
      )
    ;
  }

  Widget _points(subtitle, points, width, {isLoading = false}) {
    
    return Container(
        margin: const EdgeInsets.only(top: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _subtitle(subtitle, width),
            Container(
              margin: EdgeInsets.symmetric(horizontal: isLoading ? 15 : 30),
              width: width,
              child: Column(
                children: List.generate(
                    points.length,
                    (index) => Container(
                          margin:
                              EdgeInsets.only(bottom: 10, top: isLoading ? 5 : 0),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                  margin: EdgeInsets.only(
                                      right: 3, top: isLoading ? 1 : 5),
                                  child: const Icon(Icons.circle, size: 8)),
                              Expanded(
                                child: isLoading
                                    ? Container(
                                        margin: const EdgeInsets.only(right: 20),
                                        decoration: isLoading
                                            ? const BoxDecoration(
                                                color: Colors.white,
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(5)))
                                            : null,
                                        height: 10,
                                        width: double.infinity)
                                    : Text(points[index],
                                        style: TextStyle(fontSize: width * 0.03)),
                              ),
                            ],
                          ),
                        )),
              ),
            )
          ],
        
    ));
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.sizeOf(context);
    controller.shuffleSummaryResult();
    return Obx(
      () => AnimatedCrossFade(
        duration: const Duration(milliseconds: 250),
        crossFadeState: controller.ready.value ? CrossFadeState.showSecond : CrossFadeState.showFirst,
        firstChild: Container(
          margin: const EdgeInsets.only(top: 10, bottom: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Shimmer.fromColors(
                  baseColor: const Color(0xFFEBEBF4),
                  highlightColor: Colors.grey.shade300,
                  enabled: true,
                  child: _context(
                      'Some title Bro',
                      'context bro',
                      [
                        {
                          "icon": 0x1F914, // 🏥 (Hospital icon)
                          "evidence":
                              "Hospitalized twice due to mental health symptoms"
                        },
                        {
                          "icon": 0x1F4CD, // 💊 (Pill icon)
                          "evidence":
                              "Inconsistent medication adherence due to lack of motivation"
                        }
                      ],
                      screenSize.width, 
                      isLoading: true)),
              Shimmer.fromColors(
                  baseColor: const Color(0xFFEBEBF4),
                  highlightColor: Colors.grey.shade300,
                  enabled: true,
                  child: _points(
                      'Some bro',
                      [
                        "Experienced significant verbal abuse from father",
                        "Childhood trauma contributes to current mental health issues",
                        ''
                      ],
                      screenSize.width, 
                      isLoading: true)),
              Shimmer.fromColors(
                  baseColor: const Color(0xFFEBEBF4),
                  highlightColor: Colors.grey.shade300,
                  enabled: true,
                  child: _context(
                      'Some title Bro',
                      'context bro',
                      [
                        {
                          "icon": 0x1F914, // 🏥 (Hospital icon)
                          "evidence":
                              "Hospitalized twice due to mental health symptoms"
                        },
                        {
                          "icon": 0x1F4CD, // 💊 (Pill icon)
                          "evidence":
                              "Inconsistent medication adherence due to lack of motivation"
                        }
                      ],
                      screenSize.width, 
                      isLoading: true))
            ],
          ),
        ),
        secondChild: Obx(
          () => Visibility(
            visible: controller.ready.value, child: Container(
              margin: const EdgeInsets.only(top: 10, bottom: 20),
              child: AnimatedOpacity(
                duration: const Duration(milliseconds: 800),
                opacity: controller.ready.value ? 1.0 : 0.0,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: List.generate(controller.data.length, (index) {
                    try {
                      //try rendering a context
                      return _context(
                          controller.data[index]['subtitle'],
                          controller.data[index]['context'],
                          controller.data[index]['evidences'],
                          screenSize.width, );
                    } catch (error) {
                      try {
                        //try rendering a dual context
                        return _doubleContexts(
                            controller.data[index]['subtitle1'],
                            controller.data[index]['subtitle2'],
                            controller.data[index]['context1'],
                            controller.data[index]['context2'],
                            controller.data[index]['icon1'],
                            controller.data[index]['icon2'],
                            controller.data[index]['evidence1'],
                            controller.data[index]['evidence2'], 
                            screenSize.width);
                      } catch (error) {
                        //try rendering a points context
                        return _points(controller.data[index]['subtitle'],
                            controller.data[index]['keyPoints'], screenSize.width);
                      }
                    }
                  }),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}