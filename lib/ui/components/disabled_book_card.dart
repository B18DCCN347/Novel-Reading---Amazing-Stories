import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:love_novel/app/global/controller.dart';
import 'package:love_novel/data/models/public/book.dart';
import 'package:love_novel/ui/components/app_theme.dart';
import 'package:love_novel/ui/pages/book/controller.dart';
import 'package:love_novel/ui/pages/book/detail.dart';
import 'package:love_novel/ui/pages/discovery/controller.dart';
import 'package:love_novel/ui/pages/genres/books.dart';
import 'package:love_novel/ui/pages/genres/controller.dart';

class DisabledBookCard extends StatelessWidget {
  const DisabledBookCard({
    Key? key,
    required this.book,
  }) : super(key: key);

  final Book book;

  @override
  Widget build(BuildContext context) {
    book.bindCategory(GenresController.genres.value ?? []);
    return InkWell(
      onTap: () {
        BookController.instance.goToDetailPage(book);
      },
      child: Container(
        padding: EdgeInsets.all(8),
        height: 186,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.all(
                Radius.circular(12),
              ),
              child: BookController.instance.getImage(book),
            ),
            Expanded(
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                            child: Text(
                          book.title ?? "",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                              color: Colors.white),
                        ))
                      ],
                    ),
                    Row(
                      children: [
                        Expanded(
                            child: Text(
                          (book.author ?? ""),
                          style: TextStyle(fontSize: 16, color: Colors.white),
                        ))
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: (book.categories ?? [])
                              .map((e) => InkWell(
                                    onTap: () {
                                      GenresController.instance.genre.value = e;
                                      AppController.toNamed(GenresBooksView.route);
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.all(2),
                                      child: Container(
                                        decoration: BoxDecoration(
                                          color: AppTheme.greyColor,
                                          borderRadius:
                                              BorderRadius.circular(8),
                                          boxShadow: AppTheme.boxShadows,
                                        ),
                                        padding: EdgeInsets.symmetric(
                                            vertical: 8, horizontal: 4),
                                        child: Text(
                                          e.name ?? "",
                                          style: TextStyle(
                                            color: AppTheme.brightColor,
                                            fontSize: 11,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ))
                              .toList(),
                        ),
                      ),
                    ),
                    book.isEnded == 1
                        ? Text(
                            "[FULL] ${book.totalEpisodes} chap",
                            style: TextStyle(
                              fontSize: 11,
                              color: AppTheme.textPinkColor,
                              fontWeight: FontWeight.w500,
                            ),
                          )
                        : Text(
                            "Last updated chapter ${book.totalEpisodes}",
                            style: TextStyle(
                              fontSize: 11,
                              color: AppTheme.greyColor,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                    if ((book.stats?.like ?? 0) > 0)
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 4.0),
                          child: Row(
                            children: [
                              Icon(
                                Icons.favorite,
                                color: AppTheme.greyColor,
                              ),
                              Text(
                                DiscoveryController.instance
                                    .getFavoriteTotalString(
                                        book.stats?.like ?? 0),
                                style: TextStyle(
                                  color: AppTheme.greyColor,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                      )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
