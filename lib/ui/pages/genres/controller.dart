import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:love_novel/data/models/category/category.dart';
import 'package:love_novel/data/models/public/book.dart';
import 'package:love_novel/data/repositories/book.dart';

class GenresController extends GetxController {
  static GenresController get instance => Get.isRegistered<GenresController>()
      ? Get.find()
      : Get.put(GenresController());

  var books = Rxn<List<Book>>();
  static var genres = Rxn<List<Category>>();
  var genre = Rxn<Category>();
  @override
  void onInit() {
    super.onInit();
    WidgetsBinding.instance.addPostFrameCallback((timer) async {
      final response = await BookRepository().categories();
      genres.value = response?.data ?? [];
      genres.refresh();
    });
  }
}
