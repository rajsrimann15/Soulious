import 'dart:io';

import 'package:downloadsfolder/downloadsfolder.dart';
import 'package:electronic_clothes_frontend/main.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import 'package:http/http.dart' as http;

class MedicalReportsPageController extends GetxController {
  final mainController = Get.find<MainController>();

  List data = [
    {
      "reportTitle": "Patient Discharge Summary",
      "reportDocument": "https://pdfobject.com/pdf/sample.pdf",
      "regarding": "Discharge Summary for John Doe",
      "uploadedOn": "2023-11-15T14:30:00Z",
      "totalReads": 5,
      "totalDownloads": 2,
      "reads": [
        {'userId': 'user123'},
        {'userId': 'user845'},
        {'userId': 'user245'}
      ]
    },
    {
      "reportTitle": "MRI Scan Report",
      "reportDocument": "https://css4.pub/2015/icelandic/dictionary.pdf",
      "regarding": "MRI Brain Scan for Jane Smith",
      "uploadedOn": "2023-12-05T10:15:30Z",
      "totalReads": 3,
      "totalDownloads": 1,
      "reads": [
        {'userId': 'user123'},
        {'userId': 'user845'},
        {'userId': 'user245'}
      ]
    },
    {
      "reportTitle": "Pathology Lab Results",
      "reportDocument": "https://css4.pub/2015/textbook/somatosensory.pdf",
      "regarding": "Blood Test Results for Michael Johnson",
      "uploadedOn": "2024-01-10T16:45:00Z",
      "totalReads": 4,
      "totalDownloads": 2,
      "reads": [
        {'userId': 'user123'},
        {'userId': 'user845'},
        {'userId': 'user245'},
        {'userId': 'user123'},
        {'userId': 'user123'},
        {'userId': 'user123'}
      ]
    }
  ];

  RxList documentsToBeShown = [].obs;

  @override
  void onInit() {
    super.onInit();
    documentsToBeShown.value = List.generate(data.length, (index) => index);
    print(documentsToBeShown);
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  Future<String?> getDownloadPath() async {
    Directory? directory;
    try {
      if (Platform.isIOS) {
        directory = await getApplicationDocumentsDirectory();
      } else {
        directory = Directory('/storage/emulated/0/soulious');
        // Put file in global download folder, if for an unknown reason it didn't exist, we fallback
        // ignore: avoid_slow_async_io
        if (!await directory.exists())
          directory = await getExternalStorageDirectory();
      }
    } catch (err, stack) {
      print("Cannot get download folder path");
    }
    return directory?.path;
  }

  void filterDocuments(String searchPhrase) {
    documentsToBeShown.value = [];

    for (int index = 0; index < data.length; index++) {
      if ((data[index]['reportTitle'] ?? '')
              .toLowerCase()
              .contains(searchPhrase.toLowerCase()) ||
          (data[index]['regarding'] ?? '')
              .toLowerCase()
              .contains(searchPhrase.toLowerCase())) {
        documentsToBeShown.value.add(index);
      }
    }
  }

  void downloadPdf(fileName, url) async {
    try {
      // Get the download directory path
      final directory = await getDownloadDirectory();

      final path = directory.path;

      // Download the file
      final response = await http.get(Uri.parse(url));
      final data = response.bodyBytes;
      final file = File('$path/$fileName.pdf');
      await file.writeAsBytes(data);

      // Show success message
      Get.snackbar('File Downloaded', '$fileName.pdf saved in $path',
          duration: const Duration(days: 1),
          isDismissible: true,
          dismissDirection: DismissDirection.horizontal,
          mainButton: TextButton(
              onPressed: () => Get.closeCurrentSnackbar(),
              child: const Text('Dismiss',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ))));
    } catch (e) {
      print('error bro $e');
    }
  }
}
