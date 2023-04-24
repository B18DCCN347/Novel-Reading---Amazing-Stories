import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:love_novel/app/global/controller.dart';
import 'package:love_novel/app/global/hivebox_controller.dart';
import 'package:love_novel/app/global/remote_config.dart';
import 'package:love_novel/app/utils/dialogs.dart';
import 'package:love_novel/data/models/public/download_package.dart';
import 'package:love_novel/data/repositories/book.dart';
import 'package:love_novel/ui/components/app_theme.dart';
import 'package:love_novel/ui/pages/ads/controller.dart';
import 'package:love_novel/ui/pages/book/controller.dart';
import 'package:love_novel/ui/pages/remove_ads/controller.dart';
import 'package:love_novel/ui/pages/your_books/downloaded.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../pages/book/download.dart';

class DownloadChapterBox extends StatefulWidget {
  final DownloadPackage data;
  const DownloadChapterBox(
    this.data, {
    Key? key,
  }) : super(key: key);

  @override
  State<DownloadChapterBox> createState() => _DownloadChapterBoxState();
}

class _DownloadChapterBoxState extends State<DownloadChapterBox> {
  var _loading = false;
  var _downloaded = false;
  var prefs;
  final appController = AppController.instance;
  final hiveBoxController = HiveBoxController.instance;
  var numLoaded;
  @override
  void initState() {
    super.initState();
    // initPref();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      var existItem =
          await hiveBoxController.getDownloadPackage(widget.data.id ?? "");

      if (existItem != null) {
        if (existItem.hash != widget.data.hash) {
          await downloadPackage();
        }
        if (mounted) {
          setState(() {
            _downloaded = true;
          });
        }
      }
    });
  }

  // initPref() async {
  //   prefs = await SharedPreferences.getInstance();
  //   var bookId = BookController.currentBook.value?.uuid ?? "";
  //   numLoaded = await prefs.getInt('numLoaded__${bookId}');
  //   print(numLoaded.toString() + "__________sdsdgsdgsdfg");
  // }

  downloadPackage() async {
    if (mounted) {
      setState(() {
        _loading = true;
      });
    }
    var response = await BookRepository()
        .downloadPackage(widget.data.id ?? "", widget.data.hash ?? "");
    if (response?.data != null) {
      response!.data!.bookId = BookController.currentBook.value!.uuid;

      await hiveBoxController.saveOrUpdateDownloadPackage(response.data!);
      var book = BookController.currentBook.value!;
      book.order = DateTime.now().millisecondsSinceEpoch;
      await hiveBoxController.saveOrUpdateBook(book, downloaded: true);
      _downloaded = true;
      await DownloadedTabViewController.instance.init();
    }
    _loading = false;
    if (mounted) {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    var startChapter = widget.data.pageIndex == 0
        ? 1
        : (widget.data.pageIndex ?? 0) * (widget.data.pageSize ?? 0);
    var endChapter = widget.data.pageIndex == 0
        ? (widget.data.pageSize ?? 0) - 1
        : (((widget.data.pageIndex ?? 0) + 1) * (widget.data.pageSize ?? 0)) -
            1;
    var total = BookController.currentBook.value?.totalEpisodes ?? 0;
    if (endChapter > total) endChapter = total;
    return InkWell(
      onTap: () async {
        double ok = -1;
        if (!_downloaded) {
          if (RemoveAdsController.needToShowAds) {
            if (DownloadController.numberLoaded >= 3 && RemoteAds.adsReward) {
              ok = await Dialogs.showRewardOrVideo();
              // Dialogs.showProgress();
              // await AdsController.showRewardedVideo();
              // Dialogs.hideProgress();

            }
          }
          if (ok != 0.0) {
            await downloadPackage();
            setState(
              () {
                DownloadController.numberLoaded =
                    DownloadController.numberLoaded + 1;
                // print(numLoaded);
                // var bookId = BookController.currentBook.value?.uuid ?? "";
                // prefs.setInt('numLoaded__${bookId}', numLoaded);
              },
            );
          }
        }
      },
      child: Container(
        alignment: Alignment.center,
        padding: EdgeInsets.symmetric(horizontal: 16),
        margin: EdgeInsets.all(8),
        decoration: BoxDecoration(
            color: AppTheme.greyColorDark,
            borderRadius: BorderRadius.all(Radius.circular(12)),
            boxShadow: AppTheme.boxShadows),
        child: _loading
            ? Center(
                child: CircularProgressIndicator(),
              )
            : Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "$startChapter-$endChapter",
                    style: TextStyle(
                        color: AppTheme.brightColor,
                        fontWeight: FontWeight.bold),
                  ),
                  if (_downloaded) Spacer(),
                  if (_downloaded)
                    Icon(
                      Icons.check,
                      color: AppTheme.successColor,
                    )
                ],
              ),
      ),
    );
  }
}
