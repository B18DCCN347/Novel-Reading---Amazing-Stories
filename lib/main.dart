import 'dart:async';
import 'dart:io';
import 'package:applovin_max/applovin_max.dart';
import 'package:appsflyer_sdk/appsflyer_sdk.dart';
import 'package:device_preview/device_preview.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_performance/firebase_performance.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_ironsource_x/ironsource.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:love_novel/app/global/app_binding.dart';
import 'package:love_novel/app/global/hive_boxes.dart';
import 'package:love_novel/app/global/app_navigator.dart';
import 'package:love_novel/app/global/remote_config.dart';
import 'package:love_novel/app/global/sources.dart';
import 'package:love_novel/app/utils/ads_admob_utils.dart';
import 'package:love_novel/data/apis/base.dart';
import 'package:love_novel/ui/components/app_theme.dart';
import 'package:love_novel/ui/pages/ads/controller.dart';
import 'package:love_novel/ui/pages/remove_ads/controller.dart';
import 'package:webview_flutter/webview_flutter.dart';

import 'app/global/controller.dart';
import 'firebase_options.dart';

// class MyHttpOverrides extends HttpOverrides {
//   @override
//   HttpClient createHttpClient(SecurityContext? contex  t) {
//     return super.createHttpClient(context)
//       ..badCertificateCallback =
//           (X509Cert ificate cert, String host, int port) => true;
//   }
// }

Future<void> main() async {
  // HttpOverrides.global = MyHttpOverrides();
  WidgetsFlutterBinding.ensureInitialized();
  await AppSources.load();
  await MobileAds.instance.initialize();

  API.init();
  if (Platform.isAndroid) {
    WebView.platform = SurfaceAndroidWebView();
  }
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  // await RemoteAds.initRemot();

  FirebasePerformance performance = FirebasePerformance.instance;
  HiveBoxes.init();

  FirebaseAnalytics.instance.logEvent(name: "TestFirebaseAnalytics");

  await initRemote();
  runApp(const MyApp());
}

Future<void> initRemote() async {
  var remoteConfig = FirebaseRemoteConfig.instance;
  await remoteConfig.setConfigSettings(RemoteConfigSettings(
    fetchTimeout: const Duration(minutes: 1),
    minimumFetchInterval: const Duration(minutes: 5),
  ));
  await remoteConfig.fetchAndActivate();

  RemoteAds.adsAoA = remoteConfig.getBool('inovel_aoa');
  RemoteAds.adsBanner = remoteConfig.getBool('inovel_banner');
  RemoteAds.adsReward = remoteConfig.getBool('inovel_reward');
  RemoteAds.adsInters = remoteConfig.getBool('inovel_inters');
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

// Create constants
const String _sdkKey =
    "T9h5zvLlRrXa4J6DiiUFBcEZfxaKxqquQFTxRVV4UW78w6Z1bKqnrXmxueR50EMTncEsQsArDa9WGTCCRn2qCs";
// appflyer
const String _afDevKey = "9znEn4hQhuRQLtTWV5wzc";
const String _iosappId = "";

class _MyAppState extends State<MyApp> with WidgetsBindingObserver {
  // late AppLifecycleReactor _appLifecycleReactor;

  @override
  void initState() {
    super.initState();
    // AdsAdmobUtils.showOpenAd1();
    WidgetsBinding.instance.addObserver(this);
    // when open app then show open ads

    // ADDED
    initializeAppLovinMax();
    initNeedShowAds();
    appsflyerSdk.initSdk(
        registerConversionDataCallback: true,
        registerOnAppOpenAttributionCallback: true,
        registerOnDeepLinkingCallback: true);
  }

  // ADDED
  // NOTE: Platform messages are asynchronous, so we initialize in an async method.
  initNeedShowAds() async {
    await RemoveAdsController.checkToShowAds(AppController.appConfig);

    // print(RemoveAdsController.needToShowAds);
  }

  Future<void> initializeAppLovinMax() async {
    Map? configuration = await AppLovinMAX.initialize(_sdkKey);
  }

  AppsflyerSdk appsflyerSdk = AppsflyerSdk(
    AppsFlyerOptions(
        afDevKey: _afDevKey,
        appId: _iosappId,
        showDebug: true,
        timeToWaitForATTUserAuthorization: 50, // for iOS 14.5
        disableAdvertisingIdentifier: false, // Optional field
        disableCollectASA: false),
  );
  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
    ;
    ;
    ;
    ;
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) async {
    if (RemoteAds.adsAoA) {
      switch (state) {
        case AppLifecycleState.resumed:
          if (AdsController.isISLoadFirst) {
            IronSource.activityResumed();
          }

          if (!AdsController.fullscreenShowing) {
            if (AdsAdmobUtils.loadedAOA == false) {
              AdsAdmobUtils.showOpenAd1();
            }
            if (AdsAdmobUtils.loadedAOA == true) {
              Timer(Duration(seconds: 20), () {
                AdsAdmobUtils.loadedAOA = false;
              });
            }
          } else {
            AdsController.fullscreenShowing = false;
          }
          break;
        case AppLifecycleState.inactive:
          // TODO: Handle this case.
          break;
        case AppLifecycleState.paused:
          // TODO: Handle this case.
          if (AdsController.isISLoadFirst) {
            IronSource.activityPaused();
          }
          break;
        case AppLifecycleState.detached:
          // TODO: Handle this case.
          break;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 768),
      builder: (context, child) => GetMaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Novel Reading',
        onGenerateRoute: AppNavigator.onGenerateRoute,
        initialBinding: AppBindings(),
        locale: const Locale('en', 'US'),
        useInheritedMediaQuery: true,
        // locale: DevicePreview.locale(context), //
        // builder: DevicePreview.appBuilder,//
        initialRoute: AppNavigator.initialRoute,
        theme: AppTheme.light,
        localizationsDelegates: const [
          GlobalMaterialLocalizations.delegate,
          // Built-in localization for text direction LTR/RTL
          GlobalWidgetsLocalizations.delegate,
          // Built-in localization of basic text for Cupertino widgets
          GlobalCupertinoLocalizations.delegate,
        ],
      ),
    );
  }
}
