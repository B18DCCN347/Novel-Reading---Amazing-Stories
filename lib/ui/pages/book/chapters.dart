import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:love_novel/app/global/arguments.dart';
import 'package:love_novel/app/global/controller.dart';
import 'package:love_novel/app/global/hivebox_controller.dart';
import 'package:love_novel/app/utils/dialogs.dart';
import 'package:love_novel/data/models/public/episode.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:love_novel/data/repositories/book.dart';
import 'package:love_novel/ui/components/chapters_widget.dart';
import 'package:love_novel/ui/pages/ads/controller.dart';
import 'package:love_novel/ui/pages/book/controller.dart';
import 'package:love_novel/ui/pages/book/read.dart';
import 'package:love_novel/ui/pages/your_books/history.dart';

class ChaptersController extends GetxController {
  static ChaptersController get instance =>
      Get.isRegistered<ChaptersController>()
          ? Get.find()
          : Get.put(ChaptersController());

  var appController = AppController.instance;
  final hiveBoxController = HiveBoxController.instance;
  ScrollController? scrollController;
  CarouselController carouselController = CarouselController();
  static int offset = 0;
  static const maxSize = 100;
  int count = maxSize;
  int pageLength = maxSize;
  var loadingMore = false.obs;
  var hasNext = true;
  static var episodes = Rxn<List<Episode>>();

  @override
  void onInit() {
    super.onInit();
    scrollController = ScrollController()..addListener(_scrollListener);
  }

  init() async {
    offset = 0;
    count = maxSize;
    pageLength = maxSize;
    loadingMore.value = false;
    hasNext = true;
    episodes.value = null;
    await loadEpisodes();
  }

  Future<void> _scrollListener() async {
    if ((scrollController?.position.extentAfter ?? 0) < 900) {
      await loadEpisodes();
    }
  }

  loadToIndex(index) async {
    await loadEpisodes();
    var length = (episodes.value?.length ?? 0);
    if (length > 0 && index > length && hasNext) {
      await loadToIndex(index);
      offset = index;
    }
  }

  Future startRead(String route) async {
    Dialogs.showProgress();
    BookController.routeMarker = route;
    await init();
    var index = BookController.actionStatus.value?.episodeIndex ?? 1;
    if (index < 1) index = 1;
    await loadToIndex(index);
    Dialogs.hideProgress();
    if ((episodes.value?.length ?? 0) > 0) {
      var chapter =
          episodes.value!.firstWhereOrNull((element) => element.index == index);
      await AppController.toNamed(ReadPage.route,
          arguments: EpisodeArguments(episode: chapter ?? Episode()));
      await HistoryTabViewController.instance.init();
    }
  }

  loadEpisodes() async {
    if (!loadingMore.value && hasNext) {
      loadingMore.value = true;
      var bookId = BookController.currentBook.value?.uuid ?? "";
      if (AppController.hasConnection) {
        var rp = await BookRepository().episodes(bookId, offset, count);
        var newData = rp?.data ?? [];
        if (newData.isNotEmpty) {
          var oldData = (episodes.value ?? []);
          if (!oldData.any((element) => newData[0].uuid == element.uuid)) {
            episodes.value = oldData..addAll(newData);
            episodes.refresh();
            if (rp != null) {
              offset += pageLength;
              //count += pageLength;
              hasNext = rp.hasNext ?? false;
            }
            var newIds = episodes.value!.map((e) => e.uuid);
            var existKeys =
                (await hiveBoxController.chapterBoxRepository.safeGetAll())
                    .where((e) => newIds.contains(e.uuid))
                    .map((e) => e.key)
                    .toList();
            await hiveBoxController.chapterBoxRepository.deleteAll(existKeys);
            for (var element in episodes.value!) {
              element.bookId = bookId;
              await hiveBoxController.chapterBoxRepository.add(element);
            }
          }
        }
      } else {
        var items = (await hiveBoxController.chapterBoxRepository.safeGetAll())
            .where((element) => element.bookId == bookId)
            .toList();
        episodes.value = items;
        episodes.refresh();
        hasNext = false;
      }
      loadingMore.value = false;
    }
  }
}

class ChaptersView extends StatelessWidget {
  ChaptersView({Key? key}) : super(key: key);

  ChaptersController _controller = ChaptersController.instance;

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    if (ChaptersController.episodes.value == null) _controller.init();
    return Obx(() {
      if (ChaptersController.episodes.value == null)
        return Center(
            child: CircularProgressIndicator(
          strokeWidth: 8,
        ));
      else {
        if (ChaptersController.episodes.value!.length > 0) {
          return ChaptersWidget(
            ChaptersController.episodes.value!,
            controller: _controller.scrollController,
          );
        } else
          return const SizedBox();
      }
    });
  }
}
