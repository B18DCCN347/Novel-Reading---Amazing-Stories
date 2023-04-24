import 'dart:developer';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:love_novel/app/global/controller.dart';
import 'package:love_novel/app/global/hivebox_controller.dart';
import 'package:love_novel/app/global/viewer_themes.dart';
import 'package:love_novel/app/utils/ads_admob_utils.dart';
import 'package:love_novel/app/utils/dialogs.dart';
import 'package:love_novel/app/utils/string_helper.dart';
import 'package:love_novel/data/models/public/book.dart';
import 'package:love_novel/data/models/public/book_marker.dart';
import 'package:love_novel/data/models/public/viewer_setting.dart';
import 'package:love_novel/data/models/request/action_status.dart';
import 'package:love_novel/data/repositories/customer.dart';
import 'package:love_novel/ui/components/app_theme.dart';
import 'package:flutter_share/flutter_share.dart';
import 'package:love_novel/ui/pages/ads/controller.dart';
import 'package:love_novel/ui/pages/book/chapters.dart';
import 'package:love_novel/ui/pages/book/detail.dart';
import 'package:love_novel/ui/pages/book/download.dart';
import 'package:love_novel/ui/pages/home/home.dart';
import 'package:love_novel/ui/pages/your_books/favorite.dart';

class BookController extends GetxController {
  static BookController get instance => Get.isRegistered<BookController>()
      ? Get.find()
      : Get.put(BookController());

  static var currentBook = Rxn<Book>();
  static var actionStatus = Rxn<ActionStatus>();
  static var routeMarker = BookDetailPage.route;
  //late ScrollController scrollController;
  late CarouselController carouselController;
  var reachTop = 0.0.obs;
  var ratingScore = 0.obs;
  var currentIndex = 0.obs;
  static var toolbarShowed = false.obs;
  var appController = AppController.instance;
  final hiveBoxController = HiveBoxController.instance;

  toggleToolbar() {
    toolbarShowed.value = !toolbarShowed.value;
  }

  goToDetailPage(Book book) {
    BookController.currentBook.value = book;
    AppController.toNamed(BookDetailPage.route);
    FavoriteTabViewController.instance.init();
  }

  Future<void> share() async {
    await FlutterShare.share(
        title: 'Inovel - Romance Stories share',
        text: 'Inovel - Romance Stories',
        linkUrl:
            'https://play.google.com/store/apps/details?id=com.napoam21.novelreadingfree.amazingstories',
        // 'https://play.google.com/store/apps/details?id=com.novelwordstudio.booklovenovelfull',
        chooserTitle: 'Share Light Novel - Romance Stories App');
  }

  Future<void> toggleLike() async {
    var currentBookId = BookController.currentBook.value?.uuid ?? "";
    actionStatus.value ??= ActionStatus();
    if (actionStatus.value?.hasLiked ?? false) {
      await CustomerRepository().unlike(currentBookId);
      actionStatus.value?.hasLiked = false;
    } else {
      await CustomerRepository().like(currentBookId);
      actionStatus.value?.hasLiked = true;
    }
    actionStatus.refresh();
  }

