import 'package:electronic_clothes_frontend/main.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ClothesPageController extends GetxController {
  final mainController = Get.find<MainController>();
  PageController pageController = PageController();

  RxBool isYourClothesSection = true.obs;

  String heroSectionTitle = 'Get your specials';
  String heroSectionSubtitle = 'sales upto 40% off';
  String heroSectionActionButtonText = 'Shop now!';
  String heroSectionBackgroundImageUrl = 'assets/images/shop-dress-placeholder.jpg';
  Function heroSectionActionFunction = () {};

  List ownedClothesIDs = [
    {'chipId': 'sser332s2'},
    {'chipId': 'sser332s2'},
    {'chipId': 'sser332s2'},
    {'chipId': 'sser332s2'},
    {'chipId': 'sser332s2'},
  ];

  List ownedClothes = [
    {
      "chipId": "ABCD12",
      "imageUrl":
          "https://img0.junaroad.com/uiproducts/19410097/zoom_4-1677344182.jpg",
      "title": "Red Floral Dress"
    },
    {
      "chipId": "EFGH34",
      "imageUrl":
          "https://tiimg.tistatic.com/fp/1/007/302/white-black-t-shirt-for-mens-round-neck-full-sleeve-plain-pattern-trusted-quality-eye-catching-design-smart-look-soft-texture-skin-friendly-comfortable-to-wear-well-stitched-casual-wear-520.jpg",
      "title": "Black Midi Dress"
    },
    {
      "chipId": "IJKL56",
      "imageUrl":
          "https://assets.ajio.com/medias/sys_master/root/20231128/ynB5/6565c242ddf7791519a25173/-473Wx593H-466833334-maroon-MODEL.jpg",
      "title": "Blue Denim Dress"
    },
    {
      "chipId": "MNOP78",
      "imageUrl":
          "https://i.pinimg.com/originals/41/ae/85/41ae85429e807f3e66231310d3c2884f.jpg",
      "title": "Yellow Maxi Dress"
    }
  ];

  List clothGallery = [
    {
      "imageUrl":
          "https://www.aristobrat.in/cdn/shop/files/ClassicShirt_FrenchBlue_New5.jpg?v=1709565676&width=2048",
      "title": "Striped Summer Dress",
      "price": "59.99\$"
    },
    {
      "imageUrl":
          "https://assets.ajio.com/medias/sys_master/root/20230621/oOOk/64926e6442f9e729d76535a0/-473Wx593H-464024673-pink-MODEL.jpg",
      "title": "Elegant Evening Gown",
      "price": "249.00\$"
    },
    {
      "imageUrl":
          "https://images.bestsellerclothing.in/data/vero-moda/25-jan-2023/123051902_g2.jpg?width=1080&height=1355&mode=fill&fill=blur&format=auto&dpr=1.2",
      "price": "78.50\$",
      "title": "Casual T-Shirt Dress"
    },
    {
      "imageUrl":
          "https://www.jiomart.com/images/product/500x630/rvxhwq86md/fabflee-women-s-shirt-collar-rib-knitted-long-sleeves-tops-for-women-ribbed-top-tops-for-womens-tops-womens-top-crop-tops-for-women-brown-crop-tops-for-women-product-images-rvxhwq86md-0-202309301112.jpg",
      "title": "Comfy Knit Dress",
      "price": "42.75\$"
    }
  ];

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
}
