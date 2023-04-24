import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:love_novel/ui/components/app_menu_bar.dart';
import 'package:love_novel/ui/components/app_scaffold.dart';
import 'package:love_novel/ui/pages/search/controller.dart';
import 'package:love_novel/ui/pages/search/seach_result.dart';

class SearchBooksPage extends StatelessWidget {
  SearchBooksPage({Key? key}) : super(key: key);
  static const route = '/searchBooks';
  var controller = SearchController.instance;
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return AppScaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          AppMenuBar(
            title: controller.keyword.value?? "",
            showBackButton: true,
          ),
          Expanded(
            child: Obx(() {
              if (controller.keyword.value == null) {
                return const Expanded(
                  child: Center(
                      child: CircularProgressIndicator(
                    strokeWidth: 8,
                  )),
                );
              } else {
                return SearchResultView(keyword: controller.keyword.value!);
              }
            }),
          ),
        ],
      ),
    );
  }
}
