import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:love_novel/data/models/public/book.dart';
import 'package:love_novel/ui/components/app_theme.dart';
import 'package:love_novel/ui/pages/book/controller.dart';
import 'package:love_novel/ui/pages/book/detail.dart';
import 'package:love_novel/ui/pages/discovery/controller.dart';

class HomeBookCard extends StatelessWidget {
  const HomeBookCard({
    Key? key,
    required this.book,
    this.onDeleted,
  }) : super(key: key);

  final Book book;
  final ValueChanged<Book>? onDeleted;

  @override
  Widget build(BuildContext context) {
    var _size = MediaQuery.of(context).size;
    return InkWell(
      onTap: () {
        BookController.instance.goToDetailPage(book);
      },
      child: Container(
        width: 200,
        padding: EdgeInsets.all(8),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.all(
                Radius.circular(12),
              ),
              child: Container(
                  width: _size.width * 0.21,
                  child: BookController.instance.getImage(book)),
            ),
            Container(
              width: _size.width * 0.4,
              padding: EdgeInsets.symmetric(horizontal: 8),
              height: _size.height * 0.2,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    (book.title ?? ""),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),

                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 4.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Flexible(
                          child: book.isEnded == 1
                              ? Text(
                                  "[FULL] ${book.totalEpisodes} chap",
                                  style: TextStyle(
                                    color: AppTheme.textPinkColor,
                                    fontWeight: FontWeight.w500,
                                  ),
                                )
                              : Text(
                                  "Last updated chapter ${book.totalEpisodes}",
                                  style: TextStyle(
                                    color: AppTheme.greyColor,
                                    fontWeight: FontWeight.w500,
                                  ),
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
                  ),
                  // Spacer(),
                  RatingBar.builder(
                    unratedColor: AppTheme.goldColor,
                    initialRating: book.stats?.rate ?? 0,
                    minRating: 1,
                    direction: Axis.horizontal,
                    allowHalfRating: true,
                    ignoreGestures: true,
                    itemCount: 5,
                    itemSize: 20,
                    itemBuilder: (context, _) => Icon(
                      Icons.star,
                      color: Colors.amber,
                    ),
                    onRatingUpdate: (rating) {},
                  ),
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
                                .getFavoriteTotalString(book.stats?.like ?? 0),
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
            )
          ],
        ),
      ),
    );
  }
}
