import 'dart:ui';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:love_novel/app/utils/string_helper.dart';
import 'package:love_novel/data/models/category/category.dart';
import 'package:love_novel/ui/components/app_menu_tab_bar.dart';
import 'package:love_novel/ui/components/app_scaffold.dart';
import 'package:love_novel/ui/components/app_theme.dart';
import 'package:love_novel/ui/components/disabled_book_card.dart';
import 'package:love_novel/ui/components/rounded_button.dart';
import 'package:love_novel/ui/pages/ads/controller.dart';
import 'package:love_novel/ui/pages/book/chapters.dart';
import 'package:love_novel/ui/pages/book/comments.dart';
import 'package:love_novel/ui/pages/book/controller.dart';
import 'package:love_novel/ui/pages/book/description.dart';

import '../../../app/global/controller.dart';
import '../../../app/utils/dialogs.dart';

class BookDetailPage extends StatelessWidget {
  BookDetailPage({
    Key? key,
  }) : super(key: key);
  static const route = '/bookDetail';
  final controller = BookController.instance;
  @override
  Widget build(BuildContext context) {
    controller.init();
    return AppScaffold(
      title: "Book detail",
      body: Obx(() {
        if (BookController.currentBook.value == null)
          return Center(
              child: CircularProgressIndicator(
            strokeWidth: 8,
          ));
        else {
          return CustomScrollView(
            //controller: controller.scrollController,
            slivers: <Widget>[
              SliverAppBar(
                pinned: true,
                floating: false,
                elevation: 0,
                flexibleSpace: LayoutBuilder(builder:
                    (BuildContext context, BoxConstraints constraints) {
                  var top = constraints.biggest.height;
                  return FlexibleSpaceBar(
                    centerTitle: true,
                    title: Opacity(
                      opacity: top < 110 ? 1 : 0,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(
                                left: 48,
                                right: 48,
                                top: MediaQuery.of(context).padding.top + 8),
                            child: Text(
                                (BookController.currentBook.value?.title ?? ""),
                                overflow: TextOverflow.ellipsis,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20.0.h,
                                )),
                          ),
                        ],
                      ),
                    ),
                    background: Container(
                      decoration: BoxDecoration(
                        image: (BookController
                                        .currentBook.value?.portraitThumb ??
                                    "")
                                .isEmpty
                            ? DecorationImage(
                                image:
                                    AssetImage("assets/images/no-image.jpeg"),
                                fit: BoxFit.cover,
                              )
                            : (BookController.currentBook.value?.cached ??
                                    false)
                                ? DecorationImage(
                                    image: MemoryImage(
                                        StringHelper.dataFromBase64String(
                                            BookController.currentBook.value
                                                    ?.portraitThumb ??
                                                "")),
                                    fit: BoxFit.cover,
                                  )
                                : DecorationImage(
                                    image: NetworkImage(BookController
                                            .currentBook.value?.portraitThumb ??
                                        ""),
                                    fit: BoxFit.cover,
                                  ),
                      ),
                      child: Stack(
                        alignment: Alignment.bottomLeft,
                        children: [
                          new BackdropFilter(
                            filter: new ImageFilter.blur(
                                sigmaX: 16.0, sigmaY: 16.0),
                            child: new Container(
                              decoration: new BoxDecoration(
                                  color: Colors.white.withOpacity(0.0)),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.all(16),
                            child: DisabledBookCard(
                                book: BookController.currentBook.value!),
                          )
                        ],
                      ),
                    ),
                  );
                }),
                expandedHeight: 260,
                backgroundColor: AppTheme.primaryColor,
                leading: IconButton(
                  icon: Icon(
                    Icons.arrow_back,
                    color: Colors.white,
                  ),
                  tooltip: 'Menu',
                  onPressed: () {
                    Get.back();
                  },
                ),
                actions: <Widget>[
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
              SliverAppBar(
                pinned: true,
                automaticallyImplyLeading: false,
                floating: false,
                toolbarHeight: 24.h,
                backgroundColor: Colors.white,
                flexibleSpace: AppMenuTabBar(
                  items: [
                    Category(id: 0, name: "Description"),
                    Category(id: 1, name: "Chapters"),
                    Category(id: 2, name: "Report"),
                  ],
                  currentIndex: controller.currentIndex.value,
                  onTap: controller.move,
                ),
              ),
              SliverFillRemaining(
                hasScrollBody: true,
                fillOverscroll: true,
                child: Column(
                  children: [
                    Expanded(
                      child: CarouselSlider(
                        items: [
                          DescriptionView(),
                          ChaptersView(),
                          CommentsView(),
                        ],
                        options: CarouselOptions(
                            scrollPhysics: const NeverScrollableScrollPhysics(),
                            enlargeCenterPage: false,
                            height: MediaQuery.of(context).size.height,
                            viewportFraction: 1),
                        carouselController: controller.carouselController,
                      ),
                    ),
                  ],
                ),
              )
            ], //<Widget>[]
          );
        }
      }),
      bottomNavigationBar: Container(
        height: MediaQuery.of(context).padding.bottom + 72,
        padding: EdgeInsets.only(
            left: 8,
            right: 8,
            top: 4,
            bottom: MediaQuery.of(context).padding.bottom),
        child: Row(
          children: [
            IconButton(
                onPressed: controller.share,
                icon: Icon(
                  Icons.share,
                  size: 32,
                  color: AppTheme.greyColor,
                )),
            Obx(() {
              return IconButton(
                  onPressed: controller.toggleLike,
                  icon: Icon(
                    Icons.favorite,
                    size: 32,
                    color:
                        (BookController.actionStatus.value?.hasLiked ?? false)
                            ? AppTheme.textPinkColor
                            : AppTheme.greyColor,
                  ));
            }),
            Obx(() {
              return IconButton(
                  onPressed: controller.rating,
                  icon: Icon(
                    Icons.star,
                    size: 32,
                    color: (BookController.actionStatus.value?.hasRate ?? false)
                        ? AppTheme.goldColor
                        : AppTheme.greyColor,
                  ));
            }),
            Obx(() {
              return Expanded(
                  child: RoundedButton(
                text: (BookController.actionStatus.value?.hasRead ?? false)
                    ? "Continue Chapter ${BookController.actionStatus.value?.episodeIndex ?? 1}"
                    : "Start Reading",
                onPressed: () {
                  AppController.timeMarker =
                      DateTime.now().microsecondsSinceEpoch;
                  ChaptersController.instance.startRead(route);
                },
              ));
            })
          ],
        ),
      ),
    );
  }
}
