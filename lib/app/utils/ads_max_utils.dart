import 'dart:async';
import 'dart:io';
import 'dart:math';

// import 'package:love_novel/ui/pages/ads/controller.dart';
import 'package:love_novel/ui/pages/remove_ads/controller.dart';
import 'package:applovin_max/applovin_max.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
// import 'package:firebase_core/firebase_core.dart';
// import 'firebase_config.dart';

enum AdLoadState { notLoaded, loading, loaded }

class AdsMaxUtils {
  // +Tier1: 5b589bac770ee92f
  // +Tier2: TODO
  // +Tier3: TODO
  static String get openId1 {
    if (Platform.isAndroid) {
      return "6ac9179fe8cf26e7";
    } else if (Platform.isIOS) {
      return "TODO";
    } else {
      throw UnsupportedError("Unsupported platform");
    }
  }

  static String get rewardId1 {
    if (Platform.isAndroid) {
      return "07a6ece07589a68f";
    } else if (Platform.isIOS) {
      return "TODO";
    } else {
      throw UnsupportedError("Unsupported platform");
    }
  }

  static String get rewardId2 {
    if (Platform.isAndroid) {
      return "TODO";
    } else if (Platform.isIOS) {
      return "TODO";
    } else {
      throw UnsupportedError("Unsupported platform");
    }
  }

  static String get rewardId3 {
    if (Platform.isAndroid) {
      return "TODO";
    } else if (Platform.isIOS) {
      return "TODO";
    } else {
      throw UnsupportedError("Unsupported platform");
    }
  }

  // Banner:
  // +Tier1: e2d26681207af0a2
  // +Tier2: TODO
  // +Tier3: TODO
  static String get bannerId1 {
    if (Platform.isAndroid) {
      return "fa02356a7891cfad";
    } else if (Platform.isIOS) {
      return "TODO";
    } else {
      throw UnsupportedError("Unsupported platform");
    }
  }

  static String get bannerId2 {
    if (Platform.isAndroid) {
      return "TODO";
    } else if (Platform.isIOS) {
      return "TODO";
    } else {
      throw UnsupportedError("Unsupported platform");
    }
  }

  static String get bannerId3 {
    if (Platform.isAndroid) {
      return "TODO";
    } else if (Platform.isIOS) {
      return "TODO";
    } else {
      throw UnsupportedError("Unsupported platform");
    }
  }

  // Inter:
  // +Tier1: 4fff53139a5f8d74
  // +Tier2: TODO
  // +Tier3: TODO
  static String get interstitalId1 {
    if (Platform.isAndroid) {
      return "aa8813c8a0c336ac";
    } else if (Platform.isIOS) {
      return "";
    } else {
      throw UnsupportedError("Unsupported platform");
    }
  }

  static String get interstitalId2 {
    if (Platform.isAndroid) {
      return "TODO";
    } else if (Platform.isIOS) {
      return "TODO";
    } else {
      throw UnsupportedError("Unsupported platform");
    }
  }

  static String get interstitalId3 {
    if (Platform.isAndroid) {
      return "TODO";
    } else if (Platform.isIOS) {
      return "TODO";
    } else {
      throw UnsupportedError("Unsupported platform");
    }
  }

  static int _interstitialAdGap = 10 * 1000; //10s
  static int _lastInterstitialAdShowTimestamp = 0;

  static int _rewardedAdGap = 10 * 1000; //10s
  static int _lastRewardedAdShowTimestamp = 0;

  static AdLoadState _interstitialLoadState = AdLoadState.notLoaded;
  static int _interstitialRetryAttempt = 0;
  static AdLoadState _rewardedAdLoadState = AdLoadState.notLoaded;
  static int _rewardedAdRetryAttempt = 0;
  // open ads
  static int _openAdGap = 10 * 1000; //10s
  static int _lastOpenAdShowTimestamp = 0;
  static AdLoadState _openLoadState = AdLoadState.notLoaded;

  static FirebaseAnalytics analytics = FirebaseAnalytics.instance;
  static bool loadedAOA = false;
  static Future<void> init() async {
    loadInterstitialAd1();
    loadRewardedAd1();
  }

