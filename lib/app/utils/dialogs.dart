import 'dart:async';
import 'package:basic_utils/basic_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:love_novel/app/global/controller.dart';
import 'package:love_novel/ui/components/app_theme.dart';
import 'package:love_novel/ui/components/rounded_button.dart';
import 'package:love_novel/ui/components/texts.dart';
import 'package:love_novel/ui/pages/remove_ads/remove_ads.dart';

import '../../ui/pages/ads/controller.dart';

class Dialogs {
  static _(BuildContext context, String key) => "__dialogUtils__";

  static Future<void> alert(
      {String title = "Notification", required String message}) {
    return Get.defaultDialog(
        barrierDismissible: false,
        title: title,
        middleText: message,
        confirm: InkWell(
          onTap: () {
            Get.back();
          },
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
                color: AppTheme.successColor,
                borderRadius: BorderRadius.circular(24)),
            child: Text("Ok",
                style: TextStyle(
                    color: AppTheme.brightColor, fontWeight: FontWeight.bold)),
          ),
        ));
  }

  static Future<bool> confirm({String? title, required String message}) async {
    var ok = await Get.dialog<bool>(
      SafeArea(child: Builder(builder: (context) {
        return Material(
          color: Colors.black.withOpacity(0.1),
          child: Center(
            child: Column(
              children: <Widget>[
                Spacer(),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  width: MediaQuery.of(context).size.width * .9,
                  decoration: BoxDecoration(
                    color: AppTheme.backgroundColorLight,
                    borderRadius: BorderRadius.circular(24),
                  ),
                  child: Column(
                    children: <Widget>[
                      Container(
                        child: Text(
                          title ?? "Xác nhận",
                          style: TextStyle(
                              color: AppTheme.primaryColorDark,
                              fontWeight: FontWeight.bold,
                              fontSize: 20),
                        ),
                      ),
                      Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                        child: Text(
                          message,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: AppTheme.textColor, fontSize: 15),
                        ),
                      ),
                      Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.all(3.0),
                              child: InkWell(
                                onTap: () {
                                  Navigator.pop(context, false);
                                },
                                child: Container(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 16, vertical: 8),
                                  decoration: BoxDecoration(
                                      color: AppTheme.errorColor,
                                      borderRadius: BorderRadius.circular(8)),
                                  child: Text("Cancel",
                                      style: TextStyle(
                                          color: AppTheme.brightColor,
                                          fontWeight: FontWeight.bold)),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(3.0),
                              child: InkWell(
                                onTap: () {
                                  Navigator.pop(context, true);
                                },
                                child: Container(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 16, vertical: 8),
                                  decoration: BoxDecoration(
                                      color: AppTheme.primaryColor,
                                      borderRadius: BorderRadius.circular(8)),
                                  child: Text("Ok",
                                      style: TextStyle(
                                          color: AppTheme.brightColor,
                                          fontWeight: FontWeight.bold)),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Spacer(),
              ],
            ),
          ),
        );
      })),
      barrierDismissible: false,
    );
    return ok ?? false;
  }

  static Future<bool> showAd({required Widget addWidget}) async {
    var ok = await Get.dialog<bool>(
      SafeArea(child: Builder(builder: (context) {
        return Material(
          color: Colors.black.withOpacity(0.1),
          child: Center(
            child: Column(
              children: <Widget>[
                Spacer(),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  width: MediaQuery.of(context).size.width * .9,
                  decoration: BoxDecoration(
                    color: AppTheme.backgroundColorLight,
                    borderRadius: BorderRadius.circular(24),
                  ),
                  child: Column(
                    children: <Widget>[
                      Row(
                        children: [Spacer(), Icon(Icons.close)],
                      ),
                      Container(
                          padding:
                              EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                          child: addWidget),
                    ],
                  ),
                ),
                Spacer(),
              ],
            ),
          ),
        );
      })),
      barrierDismissible: false,
    );
    return ok ?? false;
  }

  static Future<double?> promptCurrentcy(
      {String? title, String? message, String? value}) async {
    final inputController = TextEditingController(text: value);
    double _value = 0;
    return await showDialog<double>(
      context: Get.context as BuildContext,
      builder: (BuildContext buildContext) {
        return SafeArea(
          child: StatefulBuilder(builder: (context, setState) {
            inputController.addListener(() {
              setState(() {
                _value = double.tryParse(inputController.text) ?? 0;
              });
            });
            return Material(
              color: Colors.black.withOpacity(0.1),
              child: Center(
                child: Column(
                  children: <Widget>[
                    Spacer(),
                    Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      width: MediaQuery.of(context).size.width * .9,
                      decoration: BoxDecoration(
                        color: AppTheme.backgroundColorLight,
                        borderRadius: BorderRadius.circular(24),
                      ),
                      child: Column(
                        children: <Widget>[
                          Container(
                            child: Text(
                              title ?? "Nhập dữ liệu",
                              style: TextStyle(
                                  color: AppTheme.primaryColorDark,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20),
                            ),
                          ),
                          SingleChildScrollView(
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 16, vertical: 8),
                              child: Column(
                                children: <Widget>[
                                  Padding(
                                    padding: EdgeInsets.only(bottom: 10),
                                    child: Text(
                                      message ?? "",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          color: AppTheme.textColor,
                                          fontSize: 15),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 40,
                                    child: TextField(
                                      controller: inputController,
                                      style: TextStyle(fontSize: 18),
                                      textAlign: TextAlign.center,
                                      keyboardType: TextInputType.number,
                                      decoration: InputDecoration(
                                          contentPadding: EdgeInsets.all(1),
                                          border: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(8),
                                              borderSide: BorderSide(
                                                  color: AppTheme
                                                      .primaryColorLight,
                                                  width: 1))),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 16, vertical: 8),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.all(3.0),
                                  child: InkWell(
                                    onTap: () {
                                      Get.back();
                                    },
                                    child: Container(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 16, vertical: 8),
                                      decoration: BoxDecoration(
                                          color: AppTheme.errorColor,
                                          borderRadius:
                                              BorderRadius.circular(8)),
                                      child: Text("Cancel",
                                          style: TextStyle(
                                              color: AppTheme.brightColor,
                                              fontWeight: FontWeight.bold)),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(3.0),
                                  child: InkWell(
                                    onTap: () {
                                      if (_value > 0) Get.back(result: _value);
                                    },
                                    child: Container(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 16, vertical: 8),
                                      decoration: BoxDecoration(
                                          color: _value > 0
                                              ? AppTheme.primaryColor
                                              : Colors.blueGrey,
                                          borderRadius:
                                              BorderRadius.circular(8)),
                                      child: Text("Ok",
                                          style: TextStyle(
                                              color: AppTheme.brightColor,
                                              fontWeight: FontWeight.bold)),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Spacer(),
                  ],
                ),
              ),
            );
          }),
        );
      },
      barrierDismissible: false,
    );
  }

  static Future<String?> prompt(
      {required BuildContext context,
      String? title,
      String? message,
      String? value,
      bool obscured = false}) async {
    final inputController = TextEditingController(text: value);
    String? _password;
    return await showDialog<String>(
      context: context,
      builder: (BuildContext buildContext) {
        return SafeArea(
          child: StatefulBuilder(builder: (context, setState) {
            inputController.addListener(() {
              setState(() {
                _password = inputController.text;
              });
            });
            return Material(
              color: Colors.black.withOpacity(0.1),
              child: Center(
                child: Column(
                  children: <Widget>[
                    Spacer(),
                    Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      width: MediaQuery.of(context).size.width * .9,
                      decoration: BoxDecoration(
                        color: AppTheme.backgroundColorLight,
                        borderRadius: BorderRadius.circular(24),
                      ),
                      child: Column(
                        children: <Widget>[
                          Container(
                            child: Text(
                              title ?? "Xác nhận",
                              style: TextStyle(
                                  color: AppTheme.primaryColorDark,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20),
                            ),
                          ),
                          SingleChildScrollView(
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 16, vertical: 8),
                              child: Column(
                                children: <Widget>[
                                  Padding(
                                    padding: EdgeInsets.only(bottom: 10),
                                    child: Text(
                                      message ?? "",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          color: AppTheme.textColor,
                                          fontSize: 15),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 40,
                                    child: TextField(
                                      controller: inputController,
                                      obscureText: obscured,
                                      style: TextStyle(fontSize: 18),
                                      textAlign: TextAlign.center,
                                      decoration: InputDecoration(
                                          contentPadding: EdgeInsets.all(1),
                                          border: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(8),
                                              borderSide: BorderSide(
                                                  color: AppTheme
                                                      .primaryColorLight,
                                                  width: 1))),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 16, vertical: 8),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.all(3.0),
                                  child: InkWell(
                                    onTap: () {
                                      Navigator.pop(context, null);
                                    },
                                    child: Container(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 16, vertical: 8),
                                      decoration: BoxDecoration(
                                          color: AppTheme.errorColor,
                                          borderRadius:
                                              BorderRadius.circular(8)),
                                      child: Text("Cancel",
                                          style: TextStyle(
                                              color: AppTheme.brightColor,
                                              fontWeight: FontWeight.bold)),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(3.0),
                                  child: InkWell(
                                    onTap: StringUtils.isNotNullOrEmpty(
                                            _password)
                                        ? () {
                                            Navigator.pop(context, _password);
                                          }
                                        : null,
                                    child: Container(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 16, vertical: 8),
                                      decoration: BoxDecoration(
                                          color: StringUtils.isNotNullOrEmpty(
                                                  _password)
                                              ? AppTheme.primaryColor
                                              : Colors.blueGrey,
                                          borderRadius:
                                              BorderRadius.circular(8)),
                                      child: Text("Ok",
                                          style: TextStyle(
                                              color: AppTheme.brightColor,
                                              fontWeight: FontWeight.bold)),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Spacer(),
                  ],
                ),
              ),
            );
          }),
        );
      },
      barrierDismissible: false,
    );
  }

  static hideProgress() {
    Get.back();
  }

  static Future<Dialog?> showProgress({String? message}) {
    return Get.generalDialog(
      pageBuilder: (BuildContext buildContext, Animation<double> animation,
          Animation<double> secondaryAnimation) {
        return SafeArea(
          child: Builder(builder: (context) {
            return Material(
              color: AppTheme.backgroundColor.withOpacity(0.1),
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: Column(
                  children: [
                    Spacer(),
                    Container(
                      padding: EdgeInsets.all(16),
                      width: MediaQuery.of(context).size.width * .86,
                      decoration: BoxDecoration(
                          color: AppTheme.backgroundColorLight,
                          borderRadius: BorderRadius.circular(8.0)),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Container(
                            child: CircularProgressIndicator(
                              strokeWidth: 8,
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: 8),
                            child: Text(
                              message ?? "Please wait...",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: AppTheme.textColor, fontSize: 15),
                            ),
                          )
                        ],
                      ),
                    ),
                    Spacer(),
                  ],
                ),
              ),
            );
          }),
        );
      },
      barrierDismissible: false,
      barrierLabel: MaterialLocalizations.of(Get.context as BuildContext)
          .modalBarrierDismissLabel,
      barrierColor: Colors.white.withOpacity(0),
      transitionDuration: const Duration(milliseconds: 150),
    );
  }

// process circilar
  static Future<Dialog?> showProgressCicular({String? message}) {
    return Get.generalDialog(
      pageBuilder: (BuildContext buildContext, Animation<double> animation,
          Animation<double> secondaryAnimation) {
        return SafeArea(
          child: Builder(
            builder: (context) {
              return Material(
                  color: AppTheme.backgroundColor.withOpacity(0.1),
                  child: Center(
                    child:
                        CircularProgressIndicator(color: AppTheme.primaryColor),
                  ));
            },
          ),
        );
      },
      barrierDismissible: false,
      barrierLabel: MaterialLocalizations.of(Get.context as BuildContext)
          .modalBarrierDismissLabel,
      barrierColor: Colors.white.withOpacity(0),
      transitionDuration: const Duration(milliseconds: 150),
    );
  }

  static Future<String> showChoices({
    String title = "",
    required String message,
    required Color color,
    required Widget icon,
    required List<DialogChoiceItem> buttons,
  }) async {
    var result = await showDialog(
      context: Get.context!,
      barrierDismissible: true,
      builder: (context) {
        return AlertDialog(
          title: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                  border: Border(bottom: BorderSide(color: color))),
              child: Center(
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      // Container(
                      //   margin: EdgeInsets.all(5),
                      //   child: SizedBox(
                      //     child: icon,
                      //     width: 30,
                      //     height: 30,
                      //   ),
                      // ),
                      Expanded(
                        child: Container(
                          child: Center(
                            child: Text(
                              StringUtils.isNullOrEmpty(title)
                                  ? "Confirm"
                                  : title,
                              style: TextStyle(
                                  fontFamily: 'Roboto-Condensed',
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: color),
                            ),
                          ),
                        ),
                      )
                    ]),
              )),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(message,
                    style: TextStyle(
                      fontFamily: 'Roboto-Condensed',
                      fontSize: 15,
                      color: AppTheme.textColor,
                    ))
              ],
            ),
          ),
          actions: <Widget>[
            Container(
              width: MediaQuery.of(context).size.width * 0.7,
              padding: EdgeInsets.only(right: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: buttons
                    .map(
                      (item) => InkWell(
                        onTap: () {
                          Navigator.of(context).pop(item.value);
                        },
                        child: Container(
                          padding:
                              EdgeInsets.symmetric(horizontal: 8, vertical: 5),
                          margin: EdgeInsets.only(left: 3),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              color: item.color),
                          alignment: Alignment.center,
                          child: Column(
                            children: <Widget>[
                              // Padding(
                              //   child: item.icon,
                              //   padding: EdgeInsets.all(1),
                              // ),
                              Text(
                                item.text,
                                style: TextStyle(
                                  color: AppTheme.backgroundColorLight,
                                  fontSize: 13,
                                  fontFamily: 'Roboto-Condensed',
                                  fontWeight: FontWeight.bold,
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    )
                    .toList(),
              ),
            )
          ],
        );
      },
    );
    return result;
  }

  static Future<double> showAppRating() async {
    var ok = await Get.dialog<double>(
      SafeArea(
        child: Builder(builder: (context) {
          var score = 0.0;
          bool visible = false;
          return StatefulBuilder(builder: (context, setState) {
            return Material(
              color: Colors.black.withOpacity(0.1),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      width: MediaQuery.of(context).size.width * .9,
                      decoration: BoxDecoration(
                          color: AppTheme.backgroundColorLight,
                          borderRadius: BorderRadius.circular(24),
                          gradient: LinearGradient(
                            colors: [AppTheme.primaryColor, AppTheme.greyColor],
                            begin: Alignment.topRight,
                            end: Alignment.bottomLeft,
                          )),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Row(
                            children: [
                              Spacer(),
                              InkWell(
                                  onTap: () {
                                    Navigator.of(context).pop(0.0);
                                  },
                                  child: Icon(
                                    Icons.close,
                                    color: Colors.white.withAlpha(150),
                                  ))
                            ],
                          ),
                          // SizedBox(
                          //   height: MediaQuery.of(context).size.height * .2,
                          // ),
                          Text(
                            "Enjoying the app?",
                            style: TextStyle(
                                height: 2, color: Colors.white, fontSize: 28.h),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: RatingBar.builder(
                              initialRating: score,
                              minRating: 1,
                              maxRating: 5,
                              direction: Axis.horizontal,
                              allowHalfRating: false,
                              itemCount: 5,
                              itemSize: 36.h,
                              itemBuilder: (context, _) {
                                return Icon(
                                  Icons.star,
                                  color: Colors.amber,
                                );
                              },
                              onRatingUpdate: (rating) {
                                setState(() {
                                  score = rating;
                                  if (score <= 4)
                                    visible = true;
                                  else {
                                    visible = false;
                                    Navigator.of(context).pop(score);
                                  }
                                });
                              },
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Visibility(
                                visible: visible,
                                child: Expanded(
                                  child: TextField(
                                    style: TextStyle(color: Colors.white),
                                    decoration: InputDecoration(
                                      labelText: 'Enter your review',
                                      border: OutlineInputBorder(),
                                    ),
                                  ),
                                ),
                              ),
                              Visibility(
                                visible: visible,
                                child: SizedBox(width: 16.0),
                              ), // Add some spacing between the text field and the button
                              Visibility(
                                visible: visible,
                                child: ElevatedButton(
                                  onPressed: () {
                                    // Handle submit button press
                                    if (score > 0) {
                                      Navigator.of(context).pop(score);
                                    }
                                  },
                                  child: Text('Submit'),
                                ),
                              ),
                            ],
                          ),
                          InkWell(
                            onTap: () {
                              Navigator.of(context).pop(0.0);
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: DisabledText(
                                "Remind Me Later",
                                color: Colors.white.withAlpha(150),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          });
        }),
      ),
      barrierDismissible: false,
    );
    return ok ?? 0;
  }

  static Future<double> showRemoveAds() async {
    var ok = await Get.dialog<double>(
        Center(
          child: Material(
            color: Colors.black.withOpacity(0.1),
            child: Container(
              height: 350,
              width: MediaQuery.of(Get.context!).size.width * .9,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(32),
                border: Border.all(color: Colors.white, width: 2),
              ),
              child: Column(
                children: <Widget>[
                  Container(
                    height: 56,
                    decoration: BoxDecoration(
                      color: AppTheme.greyColor,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(32),
                          topRight: Radius.circular(32)),
                      border: Border.all(color: Colors.white, width: 2),
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: Text(
                            "     Tired of ads",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 28),
                          ),
                        ),
                        InkWell(
                            onTap: () {
                              Navigator.of(Get.context!).pop(0.0);
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Icon(
                                Icons.close,
                                color: Colors.white.withAlpha(150),
                                size: 36,
                              ),
                            ))
                      ],
                    ),
                  ),
                  Container(
                    height: 200,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image:
                                AssetImage("assets/images/themes/options.jpg"),
                            fit: BoxFit.contain)),
                  ),
                  InkWell(
                    onTap: () async {
                      await AppController.toNamed(RemoveAdsPage.route);
                      Navigator.of(Get.context!).pop(0.0);
                    },
                    child: Container(
                      height: 60,
                      width: MediaQuery.of(Get.context!).size.width * .5,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              image:
                                  AssetImage("assets/images/themes/button.jpg"),
                              fit: BoxFit.contain)),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(4.0),
                              child: Icon(
                                Icons.shopping_cart,
                                size: 30,
                                color: Colors.white,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(4.0),
                              child: Text(
                                "BUY NOW",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20),
                              ),
                            )
                          ]),
                    ),
                  ),
                  SizedBox(
                    height: 12,
                  )
                ],
              ),
            ),
          ),
        ),
        barrierDismissible: true,
        useSafeArea: false);
    return ok ?? 0;
  }

  static Future<double> showRewardOrVideo() async {
    var ok = await Get.dialog<double>(
        Center(
          child: Material(
            color: Colors.black.withOpacity(0.1),
            child: Container(
              height: 200,
              width: MediaQuery.of(Get.context!).size.width * .9,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(32),
                border: Border.all(color: Colors.white, width: 2),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                    height: 56,
                    decoration: BoxDecoration(
                      color: AppTheme.greyColor,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(32),
                          topRight: Radius.circular(32)),
                      border: Border.all(color: Colors.white, width: 2),
                    ),
                    child: Row(
                      children: [
                        Spacer(),
                        InkWell(
                            onTap: () {
                              Navigator.of(Get.context!).pop(0.0);
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Icon(
                                Icons.close,
                                color: Colors.white.withAlpha(150),
                                size: 36,
                              ),
                            ))
                      ],
                    ),
                  ),
                  Container(
                    height: 60,
                    child: Text(
                      "Watch a short video Ad to get 1 more times to download. Or upgrade to VIP to get unlimited downloads.",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 18,
                          color: Colors.black,
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                  Container(
                    height: 60,
                    width: MediaQuery.of(Get.context!).size.width * .5,
                    decoration: BoxDecoration(),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        InkWell(
                          onTap: () async {
                            Dialogs.showProgress();
                            await AdsController.showRewardedVideo();
                            Dialogs.hideProgress();
                            Navigator.of(Get.context!).pop(1.0);
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.black,
                              borderRadius: BorderRadius.all(
                                Radius.circular(6),
                              ),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                "Watch Ad",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 18,
                                    fontWeight: FontWeight.w600),
                              ),
                            ),
                          ),
                        ),
                        InkWell(
                          onTap: () async {
                            await AppController.toNamed(RemoveAdsPage.route);
                            Navigator.of(Get.context!).pop(0.0);
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.yellow[400],
                              borderRadius: BorderRadius.all(
                                Radius.circular(6),
                              ),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                "Upgrade",
                                style: TextStyle(
                                    fontSize: 18,
                                    color: Colors.black,
                                    fontWeight: FontWeight.w600),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 12,
                  )
                ],
              ),
            ),
          ),
        ),
        barrierDismissible: true,
        useSafeArea: false);
    return ok ?? 0;
  }

  static successSnack({required String message, Icon? icon}) {
    Get.showSnackbar(GetSnackBar(
      backgroundColor: Color(0xFFcfffc6),
      overlayColor: Colors.black,
      borderColor: Colors.blue.withOpacity(0.1),
      margin: EdgeInsets.symmetric(horizontal: 40, vertical: 8),
      borderRadius: 24,
      messageText: Text(
        message,
        style: TextStyle(color: AppTheme.successColor),
      ),
      duration: Duration(seconds: 3),
      isDismissible: true,
      shouldIconPulse: true,
      icon: icon,
    ));
  }

  static errorSnack({required String message, Icon? icon}) {
    Get.showSnackbar(GetSnackBar(
      backgroundColor: Color(0xFFFFC6C6),
      overlayColor: Colors.black,
      borderColor: Colors.blue.withOpacity(0.1),
      margin: EdgeInsets.symmetric(horizontal: 40, vertical: 8),
      borderRadius: 24,
      messageText: Text(
        message,
        style: TextStyle(color: AppTheme.errorColor),
      ),
      duration: Duration(seconds: 3),
      isDismissible: true,
      shouldIconPulse: true,
      icon: icon,
    ));
  }
}

class DialogChoiceItem {
  final String value;
  final String text;
  final Color color;
  final Widget icon;
  DialogChoiceItem(
      {required this.text,
      required this.value,
      required this.color,
      required this.icon});
}
