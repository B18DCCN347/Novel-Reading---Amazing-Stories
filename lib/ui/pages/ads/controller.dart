import 'dart:developer';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:love_novel/app/global/controller.dart';
import 'package:love_novel/app/global/remote_config.dart';
import 'package:love_novel/app/utils/ads_max_utils.dart';
import 'package:love_novel/app/utils/ads_admob_utils.dart';
import 'package:love_novel/app/utils/ads_ironsource_utils.dart';
import 'package:love_novel/app/utils/dialogs.dart';
import 'package:love_novel/ui/components/app_admob_banner_ad.dart';
import 'package:love_novel/ui/components/app_max_banner_ad.dart';
import 'package:love_novel/ui/pages/book/read.dart';
import 'package:love_novel/ui/pages/remove_ads/controller.dart';

class AdsController extends GetxController {
  static AdsController get instance =>
      Get.isRegistered<AdsController>() ? Get.find() : Get.put(AdsController());

  static var addShowTimes = 0.obs;
  static final storage = FlutterSecureStorage();
  static const _AdCtrKey = "__AddShowTimes__";
  static var bannerAd = Rxn<Widget>();
  static var bannerAdAvailable = false.obs;

  static var _bannerAdGap = 2 * 1000;
  static var _lastBannerAdShowTimestamp = 0;
  static var _videoAdGap = 2 * 1000;
  static var _lastVideoAdShowTimestamp = 0;
  static var _interstititalAdGap = 2 * 1000;
  static var _lastInterstitialShowTimestamp = 0;
  static var fullscreenShowing = false;
  static double? prevTime;
  static double time = 0.0;
  static bool get isISLoadFirst =>
      Platform.isAndroid && AppController.isPriority;

  Future init() async {
    // TODO: Comment for DEBUG
    if (!RemoveAdsController.needToShowAds) {
      return;
    }
    var times = await storage.read(key: _AdCtrKey) ?? "0";
    addShowTimes.value = int.tryParse(times) ?? 0;
    await AdsIronSourceUtils.init();
    await AdsAdmobUtils.init();
    await AdsMaxUtils.init();
    if (RemoteAds.adsBanner) {
      await loadBannerAd();
    }
  }

  static bool checkBannerGap() {
    reShowBannerAds();
    var nowTs = DateTime.now().millisecondsSinceEpoch;
    if (_lastBannerAdShowTimestamp + _bannerAdGap < nowTs) {
      _lastBannerAdShowTimestamp = nowTs;
      return true;
    } else {
      return false;
    }
  }

  static bool checkVideoAdGap() {
    var nowTs = DateTime.now().millisecondsSinceEpoch;
    if (_lastVideoAdShowTimestamp + _videoAdGap < nowTs) {
      _lastVideoAdShowTimestamp = nowTs;
      return true;
    } else {
      return false;
    }
  }

  static bool checkInterstitialAdGap() {
    var nowTs = DateTime.now().millisecondsSinceEpoch;
    if (_lastInterstitialShowTimestamp + _interstititalAdGap < nowTs) {
      _lastInterstitialShowTimestamp = nowTs;
      return true;
    } else {
      return false;
    }
  }

  static cleanBannerAds() async {
    // TODO: Comment for DEBUG
    if (!RemoveAdsController.needToShowAds) {
      return;
    }

    // REMOVED: Change to AppLovin
    // if (isISLoadFirst) {
    //   await AdsIronSourceUtils.clearBannerAd();
    // } else {
    //   await AdsMaxUtils.clearBannerAd1();
    //   await AdsAdmobUtils.clearBannerAd1();
    // }

    // ADDED: Change to AppLovin
    await AdsMaxUtils.clearBannerAd1();
  }

  static reShowBannerAds() async {
    bannerAdAvailable.value = false;
    await Future.delayed(const Duration(seconds: 1));
    bannerAdAvailable.value = true;
  }

  static loadMaxBannerAd() async {
    await reShowBannerAds();
    String adUnitId = AdsMaxUtils.loadBannerAd1();
    bannerAd.value = AppMaxBannerAd(adUnitId: adUnitId);
    bannerAd.refresh();
  }

  static loadAdmobBannerAd() async {
    await reShowBannerAds();
    var banner = await AdsAdmobUtils.loadBannerAd1();
    if (banner != null) {
      bannerAd.value = AppAdmobBannerAd(ad: banner);
      bannerAd.refresh();
    }
  }

  static loadIronSourceBannerAd() async {
    await reShowBannerAds();
    var banner = await AdsIronSourceUtils.loadBannerAd();
    if (banner != null) {
      bannerAd.value = banner;
      bannerAd.refresh();
    }
  }

  static loadBannerAd() async {
    bannerAdAvailable.value = false;

    // TODO: Comment for DEBUG
    if (!RemoveAdsController.needToShowAds) {
      return;
    }

    var ok = checkBannerGap();
    if (!ok) {
      return;
    }

    // REMOVED: Change to AppLovin
    // if (isISLoadFirst) {
    //   await loadIronSourceBannerAd();
    // } else {
    //   await loadAdmobBannerAd();
    // }

    // ADDED: Change to AppLovin
    await loadMaxBannerAd();
    bannerAdAvailable.value = true;
  }

