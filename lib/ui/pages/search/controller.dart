import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:love_novel/app/global/controller.dart';
import 'package:love_novel/app/global/hivebox_controller.dart';
import 'package:love_novel/data/models/caches/app_cache.dart';
import 'package:love_novel/data/models/public/book.dart';
import 'package:love_novel/data/repositories/book.dart';
import 'package:love_novel/ui/pages/genres/controller.dart';
import 'package:love_novel/ui/pages/search/books.dart';

class SearchController extends GetxController {
  static SearchController get instance => Get.isRegistered<SearchController>()
      ? Get.find()
      : Get.put(SearchController());
  var books = Rxn<List<Book>>();
  var caches = Rxn<List<AppCache>>();
  var keyword = Rxn<String>();
  var keywordController = TextEditingController();
  final appController = AppController.instance;
  final hiveBoxController = HiveBoxController.instance;
  @override
  void onInit() {
    super.onInit();
    WidgetsBinding.instance.addPostFrameCallback((timer) async {
      await loadCaches();
    });
  }

  Future<void> search(String? value) async {
    keyword.value = (value ?? "").trim();
    if (keyword.value!.isNotEmpty) {
      AppController.toNamed(SearchBooksPage.route);
      var existTag = (await hiveBoxController.appCacheBoxRepository.safeGetAll())
          .firstWhereOrNull((element) => element.name == keyword.value);
      if (existTag != null) {
        await hiveBoxController.appCacheBoxRepository.deleteKey(existTag.key);
      }
      await hiveBoxController.appCacheBoxRepository
          .add(AppCache(name: keyword.value, time: DateTime.now()));
      await loadCaches();
    }
  }

  loadCaches() async {
    caches.value = (await hiveBoxController.appCacheBoxRepository.safeGetAll());
    caches.value?.sort((a, b) => (a.time.compareTo(b.time)));
    caches.refresh();
  }

  clearCaches() async {
    caches.value = (await hiveBoxController.appCacheBoxRepository.safeGetAll());
    await hiveBoxController.appCacheBoxRepository
        .deleteAll((caches.value ?? []).map((e) => e.key).toList());
    caches.value = [];
    caches.refresh();
  }

  loadBooks() async {
    var searchText = keyword.value ?? "";
    if (searchText.isNotEmpty) {
      if (AppController.hasConnection) {
        var rp = await BookRepository().search(searchText);
        var bItems = (rp?.data ?? [])
          ..forEach((element) {
            element.bindCategory(GenresController.genres.value ?? []);
          });
        var existItems = (books.value ?? []);
        bItems = bItems
            .where((element) =>
                !existItems.map((e) => e.uuid).contains(element.uuid))
            .toList();
        books.value = existItems..addAll(bItems);
        books.refresh();
      } else {
        searchText = searchText.trim().toLowerCase();
        var items = (await hiveBoxController.bookBoxRepository.safeGetAll())
            .where((element) =>
                (element.title ?? "").toLowerCase().contains(searchText) &&
                (element.description ?? "").toLowerCase().contains(searchText))
            .toList();
        books.value = items;
        books.refresh();
      }
    }
  }

  
}
