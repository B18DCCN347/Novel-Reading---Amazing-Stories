import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:love_novel/app/utils/ads_ironsource_utils.dart';
import 'package:love_novel/ui/pages/ads/controller.dart';
import 'package:love_novel/ui/pages/remove_ads/controller.dart';

class AdsAdmobUtils {
//   Openads

  // Tier1: ca-app-pub-1839004489502882/1821851234
  // Tier2: ca-app-pub-1839004489502882/4256442888
  // Tier3: ca-app-pub-1839004489502882/1438707859
  // test open ads : ca-app-pub-3940256099942544/3419835294
  static String get openId1 {
    if (Platform.isAndroid) {
      return "ca-app-pub-8683682773656447/1176175596";
    } else if (Platform.isIOS) {
      return "ca-app-pub-8683682773656447/1176175596";
    } else {
      throw UnsupportedError("Unsupported platform");
    }
  }

  static String get openId2 {
    if (Platform.isAndroid) {
      return "ca-app-pub-8683682773656447/1176175596";
    } else if (Platform.isIOS) {
      return "ca-app-pub-8683682773656447/1176175596";
    } else {
      throw UnsupportedError("Unsupported platfor   m");
    }
  }

  static String get openId3 {
    if (Platform.isAndroid) {
      return "ca-app-pub-8683682773656447/8310174552";
    } else if (Platform.isIOS) {
      return "ca-app-pub-8683682773656447/8310174552";
    } else {
      throw UnsupportedError("Unsupported platform");
    }
  }

// Rewar
// +Tier1: ca-app-pub-1839004489502882/8468035775
// +Tier2: ca-app-pub-1839004489502882/9080325581
// +Tier3: ca-app-pub-1839004489502882/7767243911
  static String get rewardId1 {
    if (Platform.isAndroid) {
      return "ca-app-pub-1839004489502882/8468035775";
    } else if (Platform.isIOS) {
      return "ca-app-pub-1839004489502882/1198139203";
    } else {
      throw UnsupportedError("Unsupported platform");
    }
  }

  static String get rewardId2 {
    if (Platform.isAndroid) {
      return "ca-app-pub-1839004489502882/9080325581";
    } else if (Platform.isIOS) {
      return "ca-app-pub-1839004489502882/1198139203";
    } else {
      throw UnsupportedError("Unsupported platform");
    }
  }

  static String get rewardId3 {
    if (Platform.isAndroid) {
      return "ca-app-pub-1839004489502882/7767243911";
    } else if (Platform.isIOS) {
      return "ca-app-pub-1839004489502882/1198139203";
    } else {
      throw UnsupportedError("Unsupported platform");
    }
  }

// Banner:
// +Tier1: ca-app-pub-1839004489502882/8081022966
// +Tier2: ca-app-pub-1839004489502882/2094199116
// +Tier3: ca-app-pub-1839004489502882/6767941292
  static String get bannerId1 {
    if (Platform.isAndroid) {
      return "ca-app-pub-1839004489502882/8081022966";
    } else if (Platform.isIOS) {
      return "ca-app-pub-1839004489502882/1374271164";
    } else {
      throw UnsupportedError("Unsupported platform");
    }
  }

  static String get bannerId2 {
    if (Platform.isAndroid) {
      return "ca-app-pub-1839004489502882/2094199116";
    } else if (Platform.isIOS) {
      return "ca-app-pub-1839004489502882/1374271164";
    } else {
      throw UnsupportedError("Unsupported platform");
    }
  }

  static String get bannerId3 {
    if (Platform.isAndroid) {
      return "ca-app-pub-1839004489502882/6767941292";
    } else if (Platform.isIOS) {
      return "ca-app-pub-1839004489502882/1374271164";
    } else {
      throw UnsupportedError("Unsupported platform");
    }
  }

// Inter:
// +Tier1: ca-app-pub-1839004489502882/9202532944
// +Tier2:ca-app-pub-1839004489502882/7889451279
// +Tier3:ca-app-pub-1839004489502882/1393407259
  static String get interstitalId1 {
    if (Platform.isAndroid) {
      return "ca-app-pub-1839004489502882/9202532944";
    } else if (Platform.isIOS) {
      return "ca-app-pub-1839004489502882/2511220873";
    } else {
      throw UnsupportedError("Unsupported platform");
    }
  }

