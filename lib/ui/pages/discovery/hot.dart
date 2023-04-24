import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:love_novel/app/global/controller.dart';
import 'package:love_novel/app/global/hivebox_controller.dart';
import 'package:love_novel/ui/components/book_list_widget.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:love_novel/data/models/public/book.dart';
import 'package:love_novel/data/repositories/book.dart';
import 'package:love_novel/ui/pages/genres/controller.dart';

class HotController extends GetxController {
  static HotController get instance =>
      Get.isRegistered<HotController>() ? Get.find() : Get.put(HotController());
  final appController = AppController.instance;
  final hiveBoxController = HiveBoxController.instance;
  CarouselController carouselController = CarouselController();
  int offset = 0;
  int count = 12;
  int pageLength = 12;
  var loadingMore = false.obs;
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
      try {
        if (!AppController.hasConnection) {
          books.value = (await hiveBoxController.bookBoxRepository.safeGetAll())
              .where((element) => element.completed ?? false)
              .toList();
          books.refresh();
          hasNext = false;
        } else {
          var rp = await BookRepository().hotBooks(offset, count);
          var bItems = (rp?.data ?? [])
            ..forEach((element) {
              element.bindCategory(GenresController.genres.value ?? []);
            });
          books.value = (books.value ?? [])..addAll(bItems);
          books.refresh();
          if (rp != null) {
            offset += pageLength;
            //count += pageLength;
            hasNext = rp.hasNext ?? false;
          }
          await hiveBoxController.updateHotBooks(books.value!);
        }
      } catch (e) {}
      loadingMore.value = false;
    }
  }
}

class HotView extends StatelessWidget {
  HotView({Key? key}) : super(key: key);

  var _controller = HotController.instance;

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
          return BookListWidget(
            _controller.books.value!,
            controller: _controller.scrollController,
            loading: _controller.loadingMore.value,
          );
        } else
          return const SizedBox();
      }
    });
  }
}
