import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';

import 'app/routes/app_pages.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  dynamic initialRoute = AppPages.INITIAL;

  if (await MainController.storage.containsKey(key: "accessToken")) {
    (await http.get(Uri.parse("${MainController.url}/users/"), headers: {
      'Authorization':
          'Bearer ${await MainController.storage.read(key: 'accessToken')}'
    })).statusCode == 200 ? initialRoute = AppPages.INITIAL : '/register-page';
  }

  else {
    initialRoute = '/register-page';
  }

  runApp(
    GetMaterialApp(
      title: "Application",
      initialRoute: initialRoute,
      getPages: AppPages.routes,
      theme: ThemeData(fontFamily: 'poppins'),
      initialBinding: BindingsBuilder(() {
        Get.put(MainController());
      }),
    ),
  );
}

class MainController extends GetxController {
  Rx<ColorTheme> currentTheme = ColorTheme().obs;

  RxBool isTapped = false.obs;

  // static const url = "https://backend-demo2.vercel.app";
  static const url = "http://localhost:5000";


  static const storage = FlutterSecureStorage();

  static void showMessage(message) {
    Get.snackbar('Heyy...', message,
        snackPosition: SnackPosition.TOP,
        icon: const Icon(CupertinoIcons.info));
  }

  static const platform = MethodChannel('com.electronicClothes.soulious/nfc');
  RxString _nfcData = 'No NFC data'.obs;

  Map user = {
    "name": "John Doe",
    "age": 30,
    "dateOfBirth": "1993-11-25T00:00:00Z",
    "bloodGroup": "A+",
    "profession": "Software Engineer",
    "email": "johndoe@example.com",
    "phone": "+1234567890",
    "address": "123 Main Street, Anytown, CA",
    "bio": "A brief bio about myself.",
    'tabCount': 19,
    'currentDayTabCount': 3,
    "image":
        "https://preview.keenthemes.com/metronic-v4/theme_rtl/assets/pages/media/profile/profile_user.jpg",
    "googleId": "1234567890abcdef",
    "contacts": [
      {
        "name": "Jane Smith",
        "phone": "+9876543210",
        'imageUrl':
            "https://t4.ftcdn.net/jpg/03/83/25/83/360_F_383258331_D8imaEMl8Q3lf7EKU2Pi78Cn0R7KkW9o.jpg"
      },
      {
        "name": "Jack Sparrow",
        "phone": "+9876543210",
        'imageUrl':
            "https://pbs.twimg.com/profile_images/1618060433176383488/z6wO3CHz_400x400.jpg"
      },
    ],
    "medicalInfo": {
      "issues": [
        {
          "issue": "Skin Allergies",
          "regarding": "Allergies",
          "description/note": "Allergic to peanuts and shellfish"
        }
      ],
      "reports": [
        {
          "reportTitle": "Blood Test Report",
          "reportDocument":
              "http://www.nematrian.com/Pages/HTMLCSSJSCombined.pdf",
          "uploadedOn": DateTime.now().toIso8601String()
        },
        {
          "reportTitle": "Corona Test Report",
          "reportDocument": "https://pdfobject.com/pdf/sample.pdf",
          "uploadedOn": DateTime.now().toIso8601String()
        }
      ]
    },
    "consultedDoctors": [
      {
        "name": "Dr. Smith",
        "phone": "+1112223333",
        'imageUrl':
            "https://media.istockphoto.com/id/1468678624/photo/nurse-hospital-employee-and-portrait-of-black-man-in-a-healthcare-wellness-and-clinic-feeling.jpg?s=612x612&w=0&k=20&c=AGQPyeEitUPVm3ud_h5_yVX4NKY9mVyXbFf50ZIEtQI=",
        "regarding": "General Checkup"
      },
      {
        "name": "Dr. Alita",
        "phone": "+1112223333",
        'imageUrl':
            "https://static.vecteezy.com/system/resources/thumbnails/028/287/555/small_2x/an-indian-young-female-doctor-isolated-on-green-ai-generated-photo.jpg",
        "regarding": "General Checkup"
      }
    ],
    "viewAccess": [
      {"userId": "user123"}
    ]
  };

  @override
  void onInit() {
    super.onInit();
    currentTheme.value.setLightTheme();
    platform.setMethodCallHandler(_handleNfcData);
    _getNfcData();
  }