  static String get interstitalId2 {
    if (Platform.isAndroid) {
      return "ca-app-pub-1839004489502882/7889451279";
    } else if (Platform.isIOS) {
      return "ca-app-pub-1839004489502882/2511220873";
    } else {
      throw UnsupportedError("Unsupported platform");
    }
  }

  static String get interstitalId3 {
    if (Platform.isAndroid) {
      return "ca-app-pub-1839004489502882/1393407259";
    } else if (Platform.isIOS) {
      return "ca-app-pub-1839004489502882/2511220873";
    } else {
      throw UnsupportedError("Unsupported platform");
    }
  }

  // test
  static String get nativeAdUnitId {
    if (Platform.isAndroid) {
      return 'ca-app-pub-3940256099942544/2247696110';
    } else if (Platform.isIOS) {
      return 'ca-app-pub-3940256099942544/3986624511';
    }
    throw UnsupportedError("Unsupported platform");
  }

  static AppOpenAd? openAd1;
  static AppOpenAd? openAd2;
  static AppOpenAd? openAd3;
  static int _openAdGap = 10 * 1000; //10s
  static int _lastOpenAdShowTimestamp = 0;

  static InterstitialAd? _interstitialAd1;
  static InterstitialAd? _interstitialAd2;
  static InterstitialAd? _interstitialAd3;
  static int _interstitialAdGap = 10 * 1000; //10s
  static int _lastInterstitialAdShowTimestamp = 0;

  static RewardedAd? _rewardedAd1;
  static RewardedAd? _rewardedAd2;
  static RewardedAd? _rewardedAd3;
  static int _rewardedAdGap = 10 * 1000; //10s
  static int _lastRewardedAdShowTimestamp = 0;

  static BannerAd? bannerAd1;
  static BannerAd? bannerAd2;
  static BannerAd? bannerAd3;
  static int _bannerAdGap = 10 * 1000; //10s
  static int _lastBannerAdShowTimestamp = 0;

  static var request = const AdRequest();

  static int _numInterstitialLoadAttempts = 0;
  static int _maxAttempts = 0;
  static int _numRewardedLoadAttempts = 0;
  static bool loadedAOA = false;

  static Future<bool> loadOpenAd1() async {
    var completer = Completer<bool>();
    if (!RemoveAdsController.needToShowAds) {
      return false;
    }
    // Xu ly load
    await AppOpenAd.load(
      adUnitId: openId1,
      request: const AdRequest(),
      // Call back
      adLoadCallback: AppOpenAdLoadCallback(
        // khi loat xong
        onAdLoaded: (ad) {
          loadedAOA = true;
          openAd1 = ad;
          //
          if (!completer.isCompleted) completer.complete(true);
        },
        onAdFailedToLoad: (error) {
          debugPrint(error.toString());
          if (!completer.isCompleted) completer.complete(false);
        },
      ),
      orientation: AppOpenAd.orientationPortrait,
    ).catchError((error) {
      if (!completer.isCompleted) {
        completer.complete(false);
      }
    });
    return completer.future;
  }

  static Future<void> showOpenAd1() async {
    if (!RemoveAdsController.needToShowAds) {
      return;
    }
    if (openAd1 == null) {
      var result = await loadOpenAd1();
    }
    var nowTs = DateTime.now().millisecondsSinceEpoch;
    if (_lastOpenAdShowTimestamp + _openAdGap < nowTs) {
      _lastOpenAdShowTimestamp = nowTs;
    } else {
      return;
    }
    if (openAd1 == null) {
      await showOpenAd2();
      return;
    }
    openAd1!.fullScreenContentCallback = FullScreenContentCallback(
        onAdShowedFullScreenContent: (ad) {},
        onAdFailedToShowFullScreenContent: (ad, error) async {
          debugPrint(error.toString());
          ad.dispose();
          openAd1 = null;
          await loadOpenAd1();
        },
        onAdDismissedFullScreenContent: (ad) async {
          ad.dispose();
          openAd1 = null;
          await loadOpenAd1();
        });
    openAd1!.show();
  }

