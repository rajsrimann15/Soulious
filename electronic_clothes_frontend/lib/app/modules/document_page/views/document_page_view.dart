import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:flutter_svg/svg.dart';
import 'package:syncfusion_flutter_pdf/pdf.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import 'package:get/get.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

import '../controllers/document_page_controller.dart';

class DocumentPageView extends GetView<DocumentPageController> {
  const DocumentPageView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.sizeOf(context);
    return Scaffold(
        body: Container(
      height: screenSize.height,
      width: screenSize.width,
      padding: EdgeInsets.only(top: MediaQuery.paddingOf(context).top + 10),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(15), topRight: Radius.circular(15))),
      child: Column(
        children: [
          Container(
            margin: const EdgeInsets.all(5),
            padding: const EdgeInsets.all(15),
            decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(blurRadius: 3, color: Colors.grey.shade300).scale(3)
                ],
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(15),
                    topRight: Radius.circular(15))),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SvgPicture.asset(
                  'assets/icons/pdf-icon.svg',
                  height: screenSize.width * 0.05,
                  width: screenSize.width * 0.05,
                ),
                Text('${controller.documentTitle}.pdf',
                    style: TextStyle(
                        fontWeight: FontWeight.w400,
                        color: controller.mainController.currentTheme.value
                                    .CURRENTTHEME.value ==
                                'light'
                            ? Colors.white
                            : null,
                        fontSize: screenSize.width * 0.04)),
                InkResponse(
                  child: Icon(Icons.more_horiz),
                )
              ],
            ),
          ),
          Expanded(
            child: Container(
              margin: const EdgeInsets.only(right: 5, left: 5, bottom: 10),
              decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(blurRadius: 3, color: Colors.grey.shade300)
                        .scale(3)
                  ],
                  borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(15),
                      bottomRight: Radius.circular(15))),
              child: Stack(
                alignment: Alignment.bottomCenter,
                children: [
                  SfPdfViewer.network(
                    controller.documentUrl,
                    onZoomLevelChanged: (property) {
                      controller.zoom.value = property.newZoomLevel;
                    },
                    initialZoomLevel: 0,
                    maxZoomLevel: 5,
                    interactionMode: PdfInteractionMode.pan,
                    onDocumentLoaded: (details) =>
                        controller.fileReady.value = true,
                  ),
                  Positioned(
                      bottom: 15,
                      child: Row(
                          children: List.generate(3, (index) {
                        return Container(
                          alignment: Alignment.center,
                          height: screenSize.height * 0.065,
                          width: index == 1
                              ? screenSize.width * 0.2
                              : screenSize.width * 0.15,
                          decoration: BoxDecoration(
                              color: const [
                                Color(0xff6e868a),
                                Color(0xff5b777c),
                                Color(0xff6e868a)
                              ][index],
                              borderRadius: const [
                                BorderRadius.only(
                                    topLeft: Radius.circular(10),
                                    bottomLeft: Radius.circular(10)),
                                null,
                                BorderRadius.only(
                                    topRight: Radius.circular(10),
                                    bottomRight: Radius.circular(10)),
                              ][index]),
                          padding: const EdgeInsets.all(15),
                          child: [
                            const Icon(
                              Icons.zoom_in,
                              color: Colors.white,
                            ),
                            Obx(
                              () => Text(
                                  '${((controller.zoom.value * 2) * 10).toStringAsFixed(2)}%',
                                  style: TextStyle(
                                      fontWeight: FontWeight.w400,
                                      color: Colors.white,
                                      fontSize: screenSize.width * 0.03)),
                            ),
                            const Icon(
                              Icons.zoom_out,
                              color: Colors.white,
                            )
                          ][index],
                        );
                      }))),
                  Obx(
                    () => Visibility(
                        visible: !controller.fileReady.value,
                        child: Container(
                          color: Colors.white,
                          height: double.infinity,
                          width: double.infinity,
                          alignment: Alignment.center,
                          child: SpinKitWave(
                              color: controller.mainController.currentTheme
                                  .value.frostBackgroundColor.value),
                        )),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    ));
  }
}
