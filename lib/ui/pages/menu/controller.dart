import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:love_novel/data/models/category/category.dart';
import 'package:love_novel/data/models/public/book.dart';

class MenuController extends GetxController {
  static MenuController get instance =>
      Get.isRegistered<MenuController>()
          ? Get.find()
          : Get.put(MenuController());

  var books = Rxn<List<Book>>();
  var genre = Rxn<Category>();
  late ScrollController scrollController;
  late CarouselController carouselController;
  var currentIndex = 0.obs;
  static var customerId = "".obs;

  move(int index) async {
    currentIndex.value = index;
    await carouselController.animateToPage(index);
  }

  @override
  void onInit() {
    super.onInit();
    carouselController = CarouselController();
    WidgetsBinding.instance.addPostFrameCallback((timer) async {
      books.value = [];
    });
  }
}