  static Future<bool> loadOpenAd2() async {
    var completer = Completer<bool>();
    if (!RemoveAdsController.needToShowAds) {
      return false;
    }
    await AppOpenAd.load(
      adUnitId: openId2,
      request: const AdRequest(),
      adLoadCallback: AppOpenAdLoadCallback(
        onAdLoaded: (ad) {
          openAd2 = ad;
          loadedAOA = true;
          if (!completer.isCompleted) completer.complete(true);
        },
        onAdFailedToLoad: (error) {
          debugPrint(error.toString());
          if (!completer.isCompleted) completer.complete(false);
        },
      ),
      orientation: AppOpenAd.orientationPortrait,
    ).catchError((error) {
      if (!completer.isCompleted) completer.complete(false);
    });
    return completer.future;
  }

  static Future<void> showOpenAd2() async {
    if (!RemoveAdsController.needToShowAds) {
      return;
    }
    if (openAd2 == null) {
      var result = await loadOpenAd2();
    }
    if (openAd2 == null) {
      await showOpenAd3();
      return;
    }
    openAd2!.fullScreenContentCallback = FullScreenContentCallback(
        onAdShowedFullScreenContent: (ad) {},
        onAdFailedToShowFullScreenContent: (ad, error) async {
          debugPrint(error.toString());
          ad.dispose();
          openAd2 = null;
          await loadOpenAd2();
        },
        onAdDismissedFullScreenContent: (ad) async {
          ad.dispose();
          openAd2 = null;
          await loadOpenAd2();
        });
    openAd2!.show();
  }

  static Future<bool> loadOpenAd3() async {
    var completer = Completer<bool>();
    if (!RemoveAdsController.needToShowAds) {
      return false;
    }
    await AppOpenAd.load(
      adUnitId: openId3,
      request: const AdRequest(),
      adLoadCallback: AppOpenAdLoadCallback(
        onAdLoaded: (ad) {
          openAd3 = ad;
          loadedAOA = true;
          if (!completer.isCompleted) completer.complete(true);
        },
        onAdFailedToLoad: (error) {
          debugPrint(error.toString());
          if (!completer.isCompleted) completer.complete(false);
        },
      ),
      orientation: AppOpenAd.orientationPortrait,
    ).catchError((error) {
      if (!completer.isCompleted) completer.complete(false);
    });
    return completer.future;
  }

  static Future<void> showOpenAd3() async {
    if (!RemoveAdsController.needToShowAds) {
      return;
    }
    if (openAd3 == null) {
      var result = await loadOpenAd3();
    }
    if (openAd3 == null) {
      // await showOpenAd1();
      return;
    }
    openAd3!.fullScreenContentCallback = FullScreenContentCallback(
        onAdShowedFullScreenContent: (ad) {},
        onAdFailedToShowFullScreenContent: (ad, error) async {
          debugPrint(error.toString());
          ad.dispose();
          openAd3 = null;
          await loadOpenAd3();
        },
        onAdDismissedFullScreenContent: (ad) async {
          ad.dispose();
          openAd3 = null;
          await loadOpenAd3();
        });
    openAd3!.show();
  }

  static Future<void> init() async {
    await loadInterstitialAd1();
    await loadRewardedAd1();
  }

  static Future<bool> loadInterstitialAd1() async {
    var completer = Completer<bool>();
    if (_interstitialAd1 != null) {
      _interstitialAd1?.dispose();
      _interstitialAd1 = null;
    }
    await InterstitialAd.load(
        adUnitId: interstitalId1,
        request: request,
        adLoadCallback: InterstitialAdLoadCallback(
          onAdLoaded: (InterstitialAd ad) {
            print('$ad loaded');
            _interstitialAd1 = ad;
            _numInterstitialLoadAttempts = 0;
            _interstitialAd1!.setImmersiveMode(true);
            if (!completer.isCompleted) completer.complete(true);
          },
          onAdFailedToLoad: (LoadAdError error) {
            print('InterstitialAd failed to load: $error.');
            _numInterstitialLoadAttempts += 1;
            _interstitialAd1 = null;
            if (_numInterstitialLoadAttempts < _maxAttempts) {
              loadInterstitialAd1();
            }
            if (!completer.isCompleted) completer.complete(false);
          },
        )).catchError((error) {
      if (!completer.isCompleted) completer.complete(false);
    });
    return completer.future;
  }

