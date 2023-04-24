import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class AppAdmobBannerAd extends StatelessWidget {
  final BannerAd? ad;

  const AppAdmobBannerAd({Key? key, this.ad}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ad != null
        ? Container(
            height: ad!.size.height.toDouble(),
            width: ad!.size.width.toDouble(),
            child: AdWidget(
              ad: ad!,
            ),
          )
        : const SizedBox();
  }
}
