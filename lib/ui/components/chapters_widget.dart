import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:love_novel/app/global/arguments.dart';
import 'package:love_novel/app/global/controller.dart';
import 'package:love_novel/data/models/public/episode.dart';
import 'package:love_novel/ui/components/app_theme.dart';
import 'package:love_novel/ui/pages/book/controller.dart';
import 'package:love_novel/ui/pages/book/detail.dart';
import 'package:love_novel/ui/pages/book/read.dart';

class ChaptersWidget extends StatelessWidget {
  final ScrollController? controller;
  const ChaptersWidget(this.data, {Key? key, this.controller})
      : super(key: key);

  final List<Episode> data;

  @override
  Widget build(BuildContext context) {
    var count = 1;
    return SingleChildScrollView(
      controller: controller,
      child: Padding(
        padding: EdgeInsets.only(bottom: MediaQuery.of(context).padding.bottom),
        child: Column(
          children: data
              .map((item) => ChapterItem(
                    chapter: item,
                  ))
              .toList(),
        ),
      ),
    );
  }
}

class ChapterItem extends StatelessWidget {
  final Episode chapter;
  const ChapterItem({
    Key? key,
    required this.chapter,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        BookController.routeMarker = BookDetailPage.route;
        AppController.toNamed(ReadPage.route,
            arguments: EpisodeArguments(episode: chapter));
      },
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 24, horizontal: 16),
        decoration: BoxDecoration(
            border:
                Border(top: BorderSide(color: AppTheme.disabledColorLight))),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Expanded(
              child: Text(
                "${chapter.title}",
                style: TextStyle(fontSize: 18),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