  static Future<void> showInterstitialAd1() async {
    if (!RemoveAdsController.needToShowAds) {
      return;
    }
    if (_interstitialAd1 == null) {
      var result = await loadInterstitialAd1();
    }
    var nowTs = DateTime.now().millisecondsSinceEpoch;
    if (_lastInterstitialAdShowTimestamp + _interstitialAdGap < nowTs) {
      _lastInterstitialAdShowTimestamp = nowTs;
    } else {
      return;
    }
    if (_interstitialAd1 == null) {
      await showInterstitialAd2();
      return;
    }
    _interstitialAd1!.fullScreenContentCallback = FullScreenContentCallback(
      onAdShowedFullScreenContent: (InterstitialAd ad) =>
          print('ad onAdShowedFullScreenContent.'),
      onAdDismissedFullScreenContent: (InterstitialAd ad) {
        print('$ad onAdDismissedFullScreenContent.');
        ad.dispose();
        loadInterstitialAd1();
      },
      onAdFailedToShowFullScreenContent: (InterstitialAd ad, AdError error) {
        print('$ad onAdFailedToShowFullScreenContent: $error');
        ad.dispose();
        loadInterstitialAd1();
      },
    );

    await _interstitialAd1!.show();
    _interstitialAd1 = null;
  }

  static Future<bool> loadInterstitialAd2() async {
    var completer = Completer<bool>();
    if (_interstitialAd2 != null) {
      _interstitialAd2?.dispose();
      _interstitialAd2 = null;
    }
    await InterstitialAd.load(
        adUnitId: interstitalId2,
        request: request,
        adLoadCallback: InterstitialAdLoadCallback(
          onAdLoaded: (InterstitialAd ad) {
            print('$ad loaded');
            _interstitialAd2 = ad;
            _numInterstitialLoadAttempts = 0;
            _interstitialAd2!.setImmersiveMode(true);
            if (!completer.isCompleted) completer.complete(true);
          },
          onAdFailedToLoad: (LoadAdError error) {
            print('InterstitialAd failed to load: $error.');
            _numInterstitialLoadAttempts += 1;
            _interstitialAd2 = null;
            if (_numInterstitialLoadAttempts < _maxAttempts) {
              loadInterstitialAd2();
            }
            if (!completer.isCompleted) completer.complete(false);
          },
        )).catchError((error) {
      if (!completer.isCompleted) completer.complete(false);
    });
    return completer.future;
  }

  static Future<void> showInterstitialAd2() async {
    if (!RemoveAdsController.needToShowAds) {
      return;
    }
    if (_interstitialAd2 == null) {
      var result = await loadInterstitialAd2();
    }
    var nowTs = DateTime.now().millisecondsSinceEpoch;
    if (_lastInterstitialAdShowTimestamp + _interstitialAdGap < nowTs) {
      _lastInterstitialAdShowTimestamp = nowTs;
    } else {
      return;
    }
    if (_interstitialAd2 == null) {
      await showInterstitialAd3();
      return;
    }
    _interstitialAd2!.fullScreenContentCallback = FullScreenContentCallback(
      onAdShowedFullScreenContent: (InterstitialAd ad) =>
          print('ad onAdShowedFullScreenContent.'),
      onAdDismissedFullScreenContent: (InterstitialAd ad) {
        print('$ad onAdDismissedFullScreenContent.');
        ad.dispose();
        loadInterstitialAd2();
      },
      onAdFailedToShowFullScreenContent: (InterstitialAd ad, AdError error) {
        print('$ad onAdFailedToShowFullScreenContent: $error');
        ad.dispose();
        loadInterstitialAd2();
      },
    );
    await _interstitialAd2!.show();
    _interstitialAd2 = null;
  }

