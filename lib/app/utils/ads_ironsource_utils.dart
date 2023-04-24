import 'package:flutter_ironsource_x/ironsource.dart';
import 'package:love_novel/ui/components/app_ironsouce_banner_ad.dart';
import 'package:love_novel/ui/components/app_ironsource_listener.dart';

class AdsIronSourceUtils {
  static var interstitialReady = false;
  static var rewardeVideoAvailable = false;
  static var offerwallAvailable = false;

  static AppIronSourceBannerAd? bannerAd;
  static Future init() async {
    await IronSource.validateIntegration();
    var userId = await IronSource.getAdvertiserId();
    await IronSource.setUserId(userId);
    await IronSource.initialize(
      //  appKey: "1412a8fa9",
      appKey: "153e368a1",
      // appKey: "85460dcd",
      listener: AppIronSourceListener(),
      gdprConsent: true,
    );
    await IronSource.loadInterstitial();
    interstitialReady = await IronSource.isInterstitialReady();
    rewardeVideoAvailable = await IronSource.isRewardedVideoAvailable();
    offerwallAvailable = await IronSource.isOfferwallAvailable();
  }

  static clearBannerAd() async {
    bannerAd = null;
  }

  static Future<AppIronSourceBannerAd?> loadBannerAd() async {
    await clearBannerAd();
    bannerAd = AppIronSourceBannerAd();
    return bannerAd;
  }

  static loadInterstitialAd() async {
    await IronSource.loadInterstitial();
    interstitialReady = await IronSource.isInterstitialReady();
  }
  
  static showInterstitialAd() async {
    await IronSource.loadInterstitial();
    await Future.delayed(const Duration(seconds: 15));
    // if (interstitialReady) {
    await IronSource.showInterstitial();
    // }
  }

  static loadRewardedAd() async {
    await Future.delayed(Duration(seconds: 1));
  }

  static showRewardedAd() async {
    rewardeVideoAvailable = await IronSource.isRewardedVideoAvailable();
    // if (rewardeVideoAvailable) {
    await IronSource.showRewardedVideo();
    // }
  }
}
