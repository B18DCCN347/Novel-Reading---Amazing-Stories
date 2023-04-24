import 'package:carousel_slider/carousel_slider.dart';
import 'package:get/get.dart';
import 'package:love_novel/app/global/controller.dart';
import 'package:love_novel/app/global/hivebox_controller.dart';
import 'package:love_novel/app/global/home_category.dart';
import 'package:love_novel/data/models/category/category.dart';
import 'package:love_novel/data/models/public/config_extension.dart';
import 'package:love_novel/data/repositories/book.dart';
import 'package:love_novel/ui/pages/ads/controller.dart';
import 'package:love_novel/ui/pages/remove_ads/controller.dart';

class DiscoveryController extends GetxController {
  static DiscoveryController get instance =>
      Get.isRegistered<DiscoveryController>()
          ? Get.find()
          : Get.put(DiscoveryController());

  final appController = AppController.instance;
  final hiveBoxController = HiveBoxController.instance;
  static var carouselController = CarouselController();
  static var discoveryGenres = Rx<List<Category>>([]);
  static var configExtension = Rxn<ConfigExtension>();

  static var currentIndex = 0.obs;

  move(int index) {
    currentIndex.value = index;
    carouselController.animateToPage(index);
  }

  @override
  void onInit() {
    super.onInit();
  }

  init() async {
    var genres = <Category>[];
    discoveryGenres.value = [
      Category(id: HomeCategories.discovery, name: "Discovery"),
      Category(id: HomeCategories.hot, name: "Hot"),
      Category(id: HomeCategories.lastestRelease, name: "Lastest Release"),
      Category(id: HomeCategories.completed, name: "Completed"),
    ];
    if (!AppController.hasConnection) {
      genres = await hiveBoxController.categoryBoxRepository.safeGetAll();
    } else {
      if (AppController.appConfig == null) {
        AppController.appConfig = await BookRepository().configInfo();
        RemoveAdsController.checkToShowAds(AppController.appConfig);
      }

      genres = (AppController.appConfig?.contentCategory ?? []);
      configExtension.value = AppController.appConfig?.ext;
      await hiveBoxController.categoryBoxRepository.clear();
      genres.forEach((element) async {
        await hiveBoxController.categoryBoxRepository.add(element);
      });
    }
    genres.sort((a, b) => (a.name ?? "").compareTo(b.name ?? ""));
    discoveryGenres.value.addAll(genres);
    discoveryGenres.refresh();
  }

  getFavoriteTotalString(int total) {
    if (total < 1000)
      return total.toString();
    else if (total < 1000000) {
      return (total * 1.0 / 1000).toStringAsFixed(1) + "K";
    } else
      return (total * 1.0 / 1000000).toStringAsFixed(1) + "M";
  }
}