  static Future<bool> loadInterstitialAd3() async {
    var completer = Completer<bool>();
    if (_interstitialAd3 != null) {
      _interstitialAd3?.dispose();
      _interstitialAd3 = null;
    }
    await InterstitialAd.load(
        adUnitId: interstitalId3,
        request: request,
        adLoadCallback: InterstitialAdLoadCallback(
          onAdLoaded: (InterstitialAd ad) {
            print('$ad loaded');
            _interstitialAd3 = ad;
            _numInterstitialLoadAttempts = 0;
            _interstitialAd3!.setImmersiveMode(true);
            if (!completer.isCompleted) completer.complete(true);
          },
          onAdFailedToLoad: (LoadAdError error) {
            print('InterstitialAd failed to load: $error.');
            _numInterstitialLoadAttempts += 1;
            _interstitialAd3 = null;
            if (_numInterstitialLoadAttempts < _maxAttempts) {
              loadInterstitialAd3();
            }
            if (!completer.isCompleted) completer.complete(false);
          },
        )).catchError((error) {
      if (!completer.isCompleted) completer.complete(false);
    });
    return completer.future;
  }

  static Future<void> showInterstitialAd3() async {
    if (!RemoveAdsController.needToShowAds) {
      return;
    }
    if (_interstitialAd3 == null) {
      var result = await loadInterstitialAd3();
    }
    var nowTs = DateTime.now().millisecondsSinceEpoch;
    if (_lastInterstitialAdShowTimestamp + _interstitialAdGap < nowTs) {
      _lastInterstitialAdShowTimestamp = nowTs;
    } else {
      return;
    }
    if (_interstitialAd3 == null) {
      await AdsController.showIronSourceInterstitial();
      return;
    }
    _interstitialAd3!.fullScreenContentCallback = FullScreenContentCallback(
      onAdShowedFullScreenContent: (InterstitialAd ad) =>
          print('ad onAdShowedFullScreenContent.'),
      onAdDismissedFullScreenContent: (InterstitialAd ad) {
        print('$ad onAdDismissedFullScreenContent.');
        ad.dispose();
        loadInterstitialAd3();
      },
      onAdFailedToShowFullScreenContent: (InterstitialAd ad, AdError error) {
        print('$ad onAdFailedToShowFullScreenContent: $error');
        ad.dispose();
        loadInterstitialAd3();
      },
    );
    await _interstitialAd3!.show();
    _interstitialAd3 = null;
  }

  static Future<bool> loadRewardedAd1() async {
    var completer = Completer<bool>();
    if (_rewardedAd1 != null) {
      _rewardedAd1?.dispose();
      _rewardedAd1 = null;
    }
    await RewardedAd.load(
        adUnitId: rewardId1,
        request: request,
        rewardedAdLoadCallback: RewardedAdLoadCallback(
          onAdLoaded: (RewardedAd ad) {
            print('$ad loaded.');
            _rewardedAd1 = ad;
            _numRewardedLoadAttempts = 0;
            if (!completer.isCompleted) completer.complete(true);
          },
          onAdFailedToLoad: (LoadAdError error) {
            print('RewardedAd failed to load: $error');
            _rewardedAd1 = null;
            _numRewardedLoadAttempts += 1;
            if (_numRewardedLoadAttempts < _maxAttempts) {
              loadRewardedAd1();
            }
            if (!completer.isCompleted) completer.complete(false);
          },
        )).catchError((error) {
      if (!completer.isCompleted) completer.complete(false);
    });
    return completer.future;
  }

  static Future<void> showRewardedAd1() async {
    if (!RemoveAdsController.needToShowAds) {
      return;
    }
    if (_rewardedAd1 == null) {
      var result = await loadRewardedAd1();
    }
    var nowTs = DateTime.now().millisecondsSinceEpoch;
    if (_lastRewardedAdShowTimestamp + _rewardedAdGap < nowTs) {
      _lastRewardedAdShowTimestamp = nowTs;
    } else {
      return;
    }
    if (_rewardedAd1 == null) {
      await showRewardedAd2();
      return;
    }
    _rewardedAd1!.fullScreenContentCallback = FullScreenContentCallback(
      onAdShowedFullScreenContent: (RewardedAd ad) =>
          print('ad onAdShowedFullScreenContent.'),
      onAdDismissedFullScreenContent: (RewardedAd ad) {
        print('$ad onAdDismissedFullScreenContent.');
        ad.dispose();
        loadRewardedAd1();
      },
      onAdFailedToShowFullScreenContent: (RewardedAd ad, AdError error) {
        print('$ad onAdFailedToShowFullScreenContent: $error');
        ad.dispose();
        loadRewardedAd1();
      },
    );

    _rewardedAd1!.setImmersiveMode(true);
    await _rewardedAd1!.show(
        onUserEarnedReward: (AdWithoutView ad, RewardItem reward) {
      print('$ad with reward $RewardItem(${reward.amount}, ${reward.type})');
    });
    _rewardedAd1 = null;
  }

