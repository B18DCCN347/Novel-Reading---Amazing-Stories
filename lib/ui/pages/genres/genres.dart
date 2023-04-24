import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:love_novel/ui/components/app_menu_bar.dart';
import 'package:love_novel/ui/components/genre_box.dart';
import 'package:love_novel/ui/pages/discovery/controller.dart';
import 'package:love_novel/ui/pages/genres/controller.dart';

class GenresView extends StatelessWidget {
  GenresView({Key? key}) : super(key: key);
  var controller = GenresController.instance;
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        AppMenuBar(title: "Category"),
        Obx(() {
          if (GenresController.genres.value == null)
            return Expanded(
              child: Center(
                  child: CircularProgressIndicator(
                strokeWidth: 8,
              )),
            );
          else {
            if (GenresController.genres.value!.length > 0)
              return Expanded(
                child: GridView.count(
                  padding: const EdgeInsets.all(8),
                  crossAxisCount: 2,
                  childAspectRatio: 2.4,
                  controller: new ScrollController(keepScrollOffset: false),
                  shrinkWrap: true,
                  scrollDirection: Axis.vertical,
                  children: GenresController.genres.value!.map((item) {
                    return GenreBox(item);
                  }).toList(),
                ),
              );
            else
              return Expanded(child: const SizedBox());
          }
        }),
      ],
    );
  }
}
