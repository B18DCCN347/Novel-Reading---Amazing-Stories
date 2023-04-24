import 'dart:async';
import 'dart:developer';
import 'dart:io';
import 'package:applovin_max/applovin_max.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_ironsource_x/ironsource.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:love_novel/app/global/app_navigator.dart';
import 'package:love_novel/app/global/arguments.dart';
import 'package:love_novel/app/global/controller.dart';
import 'package:love_novel/app/global/hivebox_controller.dart';
import 'package:love_novel/app/global/viewer_themes.dart';
import 'package:love_novel/app/utils/dialogs.dart';
import 'package:love_novel/data/models/caches/chapter_data.dart';
import 'package:love_novel/data/models/public/episode.dart';
import 'package:love_novel/data/models/public/package_episode.dart';
import 'package:love_novel/data/repositories/book.dart';
import 'package:love_novel/ui/components/app_theme.dart';
import 'package:love_novel/ui/components/font_select_box.dart';
import 'package:love_novel/ui/pages/ads/controller.dart';
import 'package:love_novel/ui/pages/book/chapters.dart';
import 'package:love_novel/ui/pages/book/controller.dart';
import 'package:love_novel/ui/pages/book/detail.dart';
import 'package:love_novel/ui/pages/remove_ads/controller.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class ReadController extends GetxController {
  var bookController = BookController.instance;
  var chaptersController = ChaptersController.instance;

  static var loading = false;
  var dowloading = false.obs;
  var position = 0.0.obs;
  // var maxPosition = 1000.0.obs;
  var htmlData = "".obs;
  var filePath = "";
  var episode = Rxn<Episode>();
  late ScrollController scrollController;
  final appController = AppController.instance;
  final hiveBoxController = HiveBoxController.instance;
  var updatingMarker = false;
  late final prefs;
  late final String bookId;
  @override
  void onClose() {
    super.onClose();
  }

  init() async {
    AdsController.cleanBannerAds();
    prefs = await SharedPreferences.getInstance();
    bookId = BookController.currentBook.value?.uuid ?? "";
    var index = episode.value!.index;
    if (AppController.chapterCounter >= 3) {
      await AppController.instance.appRating();
    }
    scrollController = ScrollController()
      ..addListener(() {
        // moi lan scrool nghe thoi gian troi
        // var now = DateTime.now().microsecondsSinceEpoch;

        // log(((now - AppController.timeMarker) / Duration.microsecondsPerSecond)
        //     .toString());
        AdsController.showAdWhenReading();
        var prev = prefs.getInt('prevchap__' + bookId);
        position.value = scrollController.position.pixels;

        if (prev != index) {
          prefs.setInt('prevchap__' + bookId, index);
          scrollController.jumpTo(0.0);
        } else {
          if (scrollController.offset >=
                  scrollController.position.maxScrollExtent &&
              !scrollController.position.outOfRange) {
            nextChapter();
          }
        }
      });
    await bookController.loadViewerSetting();
    await loadHtml();
    await loadMaxHeight();
  }

  bool scrollNotification(ScrollNotification notification) {
    if (notification is ScrollEndNotification) {
      bookController.updateMarker(episode.value?.uuid ?? "", position.value);
    }
    return true;
  }

  // checkToShowAds() {
  //   AppController.chapterCounter++;
  //   // AdsController.showAdWhenReading();
  // }

  nextChapter() async {
    AdsController.reShowBannerAds();
    final prefs = await SharedPreferences.getInstance();
    if (!loading) {
      loading = true;
      var index = episode.value?.index ?? 1;
      if (ChaptersController.offset < index) ChaptersController.offset = index;
      index += 1;
      prefs.setInt('prevchap__' + bookId, index);
      AppNavigator.readTransition = Transition.rightToLeftWithFade;
      var currentLength = ChaptersController.episodes.value?.length ?? 0;
      if (index <= (BookController.currentBook.value?.totalEpisodes ?? 0)) {
        if (ChaptersController.episodes.value != null && currentLength > 1) {
          var nextEpisode = ChaptersController.episodes.value!
              .firstWhereOrNull((element) => element.index == index);
          if (nextEpisode != null) {
            AppController.chapterCounter++;
            Dialogs.showProgressCicular();
            await Future.delayed(
                Duration(
                  seconds: 1,
                ), () {
              Get.offAndToNamed(ReadPage.route,
                  arguments: EpisodeArguments(episode: nextEpisode!));
            });
            bookController.updateActionStatusIndex(index);
            if ((nextEpisode.index ?? 0) > currentLength - 3) {
              chaptersController.loadEpisodes();
            }
          } else {
            Dialogs.showProgressCicular();
            await chaptersController.loadEpisodes();
            Dialogs.hideProgress();
            nextEpisode = ChaptersController.episodes.value!
                .firstWhereOrNull((element) => element.index == index);
            if (nextEpisode != null) {
              AppController.chapterCounter++;
              Get.offAndToNamed(ReadPage.route,
                  arguments: EpisodeArguments(episode: nextEpisode));
              bookController.updateActionStatusIndex(index);
            }
          }
        }
      }
      loading = false;
    }
  }

  backChapter() async {
    AdsController.reShowBannerAds();
    if (!loading) {
      loading = true;
      var index = episode.value?.index ?? 1;
      index -= 1;
      AppNavigator.readTransition = Transition.leftToRightWithFade;
      if (index > 0) {
        if (ChaptersController.episodes.value != null &&
            ChaptersController.episodes.value!.length > 1) {
          var prevEpisode = ChaptersController.episodes.value!
              .firstWhereOrNull((element) => element.index == index);
          if (prevEpisode != null) {
            //Get.back();
            Dialogs.showProgressCicular();

            await Future.delayed(
                Duration(
                  seconds: 1,
                ), () {
              Get.offAndToNamed(
                ReadPage.route,
                arguments: EpisodeArguments(episode: prevEpisode),
              );
            });

            bookController.updateActionStatusIndex(index);
          }
        }
      }
      loading = false;
    }
  }

  int countToSaveMarker = 0;
  loadMaxHeight() async {
    await Future.delayed(const Duration(milliseconds: 1));
    if (scrollController.hasClients) {
      // maxPosition.value = scrollController.position.maxScrollExtent;
      if (!scrollController.position.isScrollingNotifier.hasListeners) {
        var existMarker =
            await bookController.findMarkerIfExist(episode.value?.uuid ?? "");
        if (existMarker != null) scrollController.jumpTo(existMarker.position);
      }
    } else {
      await loadMaxHeight();
    }
  }

  loadHtml() async {
    var bookId = BookController.currentBook.value?.uuid ?? "";
    var chapterId = episode.value?.uuid ?? "";
    var cachedItem = await hiveBoxController
        .getChapterData(bookId, chapterId)
        .catchError((error) {});
    if (cachedItem != null) {
      htmlData.value = cachedItem.data;
    } else {
      var items =
          await hiveBoxController.downloadPackageBoxRepository.safeGetAll();
      PackageEpisode? existCached;
      var chapterIndex = episode.value?.index ?? 0;
      for (var item in items) {
        if (item.bookId == bookId) {
          for (PackageEpisode ep in (item.eps ?? [])) {
            if (ep.index == chapterIndex) {
              existCached = ep;
              break;
            }
          }
        }
      }
      if (existCached != null) {
        htmlData.value = existCached.html ?? "";
      } else if (AppController.hasConnection) {
        var response = await BookRepository().episodeLink(bookId, chapterId);
        if (response?.link != null) {
          var htmlRp = await http.get(Uri.parse(response!.link!));
          if (htmlRp.statusCode == 200) {
            String fileHtmlContents = htmlRp.body;
            htmlData.value = fileHtmlContents;
            hiveBoxController.saveOrUpdateChapterData(ChapterData(
                bookId: bookId,
                chapterId: chapterId,
                data: fileHtmlContents,
                time: DateTime.now()));
          }
        } else {
          htmlData.value =
              '<div class="chapTitle">Episode does not exist</div>';
        }
      } else {
        Dialogs.alert(message: "Please check your internet connection!");
      }
    }
    await cacheHtml();
    if (AppController.hasConnection) {
      await BookRepository().markRead(bookId, chapterId);
    }
    await bookController.loadActionStatus();
  }

  cacheHtml() async {
    var bookId = BookController.currentBook.value?.uuid ?? "";
    var index = episode.value?.index ?? 1;
    var bIndex = index - 3;
    if (bIndex < 1) {
      bIndex = 1;
    }

    var aIndex = index + 3;
    if (aIndex > (BookController.currentBook.value?.totalEpisodes ?? 0)) {
      aIndex = (BookController.currentBook.value?.totalEpisodes ?? 0);
    }

    List<String> chapterIds = [];
    for (Episode ep in (ChaptersController.episodes.value ?? [])) {
      var epIndex = ep.index ?? 0;
      if (epIndex >= bIndex && epIndex <= aIndex && epIndex != index) {
        chapterIds.add(ep.uuid ?? "");
      }
    }
    for (var chapterId in chapterIds.reversed) {
      var cachedItem = await hiveBoxController
          .getChapterData(bookId, chapterId)
          .catchError((error) {});
      if (cachedItem == null && AppController.hasConnection) {
        var response = await BookRepository().episodeLink(bookId, chapterId);
        if (response?.link != null) {
          var htmlRp = await http.get(Uri.parse(response!.link!));
          if (htmlRp.statusCode == 200) {
            String fileHtmlContents = htmlRp.body;
            hiveBoxController.saveOrUpdateChapterData(ChapterData(
                bookId: bookId,
                chapterId: chapterId,
                data: fileHtmlContents,
                time: DateTime.now()));
          }
          // var tempDir = await getTemporaryDirectory();
          // String fullPath = tempDir.path + "/temp.html'";
          // await download(Dio(), response?.link ?? "", fullPath);
          // var file = File(filePath);
          // String fileHtmlContents = await file.readAsString();
          // try {
          //   await file.delete();
          // } catch (e) {}
        }
      }
    }
  }

  Future download(Dio dio, String url, String savePath) async {
    try {
      if (await Permission.storage.isGranted) {
        await Permission.storage.request();
        await startDownload(dio, url, savePath);
      } else {
        await startDownload(dio, url, savePath);
      }
    } catch (e) {
      print(e);
    }
    filePath = savePath;
  }

  startDownload(Dio dio, String url, String savePath) async {
    if (Platform.isAndroid || Platform.isIOS) {
      var response = await dio.get(
        url,
        onReceiveProgress: (receivedBytes, totalBytes) {
          print((receivedBytes / totalBytes * 100).toStringAsFixed(0));
          //Check if download is complete and close the alert dialog
          if (receivedBytes == totalBytes) {
            dowloading.value = false;
          }
        },
        //Received data with List<int>
        options: Options(
            responseType: ResponseType.bytes,
            followRedirects: false,
            validateStatus: (status) {
              return (status ?? 0) < 500;
            }),
      );
      print(response.headers);
      File file = File(savePath);
      var raf = file.openSync(mode: FileMode.write);
      // response.data is List<int> type
      raf.writeFromSync(response.data);
      await raf.close();
    } else {
      dowloading.value = false;
    }
  }
}