  static Future<bool> loadOpenAd1() async {
    var completer = Completer<bool>();
    AppLovinMAX.setAppOpenAdListener(AppOpenAdListener(
      onAdLoadedCallback: (ad) {
        _openLoadState = AdLoadState.loaded;
        _lastOpenAdShowTimestamp = 0;
        loadedAOA = true;
        if (!completer.isCompleted) completer.complete(true);
      },
      onAdLoadFailedCallback: (adUnitId, error) {
        _openLoadState = AdLoadState.notLoaded;
        _lastOpenAdShowTimestamp = _lastOpenAdShowTimestamp + 1;

        int retryDelay = pow(2, min(6, _lastOpenAdShowTimestamp)).toInt();

        Future.delayed(Duration(milliseconds: retryDelay * 1000), () {
          AppLovinMAX.loadAppOpenAd(openId1);
        });

        if (completer.isCompleted) completer.complete(false);
      },
      onAdDisplayedCallback: (ad) {},
      onAdDisplayFailedCallback: (ad, error) {
        AppLovinMAX.loadAppOpenAd(openId1);
      },
      onAdClickedCallback: (ad) {},
      onAdHiddenCallback: (ad) {
        _openLoadState = AdLoadState.notLoaded;
      },
      onAdRevenuePaidCallback: (ad) {
        FirebaseAnalytics.instance.logEvent(
          name: 'ad_impression',
          parameters: <String, dynamic>{
            "ad_platform": "AppLovin",
            "ad_source": ad.networkName,
            "ad_unit_name": ad.adUnitId,
            "ad_format": ad.dspName,
            "currency": "USD",
            "value": ad.revenue
          },
        );
      },
    ));
    bool isReady = (await AppLovinMAX.isAppOpenAdReady(openId1))!;
    if (isReady) {
      return true;
    }
    AppLovinMAX.loadAppOpenAd(openId1);
    return completer.future;
  }

  // show open ads
  static Future<void> showOpenads1() async {
    // TODO: Comment for DEBUG
    if (!RemoveAdsController.needToShowAds) {
      return;
    }

    var nowTs = DateTime.now().millisecondsSinceEpoch;
    if (_lastOpenAdShowTimestamp + _openAdGap < nowTs) {
      _lastOpenAdShowTimestamp = nowTs;
    } else {
      return;
    }

    bool isReady = (await AppLovinMAX.isAppOpenAdReady(openId1))!;
    if (!isReady) {
      return;
    }

    AppLovinMAX.showAppOpenAd(openId1);
  }

  static Future<bool> loadInterstitialAd1() async {
    var completer = Completer<bool>();
    AppLovinMAX.setInterstitialListener(InterstitialListener(
      onAdLoadedCallback: (ad) {
        _interstitialLoadState = AdLoadState.loaded;
        _interstitialRetryAttempt = 0;

        if (!completer.isCompleted) completer.complete(true);
      },
      onAdLoadFailedCallback: (adUnitId, error) {
        _interstitialLoadState = AdLoadState.notLoaded;
        _interstitialRetryAttempt = _interstitialRetryAttempt + 1;

        int retryDelay = pow(2, min(6, _interstitialRetryAttempt)).toInt();

        Future.delayed(Duration(milliseconds: retryDelay * 1000), () {
          AppLovinMAX.loadInterstitial(interstitalId1);
        });

        if (completer.isCompleted) completer.complete(false);
      },
      onAdDisplayedCallback: (ad) {
        // FirebaseAnalytics.instance.logEvent(
        //   name: 'ad_impression',
        //   parameters: <String, dynamic>{
        //     "ad_platform": "AppLovin",
        //     "ad_source": ad.networkName,
        //     "ad_unit_name": ad.adUnitId,
        //     "ad_format": ad.dspName,
        //     "currency": "USD",
        //     "value": ad.revenue
        //   },
        // );
      },
      onAdDisplayFailedCallback: (ad, error) {
        _interstitialLoadState = AdLoadState.notLoaded;
      },
      onAdClickedCallback: (ad) {
        // FirebaseAnalytics.instance.logEvent(
        //   name: 'ad_impression',
        //   parameters: <String, dynamic>{
        //     "ad_platform": "AppLovin",
        //     "ad_source": ad.networkName,
        //     "ad_unit_name": ad.adUnitId,
        //     "ad_format": ad.dspName,
        //     "currency": "USD",
        //     "value": ad.revenue
        //   },
        // );
      },
      onAdRevenuePaidCallback: (ad) {
        FirebaseAnalytics.instance.logEvent(
          name: 'ad_impression',
          parameters: <String, dynamic>{
            "ad_platform": "AppLovin",
            "ad_source": ad.networkName,
            "ad_unit_name": ad.adUnitId,
            "ad_format": ad.dspName,
            "currency": "USD",
            "value": ad.revenue
          },
        );
      },
      onAdHiddenCallback: (ad) {
        _interstitialLoadState = AdLoadState.notLoaded;
      },
    ));

    bool isReady = (await AppLovinMAX.isInterstitialReady(interstitalId1))!;
    if (isReady) {
      return true;
    }
    AppLovinMAX.loadInterstitial(interstitalId1);
    return completer.future;
  }

