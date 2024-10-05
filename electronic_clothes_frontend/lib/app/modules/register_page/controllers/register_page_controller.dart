import 'dart:convert';
import 'dart:io';

import 'package:electronic_clothes_frontend/main.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';

class RegisterPageController extends GetxController {
  static final nameController = TextEditingController();
  static final professionController = TextEditingController();
  static final emailController = TextEditingController();
  static final phoneController = TextEditingController();
  static final addressController = TextEditingController();
  static final bioController = TextEditingController();
  static final imageController = TextEditingController();
  static final password = TextEditingController();
  static final confirmPassword = TextEditingController();
  static final loginEmailController = TextEditingController();
  static final loginPassword = TextEditingController();

  RxString photoPath = "".obs;

  late PageController bloodPageController;

  List<Map<String, dynamic>> doctors = [
    {
      "user_id": "64e8f1a72f4a3c5b8d8f7f21",
      "name": "Dr. John Doe",
      "age": 45,
      "doctorId": "DOC12345",
      "phone": "+1234567890",
      "workingIn": "City Hospital",
      "imageUrl":
          'https://t3.ftcdn.net/jpg/02/43/12/34/360_F_243123463_zTooub557xEWABDLk0jJklDyLSGl2jrr.jpg'
    },
    {
      "user_id": "64e8f1a72f4a3c5b8d8f7f22",
      "name": "Dr. Jane Smith",
      "age": 39,
      "doctorId": "DOC67890",
      "phone": "+0987654321",
      "workingIn": "County Medical Center",
      "imageUrl":
          "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQJ2xgHj4nViZBhvukuP0ioj0flbxwfniruzQ&s"
    },
    {
      "user_id": "64e8f1a72f4a3c5b8d8f7f23",
      "name": "Dr. Mike Johnson",
      "age": 50,
      "doctorId": "DOC98765",
      "phone": "+1122334455",
      "workingIn": "Downtown Clinic",
      "imageUrl":
          "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSZfiP1EqQ_pz6-cMH98Dgs2Ci0vXZl2Q_JEA&s"
    },
    {
      "user_id": "64e8f1a72f4a3c5b8d8f7f24",
      "name": "Dr. Emily Davis",
      "age": 41,
      "doctorId": "DOC45321",
      "phone": "+4433221100",
      "workingIn": "Greenfield Health Center",
      "imageUrl":
          "https://media-cldnry.s-nbcnews.com/image/upload/t_fit-1500w,f_auto,q_auto:best/rockcms/2024-04/240423-anne-hathaway-vl-1114a-96eedf.jpg"
    },
    {
      "user_id": "64e8f1a72f4a3c5b8d8f7f25",
      "name": "Dr. Robert Brown",
      "age": 55,
      "doctorId": "DOC76543",
      "phone": "+5566778899",
      "workingIn": "Westside Medical",
      "imageUrl":
          "https://enoughproject.org/wp-content/uploads/2017/04/Ryan_Gosling-e1493121669188.jpg"
    },
    {
      "user_id": "64e8f1a72f4a3c5b8d8f7f26",
      "name": "Dr. Lisa Thompson",
      "age": 38,
      "doctorId": "DOC56432",
      "phone": "+6677889900",
      "workingIn": "Northview Hospital",
      "imageUrl":
          "https://t4.ftcdn.net/jpg/03/83/25/83/360_F_383258331_D8imaEMl8Q3lf7EKU2Pi78Cn0R7KkW9o.jpg"
    },
    {
      "user_id": "64e8f1a72f4a3c5b8d8f7f27",
      "name": "Dr. Andrew Scott",
      "age": 47,
      "doctorId": "DOC78654",
      "phone": "+7788990011",
      "workingIn": "Eastside Clinic",
      "imageUrl":
          "https://static.wikia.nocookie.net/disney/images/b/b2/Chris_Evans.jpg/revision/latest?cb=20200308211811"
    },
    {
      "user_id": "64e8f1a72f4a3c5b8d8f7f28",
      "name": "Dr. Sarah Wilson",
      "age": 42,
      "doctorId": "DOC11223",
      "phone": "+9988776655",
      "workingIn": "Lakeshore Hospital",
      "imageUrl":
          "https://cdn.britannica.com/92/215392-050-96A4BC1D/Australian-actor-Chris-Hemsworth-2019.jpg"
    },
    {
      "user_id": "64e8f1a72f4a3c5b8d8f7f29",
      "name": "Dr. James Miller",
      "age": 52,
      "doctorId": "DOC33445",
      "phone": "+4455667788",
      "workingIn": "South Valley Medical Center",
      "imageUrl":
          "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSA1hXb8yVDns0BLzAG883IxF3OkVy0hXCKhg&s"
    },
    {
      "user_id": "64e8f1a72f4a3c5b8d8f7f30",
      "name": "Dr. Olivia Green",
      "age": 36,
      "doctorId": "DOC99887",
      "phone": "+8877665544",
      "workingIn": "Riverbend Clinic",
      "imageUrl":
          "https://media.vanityfair.com/photos/61b7b68055295c52cf01c963/master/w_2560%2Cc_limit/GettyImages-1358673668.jpg"
    }
  ];

