import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:love_novel/app/global/controller.dart';
import 'package:love_novel/ui/components/app_buttons.dart';
import 'package:love_novel/ui/components/app_theme.dart';
import 'package:love_novel/ui/pages/webview/webview.dart';

class CommentsView extends StatelessWidget {
  const CommentsView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(
          height: MediaQuery.of(context).size.height * .1,
        ),
        Container(
          width: MediaQuery.of(context).size.width * .6,
          padding: EdgeInsets.all(4),
          child: Text(
            "If you are suffering  any trouble while enjoying this content,\nfeel free to query us.",
            maxLines: 3,
            textAlign: TextAlign.center,
            style: TextStyle(
                color: AppTheme.greyColor,
                fontWeight: FontWeight.bold,
                height: 1.1),
          ),
        ),
        SmallRoundedButton(
          text: " Contact Support  ",
          color: AppTheme.successColor,
          onPressed: () {
            AppController.toNamed(WebViewPage.route);
          },
        )
      ],
    );
  }
}

class CommentRow extends StatelessWidget {
  const CommentRow({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
          border: Border(top: BorderSide(color: AppTheme.disabledColorLight))),
      child: Row(
        children: [
          CircleAvatar(
            radius: 32,
            child: Text(
              "Ve",
              style: TextStyle(color: AppTheme.brightColor, fontSize: 32),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Vevu",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                ),
                RatingBar.builder(
                  unratedColor: AppTheme.goldColor,
                  initialRating: 5,
                  minRating: 1,
                  direction: Axis.horizontal,
                  allowHalfRating: true,
                  itemCount: 5,
                  itemSize: 20,
                  itemBuilder: (context, _) => Icon(
                    Icons.star,
                    color: Colors.amber,
                  ),
                  onRatingUpdate: (rating) {},
                ),
                Text(
                  "I can't continue reading, what had happend??",
                  style: TextStyle(height: 1.4),
                ),
                Text(
                  "24 giờ trước",
                  style: TextStyle(fontSize: 12),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