class ReadPage extends StatefulWidget {
  final Episode episode;
  ReadPage({Key? key, required this.episode}) : super(key: key);
  static const route = '/read';

  @override
  State<ReadPage> createState() => _ReadPageState();
}

class _ReadPageState extends State<ReadPage> {
  late ReadController controller;
  @override
  void initState() {
    super.initState();
    controller = ReadController();
    controller.episode.value = widget.episode;
    Get.put(controller, tag: widget.episode.uuid);
    BookController.actionStatus.value?.episodeIndex = widget.episode.index;
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      await controller.init();
      // if (mounted) {
      //   await AdsController.loadBannerAd();
      // }
    });
  }

  @override
  void dispose() {
    AdsController.prevTime = AdsController.time;
    controller.dispose();

    super.dispose();
  }

  final bookController = BookController.instance;

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return WillPopScope(
      onWillPop: () async {
        AppController.until(BookController.routeMarker);
        return false;
      },
      child: Scaffold(
        body: Obx(() {
          if (controller.htmlData.value.isEmpty) {
            return const Center(child: CircularProgressIndicator());
          } else {
            return Stack(
              children: [
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                  color: bookController.getBackgroundColor(
                      BookController.setting.value?.theme ??
                          ViewerThemes.light),
                ),
                if (controller.htmlData.value.isNotEmpty)
                  GestureDetector(
                      onHorizontalDragUpdate: (details) {
                        if ((details.primaryDelta ?? 0) > 0) {
                          controller.backChapter();
                        } else {
                          controller.nextChapter();
                        }
                      },
                      child: Scrollbar(
                        controller: controller.scrollController,
                        notificationPredicate: controller.scrollNotification,
                        trackVisibility: true,
                        child: SingleChildScrollView(
                          controller: controller.scrollController,
                          child: GestureDetector(
                            onTap: BookController.instance.toggleToolbar,
                            child: Column(
                              children: [
                                SizedBox(
                                  height: MediaQuery.of(context).padding.top,
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Html(
                                    data: controller.htmlData.value,
                                    style: {
                                      "*": Style(
                                        padding: EdgeInsets.all(0),
                                        margin: EdgeInsets.all(0),
                                        lineHeight: LineHeight(1),
                                      ),
                                      "body": Style(
                                        padding: EdgeInsets.all(0),
                                        margin: EdgeInsets.all(0),
                                        lineHeight: LineHeight(1),
                                      ),
                                      "p": Style(
                                          padding: EdgeInsets.symmetric(
                                              vertical: 8.h, horizontal: 2.h),
                                          lineHeight: LineHeight.number(1.1),
                                          fontFamily: BookController
                                              .setting.value?.font,
                                          fontSize: FontSize((BookController
                                                      .setting.value?.size ??
                                                  0)
                                              .h),
                                          color: bookController.getTextColor(
                                              BookController
                                                      .setting.value?.theme ??
                                                  ViewerThemes.light)),
                                      "strong": Style(
                                          padding: EdgeInsets.symmetric(
                                              vertical: 8.h, horizontal: 2.h),
                                          lineHeight: LineHeight.number(1.1),
                                          fontFamily: BookController
                                              .setting.value?.font,
                                          fontSize: FontSize((BookController
                                                      .setting.value?.size ??
                                                  0)
                                              .h),
                                          color: bookController.getTextColor(
                                              BookController
                                                      .setting.value?.theme ??
                                                  ViewerThemes.light)),
                                      ".chapTitle": Style(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 20),
                                        lineHeight: LineHeight.number(1.1),
                                        color: bookController.getTextColor(
                                            BookController
                                                    .setting.value?.theme ??
                                                ViewerThemes.light),
                                        fontFamily:
                                            BookController.setting.value?.font,
                                        fontSize: FontSize(((BookController
                                                        .setting.value?.size ??
                                                    22) *
                                                1.3)
                                            .h),
                                        fontWeight: FontWeight.bold,
                                      ),
                                    },
                                    // customRender: {
                                    //   (context) {} ,
                                    // },
                                    // customRenders: {
                                    //   (context) =>
                                    //           (context.tree.element?.localName == "p"):
                                    //       CustomRender.widget(widget: (context, child) {
                                    //     return Text(
                                    //       context.tree.element?.text ?? "",

                                    //       style: TextStyle(
                                    //           height: 1.1,

                                    //           fontFamily:
                                    //               BookController.setting.value?.font,
                                    //           fontSize:
                                    //               (BookController.setting.value?.size ??
                                    //                       0)
                                    //                   .h,
                                    //           color: bookController.getTextColor(
                                    //               BookController.setting.value?.theme ??
                                    //                   ViewerThemes.light)),
                                    //     );
                                    //   }),
                                    //   (context) => (context.tree.element?.className ==
                                    //           "chapTitle"):
                                    //       CustomRender.widget(widget: (context, child) {
                                    //     return Text(
                                    //       context.tree.element?.text ?? "",
                                    //       style: TextStyle(
                                    //         color: bookController.getTextColor(
                                    //             BookController.setting.value?.theme ??
                                    //                 ViewerThemes.light),
                                    //         fontFamily:
                                    //             BookController.setting.value?.font,
                                    //         fontSize:
                                    //             ((BookController.setting.value?.size ??
                                    //                         22) *
                                    //                     1.3)
                                    //                 .h,
                                    //         fontWeight: FontWeight.bold,
                                    //       ),
                                    //     );
                                    //   })
                                    // },
                                  ),
                                ),
                                SizedBox(
                                  height: BannerSize.BANNER.height.toDouble(),
                                ),
                              ],
                            ),
                          ),
                        ),
                      )),
                // Positioned(
                //   right: 12,
                //   top: MediaQuery.of(context).padding.top,
                //   child: ViewerScroller(
                //     maxPosition: controller.maxPosition.value,
                //     position: controller.position.value,
                //   ),
                // ),
                Positioned(
                  top: 0,
                  child: TopWidget(
                    controller: controller,
                  ),
                ),
                Positioned(
                  bottom: 0,
                  right: 0,
                  child: Column(
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width,
                        child: Obx(() {
                          if (AppController.currentRoute.value !=
                              ReadPage.route) {
                            return const SizedBox();
                          }
                          if (!AdsController.bannerAdAvailable.value ||
                              AdsController.bannerAd.value == null) {
                            return const SizedBox();
                          }
                          return AdsController.bannerAd.value!;
                        }),
                      ),
                      BottomWidget(
                        controller: controller,
                      ),
                    ],
                  ),
                ),
              ],
            );
          }
        }),
      ),
    );
  }
}

