import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:love_novel/app/global/controller.dart';
import 'package:love_novel/app/global/hivebox_controller.dart';
import 'package:love_novel/ui/components/book_list_widget.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:love_novel/data/models/public/book.dart';

class DownloadedTabViewController extends GetxController {
  static DownloadedTabViewController get instance =>
      Get.isRegistered<DownloadedTabViewController>()
          ? Get.find()
          : Get.put(DownloadedTabViewController());
  final appController = AppController.instance;
  final hiveBoxController = HiveBoxController.instance;
  CarouselController carouselController = CarouselController();
  int offset = 0;
  int count = 12;
  int pageLength = 12;
  var loadingMore = false.obs;
  var editing = false.obs;
  var hasNext = true;
  var books = Rxn<List<Book>>();

  ScrollController? scrollController;
  ScrollController? horizontalScrollController;
  @override
  void onInit() {
    super.onInit();
    scrollController = ScrollController()..addListener(_scrollListener);
    horizontalScrollController = ScrollController()
      ..addListener(_horizontalScrollListener);
  }

  init() async {
    offset = 0;
    count = 12;
    pageLength = 12;
    loadingMore.value = false;
    editing.value = false;
    hasNext = true;
    books.value = null;
    await loadBooks();
  }

  Future<void> _scrollListener() async {
    if ((scrollController?.position.extentAfter ?? 0) < 900) {
      if (!loadingMore.value && hasNext) {
        loadingMore.value = true;
        await loadBooks();
        loadingMore.value = false;
      }
    }
  }

  Future<void> _horizontalScrollListener() async {
    if ((horizontalScrollController?.position.extentAfter ?? 0) < 200) {
        await loadBooks();
    }
  }

  loadBooks() async {
    if (!loadingMore.value && hasNext) {
      loadingMore.value = true;
      books.value = (await hiveBoxController.bookBoxRepository.safeGetAll())
          .where((element) => element.downloaded ?? false)
          .toList();
      books.value?.sort((a, b) => (b.order ?? 0).compareTo(a.order ?? 0));
      books.refresh();
      hasNext = false;
      loadingMore.value = false;
    }
  }
}

class DownloadedTabView extends StatelessWidget {
  DownloadedTabView({Key? key}) : super(key: key);

  var _controller = DownloadedTabViewController.instance;
  final hiveBoxController = HiveBoxController.instance;
  final appController = AppController.instance;

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    if (_controller.books.value == null) _controller.loadBooks();
    return Obx(() {
      if (_controller.books.value == null)
        return Center(
            child: CircularProgressIndicator(
          strokeWidth: 8,
        ));
      else {
        if (_controller.books.value!.length > 0) {
          return Column(
            children: [
              Row(
                children: [
                  Spacer(),
                  InkWell(
                    onTap: () {
                      _controller.editing.value = !_controller.editing.value;
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        _controller.editing.value ? "Done" : "Edit",
                        style: TextStyle(fontSize: 18),
                      ),
                    ),
                  )
                ],
              ),
              Expanded(
                child: BookListWidget(
                  _controller.books.value!,
                  controller: _controller.scrollController,
                  loading: _controller.loadingMore.value,
                  onDeleted: _controller.editing.value
                      ? (book) async {
                          var existItem =
                              await hiveBoxController.getBook(book.uuid ?? "");
                          if (existItem != null) {
                            hiveBoxController.saveOrUpdateBook(existItem,
                                downloaded: false);
                          }
                          var existDownloads = await hiveBoxController
                              .downloadPackageBoxRepository
                              .safeGetAll();
                          existDownloads = existDownloads
                              .where((element) =>
                                  element.bookId == (book.uuid ?? ""))
                              .toList();
                          if (existDownloads.isNotEmpty) {
                            for (var existDownload in existDownloads) {
                              await hiveBoxController
                                  .downloadPackageBoxRepository
                                  .deleteKey(existDownload.key);
                            }
                          }
                          _controller.books.value?.remove(book);
                          _controller.books.refresh();
                        }
                      : null,
                ),
              ),
            ],
          );
        } else
          return const SizedBox();
      }
    });
  }
}
