import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:love_novel/data/models/category/category.dart';
import 'package:love_novel/ui/components/app_menu_bar.dart';
import 'package:love_novel/ui/components/app_menu_tab_bar.dart';
import 'package:love_novel/ui/components/app_theme.dart';
import 'package:love_novel/ui/pages/your_books/controller.dart';
import 'package:love_novel/ui/pages/your_books/downloaded.dart';
import 'package:love_novel/ui/pages/your_books/favorite.dart';
import 'package:love_novel/ui/pages/your_books/history.dart';

class YourBooksView extends StatelessWidget {
  YourBooksView({Key? key}) : super(key: key);
  var controller = YourBooksController.instance;
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Container(
      child: Column(
        children: [
          AppMenuBar(title: "Your Books"),
          Obx(() => AppMenuTabBar(
                items: [
                  Category(id: 0, name: "History"),
                  Category(id: 1, name: "Favorite"),
                  Category(id: 2, name: "Downloaded"),
                ],
                currentIndex: YourBooksController.currentIndex.value,
                onTap: controller.move,
              )),
          Expanded(
            child: CarouselSlider(
              items: [
                HistoryTabView(),
                FavoriteTabView(),
                DownloadedTabView(),
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
    );
  }
}

class YourBooksGroup extends StatelessWidget {
  final String title;
  final List<String> items;
  const YourBooksGroup({
    Key? key,
    required this.title,
    required this.items,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 8),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(title),
        Wrap(
          children: items
              .map((e) => YourBooksTag(
                    keyword: e,
                  ))
              .toList(),
        )
      ]),
    );
  }
}

class YourBooksTag extends StatelessWidget {
  final String keyword;
  const YourBooksTag({Key? key, required this.keyword}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        margin: EdgeInsets.only(top: 8, bottom: 8, right: 8),
        decoration: BoxDecoration(
            color: AppTheme.greyColor,
            borderRadius: BorderRadius.all(Radius.circular(32))),
        child: Text(
          keyword,
          style: TextStyle(color: Colors.white),
        ));
  }
}