class BottomWidget extends StatelessWidget {
  final ReadController controller;
  BottomWidget({
    Key? key,
    required this.controller,
  }) : super(key: key);
  final bookController = BookController.instance;
  var showBanner = false;
  @override
  Widget build(BuildContext context) {
    return Obx(() => Visibility(
          visible: BookController.toolbarShowed.value,
          child: Column(
            children: [
              Container(
                width: MediaQuery.of(context).size.width,
                decoration:
                    BoxDecoration(color: Colors.black.withOpacity(0.86)),
                padding: EdgeInsets.only(
                  left: 8,
                  right: 8,
                  bottom: 8,
                ),
                child: Padding(
                  padding: EdgeInsets.all(8),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            width: 220,
                            child: FontSelectBox<String>(
                              height: 38,
                              items: BookController.fonts,
                              value: BookController.setting.value?.font,
                              onChanged: (value) {
                                if (value != null) {
                                  bookController.updateFont(value);
                                }
                              },
                            ),
                          ),
                          SizedBox(),
                          // IconButton(
                          //     onPressed: () {},
                          //     icon: Icon(
                          //       Icons.message,
                          //       color: Colors.white,
                          //       size: 32,
                          //     ))
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(children: [
                              InkWell(
                                onTap: () {
                                  bookController.updateFontSize(
                                      (BookController.setting.value?.size ??
                                              22) -
                                          0.5);
                                },
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    "A-",
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 22),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 8.0, horizontal: 8),
                                child: Text(
                                  (BookController.setting.value?.size ?? 22)
                                      .toStringAsFixed(1),
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 22),
                                ),
                              ),
                              InkWell(
                                onTap: () {
                                  bookController.updateFontSize(
                                      (BookController.setting.value?.size ??
                                              22) +
                                          0.5);
                                },
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    "A+",
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 22),
                                  ),
                                ),
                              ),
                            ]),
                            Expanded(
                              child: SelectTheme(
                                theme: ViewerThemes.light,
                                onChanged: bookController.updateTheme,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          IconButton(
                              onPressed: controller.backChapter,
                              icon: Icon(
                                Icons.chevron_left,
                                color: Colors.white,
                                size: 36,
                              )),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              "${controller.episode.value?.index ?? 1}/${BookController.currentBook.value?.totalEpisodes ?? 1}",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 18),
                            ),
                          ),
                          IconButton(
                              onPressed: controller.nextChapter,
                              icon: Icon(
                                Icons.chevron_right,
                                color: Colors.white,
                                size: 36,
                              )),
                        ],
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).padding.bottom,
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ));
  }
}

