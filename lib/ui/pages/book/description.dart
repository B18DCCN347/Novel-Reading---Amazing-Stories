// import 'package:applovin_max/applovin_max.dart';
import 'package:applovin_max/applovin_max.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:love_novel/app/global/controller.dart';
import 'package:love_novel/app/global/remote_config.dart';
import 'package:love_novel/ui/components/app_theme.dart';
import 'package:love_novel/ui/pages/ads/controller.dart';
import 'package:love_novel/ui/pages/book/controller.dart';
import 'package:love_novel/ui/pages/book/detail.dart';

import '../../../app/utils/dialogs.dart';
// import 'package:love_novel/ui/pages/book/read.dart';

class DescriptionView extends StatefulWidget {
  const DescriptionView({
    Key? key,
  }) : super(key: key);

  @override
  State<DescriptionView> createState() => _DescriptionViewState();
}

class _DescriptionViewState extends State<DescriptionView> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      if (RemoteAds.adsBanner) {
        await AdsController.loadBannerAd();
      }
      // AppLovinMAX.showBanner("e2d26681207af0a2");
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            child: Obx(() {
              if (AppController.currentRoute.value != BookDetailPage.route) {
                return const SizedBox();
              }
              if (!AdsController.bannerAdAvailable.value ||
                  AdsController.bannerAd.value == null) {
                return const SizedBox();
              }

              return AdsController.bannerAd.value!;
            }),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  (BookController.currentBook.value?.isEnded ?? 0) == 0
                      ? "[OnGoing]"
                      : "[Completed]",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                RatingBar.builder(
                  unratedColor: AppTheme.goldColor,
                  initialRating:
                      BookController.currentBook.value?.stats?.rate ?? 0,
                  minRating: 1,
                  direction: Axis.horizontal,
                  allowHalfRating: true,
                  ignoreGestures: true,
                  itemCount: 5,
                  itemSize: 28,
                  itemBuilder: (context, _) => Icon(
                    Icons.star,
                    color: Colors.amber,
                  ),
                  onRatingUpdate: (rating) {},
                )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              BookController.currentBook.value?.description ?? "",
              style: TextStyle(
                  fontSize: 20, height: 1.4, color: AppTheme.greyColorDark),
            ),
          ),
        ],
      ),
    );
  }
}
