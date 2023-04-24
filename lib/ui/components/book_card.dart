import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:love_novel/data/models/public/book.dart';
import 'package:love_novel/ui/components/app_theme.dart';
import 'package:love_novel/ui/pages/book/controller.dart';
import 'package:love_novel/ui/pages/discovery/controller.dart';

class BookCard extends StatelessWidget {
  const BookCard({
    Key? key,
    required this.book,
    this.onDeleted,
  }) : super(key: key);

  final Book book;
  final ValueChanged<Book>? onDeleted;

  @override
  Widget build(BuildContext context) {
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
                    Text(
                      book.title ?? "",
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: (book.categories ?? [])
                              .map((e) => Padding(
                                    padding: const EdgeInsets.all(2),
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color: AppTheme.greyColor,
                                        borderRadius: BorderRadius.circular(8),
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
                                  ))
                              .toList(),
                        ),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
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
                        if (onDeleted != null)
                          IconButton(
                              onPressed: () {
                                onDeleted!(book);
                              },
                              icon: Icon(
                                FontAwesomeIcons.circleMinus,
                                color: AppTheme.errorColor,
                              ))
                      ],
                    ),
                    Spacer(),
                    if ((book.stats?.like ?? 0) > 0)
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 4.0),
                        child: Row(
                          children: [
                            Icon(
                              Icons.favorite,
                              color: AppTheme.textPinkColor,
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
