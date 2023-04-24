import 'dart:async';

import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:love_novel/app/global/remote_config.dart';
import 'package:love_novel/app/utils/ads_admob_utils.dart';
import 'package:love_novel/app/utils/ads_max_utils.dart';
import 'package:love_novel/app/utils/dialogs.dart';
import 'package:love_novel/data/repositories/auth.dart';

import '../../components/app_theme.dart';
import '../remove_ads/controller.dart';

class SplashPage extends StatefulWidget {
  static const String route = "/";

  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();

    initShowAds();
  }

  Future<void> initShowAds() async {
    await funtion();
  }

  Future<void> funtion() async {
    Timer(Duration(seconds: 3), () {
      if (AdsAdmobUtils.loadedAOA && RemoteAds.adsAoA) {
        AdsAdmobUtils.showOpenAd1();
      }
      AuthRepository().checkSession();
      return;
    });
    await AdsAdmobUtils.loadOpenAd1();
    await AdsAdmobUtils.loadOpenAd2();
    await AdsAdmobUtils.loadOpenAd3();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: size.height,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage(
              "assets/images/splash-bg.jpeg",
            ),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: LoadingAnimationWidget.threeArchedCircle(
              color: Colors.white, size: 70),
        ),
        // child: Stack(
        //   alignment: Alignment.center,
        //   children: <Widget>[
        //     Center(
        //       child: Hero(
        //         tag: "logo",
        //         child: Image.asset(
        //           "assets/icons/logo.png",
        //           width: size.width * 0.4,
        //         ),
        //       ),
        //     )
        //   ],
        // ),
      ),
    );
  }
}