  // ADDED: AppLovin Ads (Interstitial)
  static showMaxInterstitial() async {
    // TODO: Comment for DEBUG
    if (!RemoveAdsController.needToShowAds) {
      return;
    }

    var loaded = await AdsMaxUtils.loadInterstitialAd1();
    if (loaded) {
      await AdsMaxUtils.showInterstitialAd1();
    }
  }

  static showAdmobInterstitial() async {
    // TODO: Comment for DEBUG
    if (!RemoveAdsController.needToShowAds) {
      return;
    }

    var loaded = await AdsAdmobUtils.loadInterstitialAd1();
    if (loaded) {
      await AdsAdmobUtils.showInterstitialAd1();
    }
  }

  static showIronSourceInterstitial() async {
    // TODO: Comment for DEBUG
    if (!RemoveAdsController.needToShowAds) {
      return;
    }
    await AdsIronSourceUtils.showInterstitialAd();
  }

  static increaseAdshowTimes() async {
    addShowTimes++;
    if (addShowTimes.value >= 6) {
      await Dialogs.showRemoveAds();
      addShowTimes.value = 1;
    }
    await storage.write(key: _AdCtrKey, value: addShowTimes.value.toString());
  }

  static showInterstital() async {
    // TODO: Comment for DEBUG
    if (!RemoveAdsController.needToShowAds) {
      return;
    }

    var ok = checkInterstitialAdGap();
    if (!ok) {
      return;
    }
    fullscreenShowing = true;

    // REMOVED: Change to AppLovin
    // if (isISLoadFirst) {
    //   await showIronSourceInterstitial();
    // } else {
    //   await showAdmobInterstitial();
    // }

    // ADDED: Change to AppLovin
    await showMaxInterstitial();

    await increaseAdshowTimes();
  }

  // ADDED: AppLovin Ads (Rewarded)
  static showMaxRewardedVideo() async {
    // TODO: Comment for DEBUG
    if (!RemoveAdsController.needToShowAds) {
      return;
    }
    var loaded = await AdsMaxUtils.loadRewardedAd1();
    var seconds = 2;
    while (!loaded) {
      if (seconds == 64) break;
      await Future.delayed(Duration(seconds: seconds *= 2));
      loaded = await AdsMaxUtils.loadRewardedAd1();
      if (loaded) seconds = 2;
    }
    await AdsMaxUtils.showRewardedAd1();
  }

  static showAdmobRewardedVideo() async {
    // TODO: Comment for DEBUG
    if (!RemoveAdsController.needToShowAds) {
      return;
    }
    var loaded = await AdsAdmobUtils.loadRewardedAd1();
    if (loaded) {
      await AdsAdmobUtils.showRewardedAd1();
    }
  }

  static showIronSourceRewardedVideo() async {
    // TODO: Comment for DEBUG
    if (!RemoveAdsController.needToShowAds) {
      return;
    }

    await AdsIronSourceUtils.loadRewardedAd();
    await AdsIronSourceUtils.showRewardedAd();
  }

  static Future<bool> showRewardedVideo() async {
    // TODO: Comment for DEBUG
    if (!RemoveAdsController.needToShowAds) {
      return false;
    }

    var ok = checkVideoAdGap();
    if (!ok) {
      return false;
    }
    fullscreenShowing = true;

    // REMOVED: Change to AppLovin
    // if (isISLoadFirst) {
    //   await showIronSourceRewardedVideo();
    // } else {
    //   await showAdmobRewardedVideo();
    // }

    // ADDED: Change to AppLovin
    await showMaxRewardedVideo();

    await increaseAdshowTimes();
    return true;
  }

  static showAdWhenReading() async {
    if (AppController.currentRoute.value != ReadPage.route) {
      return;
    }

    var now = DateTime.now().microsecondsSinceEpoch;

    // if (((now - AppController.timeMarker) / Duration.microsecondsPerSecond +
    //             160 <=
    //         (AppController.adConfig.minAdGapInSec ?? 420)) &&
    //     (AppController.chapterCounter <=
    //         (AppController.adConfig.minChapter ?? 2))) {
    //   return;
    // } else if (((now - AppController.timeMarker) /
    //                 Duration.microsecondsPerSecond +
    //             160 >
    //         (AppController.adConfig.minAdGapInSec ?? 420)) ||
    //     (AppController.chapterCounter >
    //         (AppController.adConfig.minChapter ?? 2))) {
    //   AppController.timeMarker = now;
    //   AppController.chapterCounter = 0;
    //   await showInterstital();
    // }

    time = (now - AppController.timeMarker) / Duration.microsecondsPerSecond +
        (prevTime ?? 0.0);
    log((time).toString());
    if (((time) < (AppController.adConfig.minAdGapInSec ?? 420)) ||
        !RemoteAds.adsInters) {
      return;
    }
    // else if ((AppController.chapterCounter >
    //     (AppController.adConfig.minChapter ?? 2))) {

    // } else {
    //   return;
    // }
    // if (AppController.chapterCounter <=
    //     (AppController.adConfig.minChapter ?? 2)) {
    //   return;
    // } else {
    //   AppController.timeMarker = now;
    //   AppController.chapterCounter = 0;
    //   await showInterstital();
    // }

    AppController.timeMarker = now;
    AdsController.prevTime = 0.0;
    AppController.chapterCounter = 0;
    await showInterstital();
  }
}