  Future<void> _getNfcData() async {
    try {
      final String? result = await platform.invokeMethod('getNfcData');
      _nfcData.value = result ?? 'No NFC data from method';
      final patterns = _nfcData.value.split("/");
      final objectID = patterns[patterns.length - 1];
      print(objectID);
      if (objectID != "Error: Invalid NFC action")
        {Get.toNamed('/anonymous-user-details-page', arguments: {'objectId': objectID});}
    } on PlatformException catch (e) {
      print("Failed to get NFC data: '${e.message}'.");
    }
  }

  Future<void> _handleNfcData(MethodCall call) async {
    if (call.method == 'onNfcData') {
      _nfcData = call.arguments ?? 'No NFC data from handle';
    }
  }
}

class ColorTheme {
  Rx<String> CURRENTTHEME = 'light'.obs;

  Rx<LinearGradient> backgroundGradient = lightThemeGradient.obs;
  Rx<Color> frostBackgroundColor = lightThemeFrostBackgroundColor.obs;
  Rx<Color> textColor = Colors.black.obs;
  Rx<String> shirtIcon = 'assets/icons/shirt-light.svg'.obs;
  Rx<String> handWaveIcon = 'assets/icons/hand-wave-light.svg'.obs;

  static LinearGradient darkThemeGradient = const LinearGradient(
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      colors: [Color(0xff081423), Color.fromARGB(244, 9, 17, 22)]);

  static LinearGradient lightThemeGradient = const LinearGradient(
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      colors: [
        Color.fromARGB(255, 248, 248, 248),
        Color.fromARGB(255, 238, 238, 238)
      ]);

  //frost background colors

  static Color darkThemeFrostBackgroundColor =
      const Color.fromARGB(255, 235, 235, 235).withOpacity(0.5);

  static Color lightThemeFrostBackgroundColor = Colors.black.withOpacity(0.5);

  //icons

  static String darkThemeHandWaveIcon = 'assets/icons/hand-wave-dark.svg';
  static String lightThemeHandWaveIcon = 'assets/icons/hand-wave-light.svg';

  static String darkThemeShirtIcon = 'assets/icons/shirt-dark.svg';
  static String lightThemeShirtIcon = 'assets/icons/shirt-light.svg';

  void setLightTheme() {
    backgroundGradient.value = lightThemeGradient;
    frostBackgroundColor.value = lightThemeFrostBackgroundColor;
    textColor.value = Colors.black;
    handWaveIcon.value = lightThemeHandWaveIcon;
    shirtIcon.value = lightThemeShirtIcon;
    CURRENTTHEME = 'light'.obs;
  }

  void setDarkTheme() {
    backgroundGradient.value = darkThemeGradient;
    frostBackgroundColor.value = darkThemeFrostBackgroundColor;
    textColor.value = Colors.white;
    handWaveIcon.value = darkThemeHandWaveIcon;
    shirtIcon.value = darkThemeShirtIcon;
    CURRENTTHEME = 'dark'.obs;
  }
}

class FrostedBackground extends StatelessWidget {
  FrostedBackground(
      {super.key,
      required this.child,
      this.borderRadius = 5000,
      this.keepBackgroundImage = false,
      this.bgHeight = 0,
      this.bgWidth = 0});

  Widget child;
  double borderRadius;
  bool keepBackgroundImage;
  double bgHeight, bgWidth;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.all(Radius.circular(borderRadius)),
      child: LayoutBuilder(
        builder: (context, constraints) => Stack(
          alignment: Alignment.center,
          children: [
            if (keepBackgroundImage)
              Container(
                height: bgHeight,
                width: bgWidth,
                margin: const EdgeInsets.only(top: 20, left: 15, right: 15),
                decoration: const BoxDecoration(
                    image: DecorationImage(
                        image: NetworkImage(
                            'https://t4.ftcdn.net/jpg/02/10/45/95/360_F_210459536_XmLDEcKq2DpeNLVmheuWeu9NM9aGKnih.jpg'),
                        fit: BoxFit.cover)),
              ),
            BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5), child: child),
          ],
        ),
      ),
    );
  }
}

String formatDate(dateString) {
  final dateTime = DateTime.parse(dateString);

  final months = [
    'january',
    'february',
    'march',
    'april',
    'may',
    'june',
    'july',
    'august',
    'september',
    'october',
    'november',
    'december'
  ];

  final day = dateTime.day.toString().padLeft(2, '0');
  final month = months[dateTime.month - 1];
  final year = dateTime.year.toString();

  return '$day, $month $year';
}
