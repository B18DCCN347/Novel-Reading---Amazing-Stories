import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:love_novel/data/models/category/category.dart';
import 'package:love_novel/data/models/public/book.dart';

class YourBooksController extends GetxController {
  static YourBooksController get instance =>
      Get.isRegistered<YourBooksController>()
          ? Get.find()
          : Get.put(YourBooksController());

  var books = Rxn<List<Book>>();
  var genre = Rxn<Category>();
  late ScrollController scrollController;
  late CarouselController carouselController;
  static var currentIndex = 0.obs;

  move(int index) async {
    currentIndex.value = index;
    await carouselController.animateToPage(index);
  }

  @override
  void onInit() {
    super.onInit();
    carouselController = CarouselController();
  }
}
