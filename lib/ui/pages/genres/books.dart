import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:love_novel/ui/components/app_menu_bar.dart';
import 'package:love_novel/ui/components/app_scaffold.dart';
import 'package:love_novel/ui/pages/discovery/stories.dart';
import 'package:love_novel/ui/pages/genres/controller.dart';

class GenresBooksView extends StatelessWidget {
  GenresBooksView({Key? key}) : super(key: key);
  static const route = '/bookOfGenre';
  var controller = GenresController.instance;
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return AppScaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          AppMenuBar(
            title: controller.genre.value?.name ?? "",
            showBackButton: true,
          ),
          Expanded(
            child: Obx(() {
              if (controller.genre.value == null) {
                return const Expanded(
                  child: Center(
                      child: CircularProgressIndicator(
                    strokeWidth: 8,
                  )),
                );
              } else {
                return StoriesView(genre: controller.genre.value!);
              }
            }),
          ),
        ],
      ),
    );
  }
}
