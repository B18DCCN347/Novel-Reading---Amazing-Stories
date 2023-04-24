import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:love_novel/data/models/public/book.dart';
import 'package:love_novel/ui/components/app_theme.dart';
import 'package:love_novel/ui/components/rounded_button.dart';
import 'package:love_novel/ui/pages/book/controller.dart';

class ContinueBookCard extends StatelessWidget {
  const ContinueBookCard({
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
        height: 180,
        width: MediaQuery.of(context).size.width * 0.75,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.all(
                Radius.circular(12),
              ),
              child: Container(
                  height: 180, child: BookController.instance.getImage(book)),
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
                          (book.title ?? ""),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 16),
                        ))
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8.0),
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
                    RatingBar.builder(
                      initialRating: book.stats?.rate ?? 0,
                      minRating: 1,
                      direction: Axis.horizontal,
                      allowHalfRating: true,
                      ignoreGestures: true,
                      itemCount: 5,
                      itemSize: 20,
                      unratedColor: AppTheme.goldColor,
                      itemBuilder: (context, _) => Icon(
                        Icons.star,
                        color: Colors.amber,
                      ),
                      onRatingUpdate: (rating) {},
                    ),
                    Spacer(),
                    RoundedButton(
                      text: "Continue",
                      onPressed: () {
                        BookController.currentBook.value = book;
                        BookController.instance.continueRead();
                      },
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
