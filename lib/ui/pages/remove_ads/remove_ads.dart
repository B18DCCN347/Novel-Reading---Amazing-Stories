import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:love_novel/ui/components/app_menu_bar.dart';
import 'package:love_novel/ui/components/app_scaffold.dart';
import 'package:love_novel/ui/pages/remove_ads/controller.dart';

class RemoveAdsPage extends StatelessWidget {
  RemoveAdsPage({Key? key}) : super(key: key);
  static const route = '/removeAds';
  var controller = RemoveAdsController.instance;
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return AppScaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          AppMenuBar(
            title: "Vip Member",
            showBackButton: true,
          ),
          Obx(() {
            return Expanded(
              child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  child: SingleChildScrollView(
                      child: controller.buildProductList())),
            );
          }),
        ],
      ),
    );
  }
}
