import 'dart:developer';

import 'package:applovin_max/applovin_max.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:love_novel/app/global/arguments.dart';
import 'package:love_novel/app/global/controller.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:love_novel/app/global/hivebox_controller.dart';
import 'package:love_novel/data/models/public/book.dart';
import 'package:love_novel/data/models/public/book_collection.dart';
import 'package:love_novel/data/repositories/book.dart';
import 'package:love_novel/ui/components/app_buttons.dart';
import 'package:love_novel/ui/components/app_theme.dart';
import 'package:love_novel/ui/components/continue_book_card.dart';
import 'package:love_novel/ui/components/home_book_card.dart';
import 'package:love_novel/ui/components/texts.dart';
import 'package:love_novel/ui/pages/ads/controller.dart';
import 'package:love_novel/ui/pages/discovery/discovery_books_view.dart';
import 'package:love_novel/ui/pages/discovery/lastest_release.dart';
import 'package:love_novel/ui/pages/genres/controller.dart';
import 'package:love_novel/ui/pages/remove_ads/controller.dart';
import 'package:love_novel/ui/pages/remove_ads/remove_ads.dart';
import 'package:love_novel/ui/pages/your_books/history.dart';

class DiscoverySubController extends GetxController {
  static DiscoverySubController get instance =>
      Get.isRegistered<DiscoverySubController>()
          ? Get.find()
          : Get.put(DiscoverySubController());
  final appController = AppController.instance;
  final historyController = HistoryTabViewController.instance;
  final lastestReleaseController = LastestReleaseController.instance;
  final hiveBoxController = HiveBoxController.instance;
  CarouselController carouselController = CarouselController();
  var books = Rxn<List<Book>>();
  static var collections = Rxn<List<BookCollection>>();

  init() async {
    if ((collections.value ?? []).isEmpty) {
      var items = await BookRepository().discovery().catchError((error) {
        debugPrint(error.toString());
      });
      collections.value = items;
      await historyController.init();
    }
  }
}

class DiscoverySubView extends StatelessWidget {
  DiscoverySubView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    DiscoverySubController.instance.init();
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          ContinueBooksRow(),
          if (AppController.hasConnection)
            Obx(() {
              if (DiscoverySubController.collections.value == null) {
                return Padding(
                  padding: EdgeInsets.all(32.0.h),
                  child: const Center(
                      child: CircularProgressIndicator(
                    strokeWidth: 8,
                  )),
                );
              } else {
                List list = [];
                if (DiscoverySubController.collections.value!.isNotEmpty &&
                    DiscoverySubController.collections.value!.length == 6) {
                  list =
                      DiscoverySubController.collections.value!.sublist(1, 6);
                } else if (DiscoverySubController.collections.value!.length ==
                    5) {
                  list = DiscoverySubController.collections.value!;
                } else {
                  list = [];
                }
                var row = 0;
                return Column(
                  children: (list).map((e) {
                    ++row;
                    return DiscoveryBooksRow(
                      collection: e,
                      // rowNumber: 3,

                      rowNumber: row == 2 ? 3 : 2,
                    );
                  }).toList(),
                );
              }
            })
        ],
      ),
    );
  }
}

class ContinueBooksRow extends StatelessWidget {
  ContinueBooksRow({
    Key? key,
  }) : super(key: key);

  var _controller = DiscoverySubController.instance;
  var removeAdsController = RemoveAdsController.instance;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Obx(() {
          if ((_controller.historyController.books.value ?? []).length > 0)
            return Row(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    "Continue reading...",
                    style: TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 18, height: 2),
                  ),
                )
              ],
            );
          return const SizedBox();
        }),
        Row(
          children: [
            Expanded(
              child: Obx(() {
                if ((_controller.historyController.books.value ?? []).length >
                    0) {
                  return SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    controller: _controller
                        .historyController.horizontalScrollController,
                    child: Row(
                      children: _controller.historyController.books.value
                              ?.map((data) => ContinueBookCard(
                                    book: data,
                                  ))
                              .toList() ??
                          [],
                    ),
                  );
                } else
                  return const SizedBox();
              }),
            ),
          ],
        ),
        Obx(() {
          return AppController.hasConnection
              ? Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SmallRoundedButton(
                        text: "Remove Ads",
                        width: MediaQuery.of(context).size.width * .68,
                        color: AppTheme.greyColorDark,
                        onPressed: () {
                          // AppLovinMAX.showMediationDebugger();
                          AppController.toNamed(RemoveAdsPage.route);
                        },
                      ),
                    )
                  ],
                )
              : const SizedBox();
        }),
      ],
    );
  }
}

