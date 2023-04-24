import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:love_novel/app/global/arguments.dart';
import 'package:love_novel/app/global/controller.dart';
import 'package:love_novel/data/models/public/episode.dart';
import 'package:love_novel/ui/pages/account/login/login.dart';
import 'package:love_novel/ui/pages/account/register/register.dart';
import 'package:love_novel/ui/pages/book/detail.dart';
import 'package:love_novel/ui/pages/book/read.dart';
import 'package:love_novel/ui/pages/book/download.dart';
import 'package:love_novel/ui/pages/discovery/discovery_books_view.dart';
import 'package:love_novel/ui/pages/genres/books.dart';
import 'package:love_novel/ui/pages/home/home.dart';
import 'package:love_novel/ui/pages/remove_ads/remove_ads.dart';
import 'package:love_novel/ui/pages/search/books.dart';
import 'package:love_novel/ui/pages/splash/splash.dart';
import 'package:love_novel/ui/pages/webview/webview.dart';

class AppNavigator {
  static const DEFAULT_DURATION = Duration(milliseconds: 300);
  static var initialRoute = SplashPage.route;
  static var firstPageRoute = SplashPage.route;
  static var readTransition = Transition.rightToLeftWithFade;
  static var changed = true;

  static Route onGenerateRoute(RouteSettings settings) {
    if (AppController. currentRoute.value != settings.name) {
      changed = true;
     AppController. currentRoute.value = settings.name ?? SplashPage.route;
    } else
      changed = false;
    switch (settings.name) {
      case HomePage.route:
        return GetPageRoute(
          settings: settings,
          page: () => HomePage(),
          routeName: settings.name,
          curve: Curves.fastOutSlowIn,
          transitionDuration: DEFAULT_DURATION,
          transition: Transition.fadeIn,
          // binding: PotentialStocksBindings(),
        );
      case LoginPage.route:
        return GetPageRoute(
          settings: settings,
          page: () => LoginPage(),
          routeName: settings.name,
          curve: Curves.fastOutSlowIn,
          transitionDuration: DEFAULT_DURATION,
          transition: Transition.rightToLeftWithFade,
        );
      case RemoveAdsPage.route:
        return GetPageRoute(
          settings: settings,
          page: () => RemoveAdsPage(),
          routeName: settings.name,
          curve: Curves.fastOutSlowIn,
          transitionDuration: DEFAULT_DURATION,
          transition: Transition.rightToLeftWithFade,
        );
      case DownloadPage.route:
        return GetPageRoute(
          settings: settings,
          page: () => DownloadPage(),
          routeName: settings.name,
          curve: Curves.fastOutSlowIn,
          transitionDuration: DEFAULT_DURATION,
          transition: Transition.rightToLeftWithFade,
        );
      case RegisterPage.route:
        return GetPageRoute(
          settings: settings,
          page: () => RegisterPage(),
          routeName: settings.name,
          curve: Curves.fastOutSlowIn,
          transitionDuration: DEFAULT_DURATION,
          transition: Transition.fadeIn,
        );
      case SearchBooksPage.route:
        return GetPageRoute(
          settings: settings,
          page: () => SearchBooksPage(),
          routeName: settings.name,
          curve: Curves.fastOutSlowIn,
          transitionDuration: DEFAULT_DURATION,
          transition: Transition.fadeIn,
        );
      case BookDetailPage.route:
        return GetPageRoute(
          settings: settings,
          page: () => BookDetailPage(),
          routeName: settings.name,
          curve: Curves.fastOutSlowIn,
          transitionDuration: DEFAULT_DURATION,
          transition: Transition.downToUp,
        );

      case ReadPage.route:
        var arguments = settings.arguments as EpisodeArguments?;
        return GetPageRoute(
          settings: settings,
          page: () => ReadPage(
            episode: arguments?.episode ?? Episode(),
          ),
          routeName: settings.name,
          curve: Curves.fastOutSlowIn,
          transitionDuration: DEFAULT_DURATION,
          transition: readTransition,
        );
      case RegisterPage.route:
        return GetPageRoute(
          settings: settings,
          page: () => RegisterPage(),
          routeName: settings.name,
          curve: Curves.fastOutSlowIn,
          transitionDuration: DEFAULT_DURATION,
          transition: Transition.fadeIn,
        );
      case DiscoveryBooksView.route:
        var arguments = settings.arguments as DiscoveryArguments?;
        return GetPageRoute(
          settings: settings,
          page: () => DiscoveryBooksView(controller: arguments!.controller,),
          routeName: settings.name,
          curve: Curves.fastOutSlowIn,
          transitionDuration: DEFAULT_DURATION,
          transition: Transition.rightToLeft,
        );
      case GenresBooksView.route:
        return GetPageRoute(
          settings: settings,
          page: () => GenresBooksView(),
          routeName: settings.name,
          curve: Curves.fastOutSlowIn,
          transitionDuration: DEFAULT_DURATION,
          transition: Transition.rightToLeft,
        );
      case WebViewPage.route:
        return GetPageRoute(
          settings: settings,
          page: () => WebViewPage(),
          routeName: settings.name,
          curve: Curves.fastOutSlowIn,
          transitionDuration: DEFAULT_DURATION,
          transition: Transition.rightToLeft,
        );
      default:
        return GetPageRoute(
          settings: settings,
          page: () => SplashPage(),
          routeName: settings.name,
          curve: Curves.fastOutSlowIn,
          transitionDuration: DEFAULT_DURATION,
          transition: Transition.rightToLeftWithFade,
        );
    }
  }
}