  static Future<bool> loadRewardedAd2() async {
    var completer = Completer<bool>();
    if (_rewardedAd2 != null) {
      _rewardedAd2?.dispose();
      _rewardedAd2 = null;
    }
    await RewardedAd.load(
        adUnitId: rewardId2,
        request: request,
        rewardedAdLoadCallback: RewardedAdLoadCallback(
          onAdLoaded: (RewardedAd ad) {
            print('$ad loaded.');
            _rewardedAd2 = ad;
            _numRewardedLoadAttempts = 0;
            if (!completer.isCompleted) completer.complete(true);
          },
          onAdFailedToLoad: (LoadAdError error) {
            print('RewardedAd failed to load: $error');
            _rewardedAd2 = null;
            _numRewardedLoadAttempts += 1;
            if (_numRewardedLoadAttempts < _maxAttempts) {
              loadRewardedAd2();
            }
            if (!completer.isCompleted) completer.complete(false);
          },
        )).catchError((error) {
      if (!completer.isCompleted) completer.complete(false);
    });
    return completer.future;
  }

  static Future<void> showRewardedAd2() async {
    if (!RemoveAdsController.needToShowAds) {
      return;
    }
    if (_rewardedAd2 == null) {
      var result = await loadRewardedAd2();
    }
    var nowTs = DateTime.now().millisecondsSinceEpoch;
    if (_lastRewardedAdShowTimestamp + _rewardedAdGap < nowTs) {
      _lastRewardedAdShowTimestamp = nowTs;
    } else {
      return;
    }
    if (_rewardedAd2 == null) {
      await showRewardedAd3();
      return;
    }
    _rewardedAd2!.fullScreenContentCallback = FullScreenContentCallback(
      onAdShowedFullScreenContent: (RewardedAd ad) =>
          print('ad onAdShowedFullScreenContent.'),
      onAdDismissedFullScreenContent: (RewardedAd ad) {
        print('$ad onAdDismissedFullScreenContent.');
        ad.dispose();
        loadRewardedAd2();
      },
      onAdFailedToShowFullScreenContent: (RewardedAd ad, AdError error) {
        print('$ad onAdFailedToShowFullScreenContent: $error');
        ad.dispose();
        loadRewardedAd2();
      },
    );

    _rewardedAd2!.setImmersiveMode(true);
    await _rewardedAd2!.show(
        onUserEarnedReward: (AdWithoutView ad, RewardItem reward) {
      print('$ad with reward $RewardItem(${reward.amount}, ${reward.type})');
    });
    _rewardedAd2 = null;
  }

  static Future<bool> loadRewardedAd3() async {
    var completer = Completer<bool>();
    if (_rewardedAd3 != null) {
      _rewardedAd3?.dispose();
      _rewardedAd3 = null;
    }
    await RewardedAd.load(
        adUnitId: rewardId3,
        request: request,
        rewardedAdLoadCallback: RewardedAdLoadCallback(
          onAdLoaded: (RewardedAd ad) {
            print('$ad loaded.');
            _rewardedAd3 = ad;
            _numRewardedLoadAttempts = 0;
            if (!completer.isCompleted) completer.complete(true);
          },
          onAdFailedToLoad: (LoadAdError error) {
            print('RewardedAd failed to load: $error');
            _rewardedAd3 = null;
            _numRewardedLoadAttempts += 1;
            if (_numRewardedLoadAttempts < _maxAttempts) {
              loadRewardedAd3();
            }
            if (!completer.isCompleted) completer.complete(false);
          },
        )).catchError((error) {
      if (!completer.isCompleted) completer.complete(false);
    });
    return completer.future;
  }

