import 'package:carousel_slider/carousel_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:love_novel/ui/pages/discovery/controller.dart';
import 'package:love_novel/ui/pages/your_books/controller.dart';

class HomeController extends GetxController {
  static HomeController get instance => Get.isRegistered<HomeController>()
      ? Get.find()
      : Get.put(HomeController());

  var currentIndex = 0.obs;
  var carouselController = CarouselController();

  @override
  void onInit() {
    super.onInit();
    WidgetsBinding.instance.addPostFrameCallback((timer) async {});
  }

  move(int index) async {
    currentIndex.value = index;
    carouselController.animateToPage(index);
    if (index == 0) DiscoveryController.currentIndex.value = 0;
    if (index == 3) YourBooksController.currentIndex.value = 0;
  }
}
