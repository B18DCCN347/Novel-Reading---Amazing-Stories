import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:love_novel/ui/components/app_search_bar.dart';
import 'package:love_novel/ui/components/app_theme.dart';
import 'package:love_novel/ui/pages/search/controller.dart';

class SearchView extends StatelessWidget {
  SearchView({Key? key}) : super(key: key);
  var controller = SearchController.instance;
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Obx(()=>Container(
      width: size.width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppSearchBar(
            title: "Search",
            onSubmited: controller.search,
          ),
          Expanded(
            child: Container(
              padding: EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if ((controller.caches.value ?? []).isNotEmpty)
                    SearchGroup(
                      title: "Search history",
                      items: (controller.caches.value ?? [])
                          .map((x) => x.name ?? "")
                          .toList(),
                      showDeleteButton: true,
                    ),
                  SearchGroup(
                    title: "Recommendations",
                    items: [
                      "Love",
                      "Life",
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    )) ;
  }
}

class SearchGroup extends StatelessWidget {
  final String title;
  final List<String> items;
  final bool showDeleteButton;
  const SearchGroup(
      {Key? key,
      required this.title,
      required this.items,
      this.showDeleteButton = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 8),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(title),
            if (showDeleteButton)
              Chip(
                label: Text("Clear"),
                onDeleted: SearchController.instance.clearCaches,
              )
          ],
        ),
        Wrap(
          children: items
              .map((e) => SearchTag(
                    keyword: e,
                  ))
              .toList(),
        )
      ]),
    );
  }
}

class SearchTag extends StatelessWidget {
  final String keyword;
  const SearchTag({Key? key, required this.keyword}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        SearchController.instance.search(keyword);
      },
      child: Container(
          padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
          margin: EdgeInsets.only(top: 8, bottom: 8, right: 8),
          decoration: BoxDecoration(
              color: AppTheme.greyColor,
              borderRadius: BorderRadius.all(Radius.circular(32))),
          child: Text(
            keyword,
            style: TextStyle(color: Colors.white),
          )),
    );
  }
}
