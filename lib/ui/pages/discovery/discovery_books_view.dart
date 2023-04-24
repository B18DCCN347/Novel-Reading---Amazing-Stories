import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:love_novel/ui/components/app_menu_bar.dart';
import 'package:love_novel/ui/components/app_scaffold.dart';
import 'package:love_novel/ui/components/book_list_widget.dart';
import 'package:love_novel/ui/pages/discovery/discovery_sub.dart';

class DiscoveryBooksView extends StatelessWidget {
  final DiscoveryBooksController controller;
  const DiscoveryBooksView({Key? key, required this.controller})
      : super(key: key);
  static const route = '/discoveryBooks';

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          AppMenuBar(
            title: controller.title,
            showBackButton: true,
          ),
          Expanded(
            child: Obx(() {
              if (controller.books.value.length > 0) {
                return BookListWidget(
                  controller.books.value,
                  controller: controller.scrollController,
                  loading: controller.loadingMore.value,
                );
              } else
                return const SizedBox();
            }),
          ),
        ],
      ),
    );
  }
}