  RxList<Map<String, dynamic>> doctorsThatAppear = <Map<String, dynamic>>[].obs;

  //enables
  RxBool titleEnable = false.obs;
  RxBool subtitleEnable = false.obs;
  RxBool captionEnable = false.obs;
  RxBool widgetEnable = false.obs;
  RxBool backButtonEnable = false.obs;
  RxBool wiggle = false.obs;

  static Rx<DateTime> dob = DateTime.now().obs;

  static RxInt age = 15.obs;
  static RxString bloodGroup = "A+".obs;
  RxString profileUrl = "".obs;
  RxList<PlatformFile> medicalDocuments = <PlatformFile>[].obs;
  RxMap contactEditors = {
    0: {
      'nameEditor': TextEditingController()..text = "Name",
      'relationEditor': TextEditingController()..text = "Relation",
      'phoneEditor': TextEditingController()..text = "+91xxxxxxxxxx",
      'viewAccess': false.obs,
      'profileUrl': "".obs,
    }
  }.obs;

  RxInt contentIndex = 0.obs;

  @override
  void onInit() {
    super.onInit();
    doctors.forEach((doctor) {
      try {
        doctor.addAll({'selected': false.obs});
        doctorsThatAppear.value.add(doctor);
      } on Exception catch (e) {
        print("error $e occured while adding doctor ${doctor['name']}");
      }
    });
    print(doctors);
    bloodPageController = PageController()
      ..addListener(() {
        bloodGroup.value = [
          'A+',
          'A-',
          'B+',
          'B-',
          'O+',
          'O-',
          'AB+',
          'AB-'
        ][(bloodPageController.page ?? 0.0).toInt()];
      });
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void filterDoctors(text) {
    doctorsThatAppear.value = [];

    doctors.forEach((doctor) {
      if (doctor['name'].toLowerCase().contains(text) ||
          doctor['workingIn'].toLowerCase().contains(text) ||
          doctor['doctorId'].toLowerCase().contains(text) ||
          doctor['phone'].toLowerCase().contains(text)) {
        doctorsThatAppear.add(doctor);
      }
    });
  }

  Future<void> pickFileFromGallery() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (image == null) return;
      photoPath.value = image.path;
    } on PlatformException catch (e) {
      print('Failed to pick image: $e');
    }
  }

  Future<void> fadeInItems() async {
    for (int index = 0; index < 5; index++) {
      Future.delayed(
          Duration(
              milliseconds: (index == 3 || index == 4 ? 500 : 250) * index),
          () {
        if (index == 4) {
          backButtonEnable.value = contentIndex.value == 0 ? false : true;
          return;
        }
        [
          widgetEnable,
          titleEnable,
          subtitleEnable,
          captionEnable,
        ][index]
            .value = true;
      });
    }
    await Future.delayed(Duration(milliseconds: 1500));
  }

  Future<void> fadeOutItems() async {
    for (int index = 0; index < 5; index++) {
      Future.delayed(
          Duration(milliseconds: 250 * index),
          () => [
                backButtonEnable,
                captionEnable,
                subtitleEnable,
                titleEnable,
                widgetEnable,
              ][index]
                  .value = false);
    }
    await Future.delayed(Duration(milliseconds: 1800));
  }

  Future<bool> emailExists() async {
    final response = await http.post(
        Uri.parse("${MainController.url}/users/checkEmail/"),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'email': emailController.text}));
    if (response.statusCode == 200) {
      return false;
    } else {
      return true;
    }
  }

  Future<void> login() async {
    final response = await http.post(
        Uri.parse("${MainController.url}/users/login"),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'email': loginEmailController.text,
          'password': loginPassword.text
        }));

    if (response.statusCode == 200) {
      final responseData = jsonDecode(response.body);
      await MainController.storage
          .write(key: 'accessToken', value: responseData['accessToken']);
      await MainController.storage
          .write(key: 'userId', value: responseData['userId']);

      Get.toNamed('/user-details-page');
    } else {
      MainController.showMessage(
          'The credentials are invalid, please enter the correct ones');
      wiggle.value = true;
      wiggle.update((value) {});
      return;
    }
  }

  Future<void> register() async {
    try {
      final request = http.MultipartRequest(
          "POST", Uri.parse("${MainController.url}/users/register"));

      //contacts
      List finalContacts = [];

      if (contactEditors.isNotEmpty) {
        for (var profile in contactEditors.value.values) {
          if (!(profile['profileUrl'].value == "")) {
            request.files.add(await http.MultipartFile.fromPath(
                'contactProfiles', profile['profileUrl'].value));
          }

          finalContacts.add({
            'name': profile['nameEditor'].text,
            'relation': profile['relationEditor'].text,
            'phone': profile['phoneEditor'].text,
            'viewAccess': profile['viewAccess'].value
          });
        }
      }

      //medicalReports
      List finalReports = [];

      if (medicalDocuments.isNotEmpty) {
        for (var report in medicalDocuments) {
          request.files.add(await http.MultipartFile.fromPath(
              'medicalDocuments', report.path!));

          finalReports.add({
            "reportTitle": report.name,
            "uploadedOn": DateTime.now().toIso8601String(),
            "totalReads": 0,
            "totalDownloads": 0,
          });
        }
      }

      //profileUrl
      if (profileUrl.value.isNotEmpty) {
        request.files.add(
            await http.MultipartFile.fromPath('userProfile', profileUrl.value));
      }

      //doctors
      List finalDoctors = [];
      for (var doctor in doctors) {
        if (doctor['selected'].value) {
          finalDoctors.add({
            "name": doctor['name'],
            "doctorId": doctor['doctorId'],
            "phone": doctor['phone'],
          });
        }
      }

      request.fields['name'] = nameController.text;
      request.fields['age'] = age.value.toString();
      request.fields['bio'] = bioController.text;
      request.fields['dateOfBirth'] = dob.value.toIso8601String();
      request.fields['bloodGroup'] = bloodGroup.value;
      request.fields['phone'] = phoneController.text;
      request.fields['profession'] = professionController.text;
      request.fields['email'] = emailController.text;
      request.fields['address'] = addressController.text;
      request.fields['password'] = password.text;
      request.fields['consultedDoctors'] = jsonEncode(finalDoctors);
      request.fields['contacts'] = jsonEncode(finalContacts);
      request.fields['medicalDocuments'] = jsonEncode(finalReports);

      print(request.fields);
      print(request.files);
      final response = await request.send();

      final httpResponse = await http.Response.fromStream(response);

      if (response.statusCode == 201) {
        final responseData = jsonDecode(httpResponse.body);
        MainController.storage
            .write(key: 'accessToken', value: responseData['token']);
        MainController.storage
            .write(key: 'userId', value: responseData['userId']);
        print(httpResponse.body);
        Get.toNamed('/user-details-page');
      } else {
        print(httpResponse.statusCode);
        print(httpResponse.body);
      }
    } on Exception catch (e) {
      print(e);
    }
  }
}
