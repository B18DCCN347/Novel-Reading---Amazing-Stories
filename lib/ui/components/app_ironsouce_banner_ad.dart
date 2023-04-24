import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_ironsource_x/ironsource.dart';
import 'package:love_novel/app/global/app_navigator.dart';
import 'package:love_novel/app/global/controller.dart';
import 'package:love_novel/ui/pages/ads/controller.dart';
import 'package:love_novel/ui/pages/book/detail.dart';
import 'package:love_novel/ui/pages/book/read.dart';
import 'package:love_novel/ui/pages/remove_ads/controller.dart';

class AppIronSourceBannerAd extends StatelessWidget {
  double padding;
  bool visible;
  AppIronSourceBannerAd({Key? key, this.padding = 8, this.visible = true})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var needShow = RemoveAdsController.needToShowAds &&
        Platform.isAndroid &&
        AppController.hasConnection;
    return Padding(
      padding: EdgeInsets.all(padding),
      child: visible && needShow
          ? IronSourceBannerAd(
              keepAlive: true,
              listener: AppIronSourceBannerListener(),
              size: BannerSize.BANNER,
              // size: BannerSize.LARGE,
              // size: BannerSize.LEADERBOARD,
              // size: BannerSize.RECTANGLE,
              // size: BannerSize.SMART,
              /* size: BannerSize(
                    type: BannerSizeType.BANNER,
                    width: 400,
                    height: 50,
                  ), */
              // backgroundColor: Colors.amber,
            )
          : const SizedBox(),
    );
  }
}

class AppIronSourceBannerListener extends IronSourceBannerListener {
  @override
  void onBannerAdClicked() {
    print("onBannerAdClicked");
  }

  @override
  void onBannerAdLeftApplication() {
    print("onBannerAdLeftApplication");
  }

  @override
  void onBannerAdLoadFailed(Map<String, dynamic> error) {
    print("=============== onBannerAdLoadFailed ===============");
    AdsController.loadAdmobBannerAd();
  }

  @override
  void onBannerAdLoaded() {
    print("onBannerAdLoaded");
    AdsController.loadAdmobBannerAd();
  }

  @override
  void onBannerAdScreenDismissed() {
    print("onBannerAdScreenDismisse");
  }

  @override
  void onBannerAdScreenPresented() {
    print("onBannerAdScreenPresented");
  }
}
