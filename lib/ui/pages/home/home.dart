import 'dart:async';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
// import 'package:applovin_max/applovin_max.dart';
// import 'package:love_novel/app/global/app_navigator.dart';
import 'package:love_novel/app/global/controller.dart';
import 'package:love_novel/app/utils/ads_admob_utils.dart';
import 'package:love_novel/ui/components/app_menu.dart';
import 'package:love_novel/ui/components/app_scaffold.dart';
import 'package:love_novel/ui/pages/ads/controller.dart';
import 'package:love_novel/ui/pages/book/controller.dart';
import 'package:love_novel/ui/pages/book/read.dart';
import 'package:love_novel/ui/pages/discovery/discovery.dart';
import 'package:love_novel/ui/pages/genres/genres.dart';
import 'package:love_novel/ui/pages/home/controller.dart';
import 'package:love_novel/ui/pages/menu/menu.dart';
import 'package:love_novel/ui/pages/remove_ads/controller.dart';
import 'package:love_novel/ui/pages/search/search.dart';
import 'package:love_novel/ui/pages/your_books/your_books.dart';
import 'package:random_string/random_string.dart';

class HomePage extends StatefulWidget {
  HomePage({
    Key? key,
  }) : super(key: key);
  static const route = '/home';

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var controller = HomeController.instance;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      // await initads();
      await init();
      // Future.delayed(const Duration(seconds: 5));
      // await AdsAdmobUtils.showOpenAd1();
    });
  }

  static var _inited = false;

  init() async {
    if (!_inited) {
      _inited = true;
      await RemoveAdsController.instance.init();
      await AdsController.instance.init();

      _initTimers();
    }
  }

  // Future<void> initads() async {
  //   RemoveAdsController.needToShowAds = true;
  //   await AdsAdmobUtils.showOpenAd1();

  //   RemoveAdsController.needToShowAds = false;
  // }

  Timer? _timer;
  Timer? _timer2;
  Timer? _timer3;
  _initTimers() {
    // _timer = Timer.periodic(Duration(seconds: 15), (timer) async {
    //   RemoveAdsController.needToShowAds = true;
    // });
    var minutes2 = randomBetween(15, 20);
    _timer2 = Timer.periodic(Duration(minutes: minutes2), (timer) async {
      if (AppController.currentRoute.value == ReadPage.route &&
          !(BookController.actionStatus.value?.hasRate ?? false)) {
        await BookController.instance.rating();
      }
    });
    var minutes3 = randomBetween(15, 20);
    if (minutes3 == minutes2) minutes3 = minutes2 + 2;
    _timer3 = Timer.periodic(Duration(minutes: minutes3), (timer) async {
      // await AppController.instance.appRating();
    });
  }

  _disposeTimers() {
    // if (_timer != null) _timer!.cancel();
    if (_timer2 != null) _timer2!.cancel();
    if (_timer3 != null) _timer3!.cancel();
  }

  @override
  void dispose() {
    _disposeTimers();
    super.dispose();
  }

  // @override
  // void didChangeDependencies() {
  //   // TODO: implement didChangeDependencies
  //   initads();
  //   super.didChangeDependencies();
  // }

  // initads() async {
  //   await AdsAdmobUtils.showOpenAd1();
  // }

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      title: "Home",
      body: CarouselSlider(
        items: [
          // Stack(
          //   children: [
          //     DiscoveryView(),
          //     Padding(
          //       padding: const EdgeInsets.all(32.0),
          //       child: IconButton(
          //           onPressed: () {
          //             AppController.toNamed(TestPage.route);
          //           },
          //           icon: Icon(Icons.telegram, size: 48,)),
          //     )
          //   ],
          // ),
          DiscoveryView(),
          GenresView(),
          SearchView(),
          YourBooksView(),
          MenuView()
        ],
        options: CarouselOptions(
            scrollPhysics: NeverScrollableScrollPhysics(),
            enlargeCenterPage: false,
            height: MediaQuery.of(context).size.height,
            viewportFraction: 1),
        carouselController: controller.carouselController,
      ),
      appMenu: Obx(() => AppMenu(
            items: [
              AppMenuItem(iconData: Icons.home, title: "Home"),
              AppMenuItem(iconData: Icons.auto_stories, title: "Category"),
              AppMenuItem(iconData: Icons.search, title: "Search"),
              AppMenuItem(iconData: Icons.book, title: "Your Books"),
              AppMenuItem(iconData: Icons.menu, title: "Me"),
            ],
            currentIndex: controller.currentIndex.value,
            onTap: controller.move,
          )),
    );
  }
}
