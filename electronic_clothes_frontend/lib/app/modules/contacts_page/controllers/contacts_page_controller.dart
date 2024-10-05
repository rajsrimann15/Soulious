import 'package:electronic_clothes_frontend/main.dart';
import 'package:get/get.dart';

class ContactsPageController extends GetxController {
  final mainController = Get.find<MainController>();

  int childIndex = -1;

  RxBool ready = false.obs;


  final List contacts = [
    {
      "name": "John Wick",
      "phone": "+91 1234567890",
      "imageUrl":
          'https://t3.ftcdn.net/jpg/02/43/12/34/360_F_243123463_zTooub557xEWABDLk0jJklDyLSGl2jrr.jpg',
      "impact": 50,
      "viewAccess": true,
      "relation": 'parent'
    },
    {
      "name": "Jane Smith",
      "phone": "+9876543210",
      "imageUrl":
          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQJ2xgHj4nViZBhvukuP0ioj0flbxwfniruzQ&s',
      "impact": 80,
      "viewAccess": false,
      "relation": 'parent'
    },
    {
      "name": "Hugh Jackman",
      "phone": "+1112223333",
      "imageUrl":
          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSZfiP1EqQ_pz6-cMH98Dgs2Ci0vXZl2Q_JEA&s',
      "impact": 35,
      "viewAccess": false,
      "relation": 'brother'
    },
    {
      "name": "Anne hathaway",
      "phone": "+1234567890",
      "imageUrl":
          'https://media-cldnry.s-nbcnews.com/image/upload/t_fit-1500w,f_auto,q_auto:best/rockcms/2024-04/240423-anne-hathaway-vl-1114a-96eedf.jpg',
      "impact": 50,
      "viewAccess": false,
      "relation": 'girl friend'
    },
    {
      "name": "Ryan Gosling",
      "phone": "+1234567890",
      "imageUrl":
          'https://enoughproject.org/wp-content/uploads/2017/04/Ryan_Gosling-e1493121669188.jpg',
      "impact": 50,
      "viewAccess": false,
      "relation": 'friend'
    },
    {
      "name": "Elise Dorian",
      "phone": "+1234567890",
      "imageUrl":
          'https://t4.ftcdn.net/jpg/03/83/25/83/360_F_383258331_D8imaEMl8Q3lf7EKU2Pi78Cn0R7KkW9o.jpg',
      "impact": 50,
      "viewAccess": false,
      "relation": 'friend'
    },
  ];

  RxList contactsThatAppear = [].obs;

  @override
  void onInit() {
    super.onInit();
    contactsThatAppear.value = contacts;
    ready.value = true;
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void filterUsers(String text) {
    ready.value = false;
    childIndex = -1;
    contactsThatAppear.value = [];

    contacts.forEach((contact) {
      if (contact['name'].toLowerCase().contains(text.toLowerCase()) ||
          contact['phone'].toLowerCase().contains(text.toLowerCase()) ||
          contact['relation'].toLowerCase().contains(text.toLowerCase()))
        contactsThatAppear.value.add(contact);
    });

    ready.value = true;
  }
}