class DiscoveryBooksController extends GetxController {
  int offset;
  final String codeName;
  final String title;
  final RxList<Book> books;
  DiscoveryBooksController(
      {required this.codeName,
      required this.title,
      required this.offset,
      required this.books});
  final appController = AppController.instance;
  CarouselController carouselController = CarouselController();
  int count = 12;
  int pageLength = 12;
  var loadingMore = false.obs;
  var hasNext = true;

  ScrollController? scrollController;
  ScrollController? horizontalScrollController;

  init() async {
    scrollController = ScrollController()..addListener(_scrollListener);
    horizontalScrollController = ScrollController()
      ..addListener(_horizontalScrollListener);
    count = 12;
    pageLength = 12;
    loadingMore.value = false;
    hasNext = true;
    await loadBooks();
  }

  Future<void> _scrollListener() async {
    if ((scrollController?.position.extentAfter ?? 0) < 900) {
      if (!loadingMore.value && hasNext) {
        loadingMore.value = true;
        await loadBooks();
        loadingMore.value = false;
      }
    }
  }

  final hiveBoxController = HiveBoxController.instance;
  Future<void> _horizontalScrollListener() async {
    if ((horizontalScrollController?.position.extentAfter ?? 0) < 200) {
      await loadBooks();
    }
  }

  loadBooks() async {
    if (!loadingMore.value && hasNext) {
      loadingMore.value = true;
      try {
        if (AppController.hasConnection && codeName.isNotEmpty) {
          var rp =
              await BookRepository().booksByCodeName(codeName, offset, count);
          var bItems = (rp?.data ?? [])
            ..forEach((element) {
              element.bindCategory(GenresController.genres.value ?? []);
            });
          books.value = books.value..addAll(bItems);
          books.refresh();
          if (rp != null) {
            offset += pageLength;
            hasNext = rp.hasNext ?? false;
          }
          await hiveBoxController.updateHotBooks(books.value);
        }
      } catch (e) {}
      loadingMore.value = false;
    }
  }
}

class DiscoveryBooksRow extends StatefulWidget {
  final BookCollection collection;
  final int rowNumber;
  DiscoveryBooksRow({Key? key, required this.collection, this.rowNumber = 2})
      : super(key: key);

  @override
  State<DiscoveryBooksRow> createState() => _DiscoveryBooksRowState();
}

class _DiscoveryBooksRowState extends State<DiscoveryBooksRow> {
  late DiscoveryBooksController controller;
  @override
  void initState() {
    super.initState();
    var books = (widget.collection.items ?? []);
    controller = DiscoveryBooksController(
        codeName: widget.collection.codeName ?? "",
        title: widget.collection.title ?? "",
        offset: books.length,
        books: books.obs);
    Get.put(controller, tag: controller.codeName);
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      await controller.init();
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                widget.collection.title ?? "",
                style: TextStyle(
                    fontWeight: FontWeight.bold, fontSize: 18, height: 2),
              ),
            ),
            InkWell(
              onTap: () {
                AppController.toNamed(DiscoveryBooksView.route,
                    arguments: DiscoveryArguments(controller: controller));
              },
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "See All",
                ),
              ),
            )
          ],
        ),
        Obx(() {
          if (controller.books.value == null)
            return Container(
              height: 200,
              child: Center(
                  child: CircularProgressIndicator(
                strokeWidth: 8,
              )),
            );
          else {
            if (controller.books.value.length > 0) {
              return Row(
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.width *
                        (widget.rowNumber / 3) *
                        1.1,
                    child: GridView.count(
                      scrollDirection: Axis.horizontal,
                      controller: controller.horizontalScrollController,
                      crossAxisCount: widget.rowNumber,
                      childAspectRatio: 0.52,
                      crossAxisSpacing: 0,
                      mainAxisSpacing: 20,
                      children: controller.books.value
                          .map((data) => HomeBookCard(
                                book: data,
                              ))
                          .toList(),
                    ),
                  ),
                ],
              );
            } else
              return Container(
                height: 200,
                child: Center(child: DisabledText("No data found")),
              );
          }
        })
      ],
    );
  }
}