  static Future<void> showRewardedAd3() async {
    if (!RemoveAdsController.needToShowAds) {
      return;
    }
    if (_rewardedAd3 == null) {
      var result = await loadRewardedAd3();
    }
    var nowTs = DateTime.now().millisecondsSinceEpoch;
    if (_lastRewardedAdShowTimestamp + _rewardedAdGap < nowTs) {
      _lastRewardedAdShowTimestamp = nowTs;
    } else {
      return;
    }
    if (_rewardedAd3 == null) {
      await AdsController.showIronSourceRewardedVideo();
      return;
    }
    _rewardedAd3!.fullScreenContentCallback = FullScreenContentCallback(
      onAdShowedFullScreenContent: (RewardedAd ad) =>
          print('ad onAdShowedFullScreenContent.'),
      onAdDismissedFullScreenContent: (RewardedAd ad) {
        print('$ad onAdDismissedFullScreenContent.');
        ad.dispose();
        loadRewardedAd3();
      },
      onAdFailedToShowFullScreenContent: (RewardedAd ad, AdError error) {
        print('$ad onAdFailedToShowFullScreenContent: $error');
        ad.dispose();
        loadRewardedAd3();
      },
    );

    _rewardedAd3!.setImmersiveMode(true);
    await _rewardedAd3!.show(
        onUserEarnedReward: (AdWithoutView ad, RewardItem reward) {
      print('$ad with reward $RewardItem(${reward.amount}, ${reward.type})');
    });
    _rewardedAd3 = null;
  }

  static clearBannerAd1() async {
    if (bannerAd1 != null) {
      await bannerAd1!.dispose();
      bannerAd1 = null;
    }
  }

  static Future<BannerAd?> loadBannerAd1() async {
    var completer = Completer<BannerAd?>();
    await clearBannerAd1();
    bannerAd1 = BannerAd(
      size: AdSize.banner,
      adUnitId: bannerId1,
      listener: BannerAdListener(
        onAdLoaded: (_) async {
          if (!completer.isCompleted) completer.complete(bannerAd1);
        },
        onAdFailedToLoad: (ad, error) async {
          if (!completer.isCompleted) {
            var result = await loadBannerAd2();
            completer.complete(result);
          }
        },
      ),
      request: AdRequest(),
    );
    await bannerAd1?.load().catchError((error) {
      if (!completer.isCompleted) completer.complete(null);
    });
    return completer.future;
  }

  static clearBannerAd2() async {
    if (bannerAd2 != null) {
      await bannerAd2!.dispose();
      bannerAd2 = null;
    }
  }

  static Future<BannerAd?> loadBannerAd2() async {
    var completer = Completer<BannerAd?>();
    await clearBannerAd2();
    bannerAd2 = BannerAd(
      size: AdSize.banner,
      adUnitId: bannerId2,
      listener: BannerAdListener(
        onAdLoaded: (_) async {
          if (!completer.isCompleted) completer.complete(bannerAd2);
        },
        onAdFailedToLoad: (ad, error) async {
          if (!completer.isCompleted) {
            var result = await loadBannerAd3();
            completer.complete(result);
          }
        },
      ),
      request: AdRequest(),
    );
    await bannerAd2?.load().catchError((error) {
      if (!completer.isCompleted) completer.complete(null);
    });
    return completer.future;
  }

  static clearBannerAd3() async {
    if (bannerAd3 != null) {
      await bannerAd3!.dispose();
      bannerAd3 = null;
    }
  }

  static Future<BannerAd?> loadBannerAd3() async {
    var completer = Completer<BannerAd?>();
    await clearBannerAd3();
    bannerAd3 = BannerAd(
      size: AdSize.banner,
      adUnitId: bannerId3,
      listener: BannerAdListener(
        onAdLoaded: (_) async {
          if (!completer.isCompleted) completer.complete(bannerAd3);
        },
        onAdFailedToLoad: (ad, error) {
          if (!completer.isCompleted) {
            AdsController.loadIronSourceBannerAd();
            completer.complete(null);
          }
        },
      ),
      request: AdRequest(),
    );
    await bannerAd3?.load().catchError((error) {
      if (!completer.isCompleted) completer.complete(null);
    });
    return completer.future;
  }

  void dispose() {
    _interstitialAd1?.dispose();
    _interstitialAd2?.dispose();
    _interstitialAd3?.dispose();
    _rewardedAd1?.dispose();
    _rewardedAd2?.dispose();
    _rewardedAd3?.dispose();
  }
}