  Future comment() async {
    await showDialog(
      context: Get.context as BuildContext,
      barrierDismissible: true,
      builder: (context) {
        return AlertDialog(
          title: Container(
              padding: EdgeInsets.symmetric(vertical: 8),
              width: double.infinity,
              decoration: BoxDecoration(
                  border:
                      Border(bottom: BorderSide(color: AppTheme.successColor))),
              child: Center(
                child: Text(
                  "Rating",
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: AppTheme.successColor),
                ),
              )),
          content: Container(
            height: 280,
            width: MediaQuery.of(context).size.width * .8,
            child: Column(
              children: [
                // Container(
                //   padding: EdgeInsets.all(8),
                //   decoration: BoxDecoration(
                //       color: AppTheme.disabledColorLight,
                //       borderRadius: BorderRadius.all(Radius.circular(16))),
                //   child: TextField(
                //     maxLines: 8,
                //     decoration: InputDecoration(
                //         border: InputBorder.none,
                //         hintText: "Type your comment here"),
                //   ),
                // ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: RatingBar.builder(
                    unratedColor: AppTheme.goldColor,
                    initialRating: ratingScore.value.toDouble(),
                    minRating: 1,
                    direction: Axis.horizontal,
                    allowHalfRating: false,
                    itemCount: 5,
                    itemSize: 28,
                    itemBuilder: (context, _) => Icon(
                      Icons.star,
                      color: Colors.amber,
                    ),
                    onRatingUpdate: (rating) {
                      ratingScore.value = rating.toInt();
                    },
                  ),
                ),
                Spacer(),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                          child: InkWell(
                        onTap: () async {
                          if (ratingScore.value == 0) {
                            Dialogs.alert(message: "Please rate star!");
                            return;
                          }
                          var currentBookId =
                              BookController.currentBook.value?.uuid ?? "";
                          Dialogs.showProgress();
                          var response = await CustomerRepository()
                              .rate(currentBookId, ratingScore.value);
                          Dialogs.hideProgress();
                          if (response != null) {
                            Navigator.of(context).pop(1);
                          } else {
                            Dialogs.alert(message: "Rating fail!");
                          }
                        },
                        child: Container(
                          padding:
                              EdgeInsets.symmetric(horizontal: 16, vertical: 5),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              color: AppTheme.successColor),
                          alignment: Alignment.center,
                          child: Column(
                            children: <Widget>[
                              Text(
                                "Rate",
                                style: TextStyle(
                                  color: AppTheme.backgroundColorLight,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              )
                            ],
                          ),
                        ),
                      ))
                    ],
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }

  Future rating() async {
    await showDialog(
      context: Get.context as BuildContext,
      barrierDismissible: true,
      builder: (context) {
        return AlertDialog(
          title: Container(
              padding: EdgeInsets.symmetric(vertical: 8),
              width: double.infinity,
              decoration: BoxDecoration(
                  border:
                      Border(bottom: BorderSide(color: AppTheme.successColor))),
              child: Center(
                child: Text(
                  "Rating",
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: AppTheme.successColor),
                ),
              )),
          content: Container(
            height: 80,
            width: MediaQuery.of(context).size.width * .8,
            child: Column(
              children: [
                // Container(
                //   padding: EdgeInsets.all(8),
                //   decoration: BoxDecoration(
                //       color: AppTheme.disabledColorLight,
                //       borderRadius: BorderRadius.all(Radius.circular(16))),
                //   child: TextField(
                //     maxLines: 8,
                //     decoration: InputDecoration(
                //         border: InputBorder.none,
                //         hintText: "Type your comment here"),
                //   ),
                // ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: RatingBar.builder(
                    // unratedColor: AppTheme.goldColor,
                    initialRating: ratingScore.value.toDouble(),
                    minRating: 1,
                    direction: Axis.horizontal,
                    allowHalfRating: false,
                    itemCount: 5,
                    itemSize: 28,
                    itemBuilder: (context, _) => Icon(
                      Icons.star,
                      color: Colors.amber,
                    ),
                    onRatingUpdate: (rating) {
                      ratingScore.value = rating.toInt();
                    },
                  ),
                ),
                Spacer(),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                          child: InkWell(
                        onTap: () async {
                          if (ratingScore.value == 0) {
                            Dialogs.alert(message: "Please rate star!");
                            return;
                          }
                          var currentBookId =
                              BookController.currentBook.value?.uuid ?? "";
                          Dialogs.showProgress();
                          var response = await CustomerRepository()
                              .rate(currentBookId, ratingScore.value);
                          Dialogs.hideProgress();
                          if (response != null) {
                            actionStatus.value?.hasRate = true;
                            actionStatus.refresh();
                            Navigator.of(context).pop(1);
                          } else {
                            Dialogs.alert(message: "Rating fail!");
                          }
                        },
                        child: Container(
                          padding:
                              EdgeInsets.symmetric(horizontal: 16, vertical: 5),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              color: AppTheme.successColor),
                          alignment: Alignment.center,
                          child: Column(
                            children: <Widget>[
                              Text(
                                "Rate",
                                style: TextStyle(
                                  color: AppTheme.backgroundColorLight,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              )
                            ],
                          ),
                        ),
                      ))
                    ],
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }

  move(int index) async {
    currentIndex.value = index;
    await carouselController.animateToPage(index);
  }

  static var setting = Rxn<ViewerSetting>();
  static var defaultSetting = ViewerSetting(
    font: "Roboto",
    size: 22,
    theme: ViewerThemes.light,
    currentPage: 0,
  );
  static var fonts = [
    "Cabin",
    "Roboto",
    "WorkSans",
    "Charm",
    "Quicksand",
    "OpenSans",
    "Bellota",
    "Lora",
  ];
  @override
  void onInit() {
    super.onInit();
    carouselController = CarouselController();
    // scrollController = ScrollController()
    //   ..addListener(() {
    //     reachTop.value = scrollController.position.pixels;
    //   });
    WidgetsBinding.instance.addPostFrameCallback((timer) async {
      await init();
    });
  }

  init() async {
    currentIndex.value = 0;
    var currentBookId = BookController.currentBook.value?.uuid ?? "";
    if (currentBookId.isNotEmpty) {
      if (!AppController.hasConnection) {
        currentBook.value = (await hiveBoxController.bookBoxRepository
                    .safeGetAll())
                .firstWhereOrNull((element) => element.uuid == currentBookId) ??
            Book();
      }
      await loadActionStatus();
      await ChaptersController.instance.init();
    }
  }

  loadActionStatus() async {
    var currentBookId = BookController.currentBook.value?.uuid ?? "";
    if (AppController.hasConnection) {
      actionStatus.value =
          (await CustomerRepository().actionStatus(currentBookId)) ??
              ActionStatus();
      actionStatus.value?.bookId = currentBookId;
      hiveBoxController.saveOrUpdateActionStatus(actionStatus.value!);
    } else {
      actionStatus.value =
          await hiveBoxController.getActionStatus(currentBookId);
    }
  }

  continueRead() async {
    Dialogs.showProgress();
    await init();
    Dialogs.hideProgress();
    await ChaptersController.instance.startRead(HomePage.route);
  }

  navigateToDownloadPage() async {
    Dialogs.showProgress();
    // var result = await AdsController.showRewardedVideo();
    Dialogs.hideProgress();
    // if (result)
    AppController.toNamed(DownloadPage.route);
  }

  Image getImage(Book book) {
    if ((book.portraitThumb ?? "").isEmpty) {
      return Image.asset(
        "assets/images/no-image.jpeg",
      );
    } else {
      if (book.cached ?? false) {
        return StringHelper.imageFromBase64String(book.portraitThumb ?? "");
      } else {
        return Image.network(
          book.portraitThumb ?? "",
          errorBuilder: (context, error, stackTrace) {
            return Image.asset("assets/images/no-image.jpeg");
          },
          loadingBuilder: (BuildContext context, Widget child,
              ImageChunkEvent? loadingProgress) {
            if (loadingProgress == null) {
              return child;
            }
            return Center(
              child: CircularProgressIndicator(
                value: loadingProgress.expectedTotalBytes != null
                    ? loadingProgress.cumulativeBytesLoaded /
                        loadingProgress.expectedTotalBytes!
                    : null,
              ),
            );
          },
        );
      }
    }
  }

  updateViewerSetting() async {
    if (setting.value != null) {
      setting.refresh();
      await hiveBoxController.viewerSettingBoxRepository
          .update(setting.value!.key, setting.value!);
    } else {
      setting.value = defaultSetting;
      await hiveBoxController.viewerSettingBoxRepository.add(setting.value!);
    }
  }

  Future loadViewerSetting() async {
    var ctr = await hiveBoxController.viewerSettingBoxRepository.safeCount();
    if (ctr == 0) {
      setting.value = defaultSetting;
      await hiveBoxController.viewerSettingBoxRepository.add(setting.value!);
    } else {
      setting.value =
          (await hiveBoxController.viewerSettingBoxRepository.safeGetAll())
              .elementAt(0);
      log(
        setting.value!.size.toString(),
      );
    }
  }

  Future<BookMarker?> findMarkerIfExist(String chapterId) async {
    var currentBookId = BookController.currentBook.value?.uuid ?? "";
    var markers =
        (await hiveBoxController.bookMarkerBoxRepository.safeGetAll());
    var existMarker = markers.firstWhereOrNull((element) =>
        element.bookId == currentBookId && element.chapterId == chapterId);
    return existMarker;
  }

  updateActionStatusIndex(index) {
    actionStatus.value?.episodeIndex = index;
    actionStatus.refresh();
    hiveBoxController
        .saveOrUpdateActionStatus(BookController.actionStatus.value!);
  }

  var updatingMarker = false;
  updateMarker(String chapterId, double position) async {
    if (!updatingMarker) {
      updatingMarker = true;
      var existMarker = await findMarkerIfExist(chapterId);
      if (existMarker != null) {
        existMarker.position = position;
        await hiveBoxController.bookMarkerBoxRepository
            .update(existMarker.key, existMarker);
      } else {
        var currentBookId = BookController.currentBook.value?.uuid ?? "";
        await hiveBoxController.bookMarkerBoxRepository.add(BookMarker(
            bookId: currentBookId, chapterId: chapterId, position: position));
      }
      updatingMarker = false;
    }
  }

  updateFont(String font) async {
    setting.value?.font = font;
    await updateViewerSetting();
    setting.refresh();
  }

  updateTheme(String newTheme) async {
    if (newTheme != setting.value?.theme) {
      setting.value?.theme = newTheme;
      await updateViewerSetting();
      setting.refresh();
    }
  }

  updateFontSize(double size) async {
    if (size < 10)
      size = 10;
    else if (size > 50) size = 50;
    setting.value?.size = size;
    await updateViewerSetting();
    setting.refresh();
  }

  updatePage(int page) {
    setting.value?.currentPage = page;
    setting.refresh();
  }

  Color getBackgroundColor(String theme) {
    var backgroundColor = Colors.white;
    switch (theme) {
      case ViewerThemes.light:
        backgroundColor = Color(0xFFF8F9FA);
        break;
      case ViewerThemes.mid:
        backgroundColor = Color(0xFFEBE8DC);
        break;
      case ViewerThemes.dark:
        backgroundColor = Colors.black;
        break;
      default:
        backgroundColor = Color(0xFF7A7676);
        break;
    }
    return backgroundColor;
  }

  Color getTextColor(String theme) {
    var textColor = Colors.black;
    switch (theme) {
      case ViewerThemes.light:
        textColor = AppTheme.greyColorDark;
        break;
      case ViewerThemes.mid:
        textColor = AppTheme.greyColorDark;
        break;
      case ViewerThemes.dark:
        textColor = Color(0xFFCBC7C5);
        break;
      default:
        textColor = Color(0xFFC2C7C9);
        break;
    }
    return textColor;
  }
}
