import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:webview_flutter/webview_flutter.dart';

class AppWebViewController extends GetxController {
  static AppWebViewController get instance =>
      Get.isRegistered<AppWebViewController>()
          ? Get.find()
          : Get.put(AppWebViewController());

  final Completer<WebViewController> webviewController =
      Completer<WebViewController>();

  @override
  void onInit() {
    super.onInit();
    WidgetsBinding.instance.addPostFrameCallback((timer) async {});
  }
}