  static Future<void> showInterstitialAd1() async {
    // TODO: Comment for DEBUG
    if (!RemoveAdsController.needToShowAds) {
      return;
    }

    var nowTs = DateTime.now().millisecondsSinceEpoch;
    if (_lastInterstitialAdShowTimestamp + _interstitialAdGap < nowTs) {
      _lastInterstitialAdShowTimestamp = nowTs;
    } else {
      return;
    }

    bool isReady = (await AppLovinMAX.isInterstitialReady(interstitalId1))!;
    if (!isReady) {
      return;
    }

    AppLovinMAX.showInterstitial(interstitalId1);
  }

  static Future<bool> loadRewardedAd1() async {
    var completer = Completer<bool>();

    /// Rewarded Ad Listeners
    AppLovinMAX.setRewardedAdListener(
      RewardedAdListener(
        onAdLoadedCallback: (ad) {
          _rewardedAdLoadState = AdLoadState.loaded;
          _rewardedAdRetryAttempt = 0;
        },
        onAdLoadFailedCallback: (adUnitId, error) {
          _rewardedAdLoadState = AdLoadState.notLoaded;

          // We recommend retrying with exponentially higher delays up to a maximum delay (in this case 64 seconds)
          _rewardedAdRetryAttempt = _rewardedAdRetryAttempt + 1;

          int retryDelay = pow(2, min(6, _rewardedAdRetryAttempt)).toInt();
          Future.delayed(Duration(milliseconds: retryDelay * 1000), () {
            AppLovinMAX.loadRewardedAd(rewardId1);
          });

          if (completer.isCompleted) completer.complete(false);
        },
        onAdDisplayedCallback: (ad) {
          // FirebaseAnalytics.instance.logEvent(
          //   name: 'ad_impression',
          //   parameters: <String, dynamic>{
          //     "ad_platform": "AppLovin",
          //     "ad_source": ad.networkName,
          //     "ad_unit_name": ad.adUnitId,
          //     "ad_format": ad.dspName,
          //     "currency": "USD",
          //     "value": ad.revenue
          //   },
          // );
        },
        onAdDisplayFailedCallback: (ad, error) {
          _rewardedAdLoadState = AdLoadState.notLoaded;
          if (completer.isCompleted) completer.complete(false);
        },
        onAdClickedCallback: (ad) {
          // FirebaseAnalytics.instance.logEvent(
          //   name: 'ad_impression',
          //   parameters: <String, dynamic>{
          //     "ad_platform": "AppLovin",
          //     "ad_source": ad.networkName,
          //     "ad_unit_name": ad.adUnitId,
          //     "ad_format": ad.dspName,
          //     "currency": "USD",
          //     "value": ad.revenue
          //   },
          // );
        },
        onAdHiddenCallback: (ad) {
          _rewardedAdLoadState = AdLoadState.notLoaded;
          if (completer.isCompleted) completer.complete(false);
        },
        onAdReceivedRewardCallback: (ad, reward) {
          // FirebaseAnalytics.instance.logEvent(
          //   name: 'ad_impression',
          //   parameters: <String, dynamic>{
          //     "ad_platform": "AppLovin",
          //     "ad_source": ad.networkName,
          //     "ad_unit_name": ad.adUnitId,
          //     "ad_format": ad.dspName,
          //     "currency": "USD",
          //     "value": ad.revenue
          //   },
          // );
          if (!completer.isCompleted) completer.complete(true);
        },
        onAdRevenuePaidCallback: (ad) {
          FirebaseAnalytics.instance.logEvent(
            name: 'ad_impression',
            parameters: <String, dynamic>{
              "ad_platform": "AppLovin",
              "ad_source": ad.networkName,
              "ad_unit_name": ad.adUnitId,
              "ad_format": ad.dspName,
              "currency": "USD",
              "value": ad.revenue
            },
          );
        },
      ),
    );

    bool isReady = (await AppLovinMAX.isRewardedAdReady(rewardId1))!;
    if (isReady) {
      return true;
    }
    _rewardedAdLoadState = AdLoadState.loading;
    AppLovinMAX.loadRewardedAd(rewardId1);
    if (!isReady) {
      return false;
    }

    return completer.future;
  }

  static Future<void> showRewardedAd1() async {
    // TODO: Comment for DEBUG
    if (!RemoveAdsController.needToShowAds) {
      return;
    }
    var nowTs = DateTime.now().millisecondsSinceEpoch;
    if (_lastRewardedAdShowTimestamp + _rewardedAdGap < nowTs) {
      _lastRewardedAdShowTimestamp = nowTs;
    } else {
      return;
    }

    bool isReady = (await AppLovinMAX.isRewardedAdReady(rewardId1))!;
    if (!isReady) {
      return;
    }

    AppLovinMAX.showRewardedAd(rewardId1);
  }

  static clearBannerAd1() async {
    // TODO
  }

  static String loadBannerAd1() {
    return bannerId1;
  }

  void dispose() {
    // TODO
  }
}