class SelectTheme extends StatelessWidget {
  String theme;
  ValueChanged<String>? onChanged;
  SelectTheme({Key? key, required this.theme, this.onChanged})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(children: [
        ChosenBackground(
          theme: ViewerThemes.light,
          onTap: onChanged,
        ),
        ChosenBackground(
          theme: ViewerThemes.dark,
          onTap: onChanged,
        ),
        ChosenBackground(
          theme: ViewerThemes.mid,
          onTap: onChanged,
        ),
        ChosenBackground(
          theme: ViewerThemes.none,
          onTap: onChanged,
        ),
      ]),
    );
  }
}

class ChosenBackground extends StatelessWidget {
  final String theme;
  final ValueChanged<String>? onTap;
  ChosenBackground({Key? key, required this.theme, this.onTap})
      : super(key: key);

  final controller = BookController.instance;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: InkWell(
        onTap: () {
          if (onTap != null) onTap!(theme);
        },
        child: Container(
          width: 32,
          height: 32,
          decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: controller.getBackgroundColor(theme),
              border:
                  Border.all(color: controller.getTextColor(theme), width: 3)),
          child: theme == BookController.setting.value?.theme
              ? Icon(
                  Icons.done,
                  color: AppTheme.successColor,
                )
              : const SizedBox(),
        ),
      ),
    );
  }
}

