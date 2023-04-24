import 'package:flutter/material.dart';
import 'package:applovin_max/applovin_max.dart';
import 'package:firebase_analytics/firebase_analytics.dart';

class AppMaxBannerAd extends StatelessWidget {
  final String? adUnitId;
  const AppMaxBannerAd({Key? key, this.adUnitId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var isValid = int.tryParse(adUnitId ?? "");
    return isValid == null
        ? MaxAdView(
            adUnitId: "$adUnitId",
            adFormat: AdFormat.banner,
            listener: AdViewAdListener(onAdLoadedCallback: (ad) {
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
            }, onAdLoadFailedCallback: (adUnitId, error) {
              print("ADS_DEBUG onAdLoadFailedCallback");
            }, onAdClickedCallback: (ad) {
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
            }, onAdExpandedCallback: (ad) {
              print("ADS_DEBUG onAdExpandedCallback");
            }, onAdCollapsedCallback: (ad) {
              print("ADS_DEBUG onAdCollapsedCallback");
            }))
        : const SizedBox();
  }
}
