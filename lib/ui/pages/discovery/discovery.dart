import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:love_novel/app/global/home_category.dart';
import 'package:love_novel/ui/components/app_header.dart';
import 'package:love_novel/ui/pages/discovery/completed.dart';
import 'package:love_novel/ui/pages/discovery/controller.dart';
import 'package:love_novel/ui/pages/discovery/discovery_sub.dart';
import 'package:love_novel/ui/pages/discovery/hot.dart';
import 'package:love_novel/ui/pages/discovery/lastest_release.dart';
import 'package:love_novel/ui/pages/discovery/stories.dart';

class DiscoveryView extends StatefulWidget {
  static const route = '/discovery';

  @override
  State<DiscoveryView> createState() => _DiscoveryViewState();
}

class _DiscoveryViewState extends State<DiscoveryView> {
  var controller = DiscoveryController.instance;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      await controller.init();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Obx(() {
          if (DiscoveryController.discoveryGenres.value.length > 0)
            return AppHeader(
              items: DiscoveryController.discoveryGenres.value,
              onTap: controller.move,
            );
          else
            return const SizedBox();
        }),
        Obx(() {
          return Expanded(
            child: CarouselSlider(
              items: DiscoveryController.discoveryGenres.value.map((e) {
                switch (e.id) {
                  case HomeCategories.discovery:
                    return DiscoverySubView();
                  case HomeCategories.hot:
                    return HotView();
                  case HomeCategories.lastestRelease:
                    return LastestReleaseView();
                  case HomeCategories.completed:
                    return CompletedView();
                  default:
                    return StoriesView(genre: e);
                }
              }).toList(),
              options: CarouselOptions(
                  scrollPhysics: const NeverScrollableScrollPhysics(),
                  enlargeCenterPage: false,
                  height: MediaQuery.of(context).size.height,
                  viewportFraction: 1),
              carouselController: DiscoveryController.carouselController,
            ),
          );
        }),
      ],
    );
  }
}
