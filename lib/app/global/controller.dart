import 'dart:developer';

import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:in_app_review/in_app_review.dart';
import 'package:love_novel/app/utils/dialogs.dart';
import 'package:love_novel/data/models/public/app_config.dart';
import 'package:love_novel/data/models/public/fullscreen_ads_cap.dart';
import 'package:love_novel/ui/pages/home/home.dart';
import 'package:love_novel/ui/pages/splash/splash.dart';

class AppController extends GetxController {
  static AppController get instance =>
      Get.isRegistered<AppController>() ? Get.find() : Get.put(AppController());
  static var connectivityResult = Rxn<ConnectivityResult>();

  static bool get hasConnection =>
      connectivityResult.value != ConnectivityResult.none;

  @override
  void onInit() {
    super.onInit();
    _watchConnection();
    init();
  }

  static Future<dynamic> toNamed(String routeName, {dynamic arguments}) async {
    currentRoute.value = routeName;
    var result = await Get.toNamed(routeName, arguments: arguments);
    return result;
  }

  static until(String routeName) {
    currentRoute.value = routeName;
    Get.until((route) => route.settings.name == routeName);
  }

  final storage = FlutterSecureStorage();
  static const _appRatingKey = "___appRated__";
  static const _firstTimestampKey = "___firstTimestamp__";
  static var firstTimestamp = 0;
  static var needToShowAppRating = false;
  final InAppReview inAppReview = InAppReview.instance;
  // TODO
  // static var isPriority = true;
  static var isPriority = false;

  static var adConfig = FullscreenAdsCap(
      minChapter: 2, minAdGapInSec: 420, videoInterstitialAlternative: true);
  static var chapterCounter = 0;
  static var videoShown = false;
  static var timeMarker = DateTime.now().millisecondsSinceEpoch;
  static AppConfig? appConfig;
  static var currentRoute = SplashPage.route.obs;
  init() async {
    await initFirstOpenApp();
    await initRatingAppCondition();
  }

  initFirstOpenApp() async {
    var r = await storage.read(key: _firstTimestampKey);
    if (r == null) {
      firstTimestamp = DateTime.now().millisecondsSinceEpoch;
      await storage.write(
          key: _firstTimestampKey, value: firstTimestamp.toString());
    } else {
      firstTimestamp = int.tryParse(r) ?? 0;
    }
  }

  initRatingAppCondition() async {
    needToShowAppRating = false;
    var r = await storage.read(key: _appRatingKey) ?? "notyet";
    print(r);
    if (r == "notyet") {
      needToShowAppRating = true;
    } else {
      // sau 7 ngay bad thi show rating = true

      var data = r.split("_");
      var type = data[0];
      if (type == "bad") {
        var timestamp = int.tryParse(data[1]) ?? 0;
        var date = DateTime.fromMillisecondsSinceEpoch(timestamp);
        var oneWeekLater = date.add(const Duration(days: 7));
        if (DateTime.now().isAfter(oneWeekLater)) {
          needToShowAppRating = true;
        }
      }
    }
  }

  appRating() async {
    if (needToShowAppRating) {
      var score = await Dialogs.showAppRating();
      // Dialogs.showProgress();
      if (score >= 5) {
        var x = await inAppReview.isAvailable();
        log(x.toString());
        if (x) {
          // await inAppReview.requestReview().catchError((error) async {
          //   await inAppReview.openStoreListing(
          //       appStoreId: 'com.napoam21.novelreadingfree.amazingstories');
          // });
          await inAppReview.openStoreListing(
              appStoreId: 'com.napoam21.novelreadingfree.amazingstories');
          await storage.write(
              key: _appRatingKey,
              value: "good_${DateTime.now().millisecondsSinceEpoch}");
          needToShowAppRating = false;
        }
      } else {
        await storage.write(
            key: _appRatingKey,
            value: "bad_${DateTime.now().millisecondsSinceEpoch}");
        needToShowAppRating = false;
      }
      // Dialogs.hideProgress();
    }
  }

  _watchConnection() async {
    connectivityResult.value = await Connectivity().checkConnectivity();
    Connectivity().onConnectivityChanged.listen((result) {
      if (connectivityResult.value != result) {
        if (result == ConnectivityResult.none) {
          Dialogs.errorSnack(
              message: "Lost internet connection",
              icon: Icon(
                Icons.wifi_off,
                color: Colors.red[700],
              ));
        } else {
          Dialogs.successSnack(
              message: "Restore network connection",
              icon: Icon(Icons.wifi, color: Colors.green[700]));
          Future.delayed(Duration(seconds: 2), () {
            AppController.toNamed(HomePage.route);
          });
        }
      }
      connectivityResult.value = result;
    });
  }
}
