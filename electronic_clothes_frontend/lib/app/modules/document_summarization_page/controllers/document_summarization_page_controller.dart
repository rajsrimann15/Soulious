import 'package:electronic_clothes_frontend/main.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DocumentSummarizationPageController extends GetxController {
  final mainController = Get.find<MainController>();

  RxList data = [].obs;
  RxBool ready = false.obs;

  final document = {
    "reportTitle": "MSR Sample Anxiety and Depression 2023.pdf",
    "reportDocument":
        "https://soarworks.samhsa.gov/sites/default/files/media/documents/2023-04/MSR%20Sample%20Anxiety%20and%20Depression%202023.pdf",
    "regarding": "Anxiety and Depression",
    "uploadedOn": DateTime.now().toIso8601String(),
    "totalReads": "12",
    "totalDownloads": "5",
    "viewAccess": [
      {"userId": "string"}
    ]
  };

  Map summaryResult = {
    "contexts": [
      {
        "subtitle": "Mental Health Diagnosis",
        "context":
            "Jim is diagnosed with Major Depressive Disorder and Anxiety Disorder, experiencing severe symptoms for many years.",
        "evidences": [
          {
            "icon": 0x1F914, // 🏥 (Hospital icon)
            "evidence": "Hospitalized twice due to mental health symptoms"
          },
          {
            "icon": 0x1F4CD, // 💊 (Pill icon)
            "evidence":
                "Inconsistent medication adherence due to lack of motivation"
          }
        ]
      },
      {
        "subtitle": "Social Difficulties",
        "context":
            "Jim exhibits significant social anxiety and isolation, struggling with interpersonal interactions.",
        "evidences": [
          {
            "icon": 0x1F9D1, // 👥 (People icon)
            "evidence":
                "Difficulty meeting new people and tolerating social situations"
          },
          {
            "icon": 0x1F4AC, // 🏠 (House icon)
            "evidence": "Prefers isolation and avoids social interactions"
          }
        ]
      }
    ],
    "doubleContexts": [
      {
        "subtitle1": "Employment History",
        "context1":
            "Jim has a history of employment in welding and restaurants but stopped working due to mental health symptoms.",
        "icon1": 0x1F527, // 🛠️ (Tools icon)
        "evidence1": ["Welding", "Restaurants"],
        "subtitle2": "Current Employment Status",
        "context2":
            "Jim has been unemployed for several years due to severe mental health symptoms.",
        "icon2": 0x1F4C8, // 💼 (Briefcase icon)
        "evidence2": ["Unable to maintain employment"],
        "comparison":
            "Previous work experience contrasts sharply with current inability to work."
      }
    ],
    "points": [
      {
        "subtitle": "Impact of Childhood Trauma",
        "keyPoints": [
          "Experienced significant verbal abuse from father",
          "Childhood trauma contributes to current mental health issues"
        ],
        "evidence": [
          "Feels that negative feelings stem from father's abuse",
          "Nightmares related to trauma"
        ]
      }
    ]
  };

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void shuffleSummaryResult() {
    data.value = [];
    summaryResult.values.forEach((list) {
      data.addAll(list);
    });
    data.shuffle();
    Future.delayed(const Duration(seconds: 3), () => ready.value = true);
  }
}