class TopWidget extends StatelessWidget {
  final ReadController controller;
  TopWidget({
    Key? key,
    required this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Visibility(
        visible: BookController.toolbarShowed.value,
        child: Container(
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(color: Colors.black.withOpacity(0.86)),
          padding: EdgeInsets.only(
            left: 8,
            right: 8,
            bottom: 8,
            top: MediaQuery.of(context).padding.top,
          ),
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: InkWell(
                  onTap: () async {
                    AppController.until(BookController.routeMarker);
                    if (BookController.routeMarker == BookDetailPage.route) {
                      AdsController.reShowBannerAds();
                      AppController.currentRoute.value = BookDetailPage.route;
                    }
                  },
                  child: Icon(
                    Icons.arrow_back,
                    size: 28,
                    color: Colors.white,
                  ),
                ),
              ),
              Expanded(
                  child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    controller.episode.value?.title ?? "",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontFamily:
                            BookController.setting.value?.font ?? "Roboto"),
                  ),
                ),
              )),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: IconButton(
                  icon: Icon(
                    Icons.cloud_download,
                    color: Colors.white,
                  ),
                  tooltip: 'Download book',
                  onPressed: BookController.instance.navigateToDownloadPage,
                ),
              ),
            ],
          ),
        ),
      );
    });
  }
}
