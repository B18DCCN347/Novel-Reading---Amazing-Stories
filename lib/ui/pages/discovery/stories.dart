import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:love_novel/app/global/controller.dart';
import 'package:love_novel/app/global/hivebox_controller.dart';
import 'package:love_novel/ui/components/book_list_widget.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:love_novel/data/models/category/category.dart';
import 'package:love_novel/data/models/public/book.dart';
import 'package:love_novel/data/repositories/book.dart';
import 'package:love_novel/ui/pages/genres/controller.dart';

class StoriesController extends GetxController {
  static StoriesController get instance => Get.isRegistered<StoriesController>()
      ? Get.find()
      : Get.put(StoriesController());
  final appController = AppController.instance;
  final hiveBoxController = HiveBoxController.instance;
  CarouselController carouselController = CarouselController();
  int offset = 0;
  int count = 12;
  int pageLength = 12;
  var loadingMore = false.obs;
  var hasNext = true;
  var books = Rxn<List<Book>>();
  var genre = Rxn<Category>();

  ScrollController? scrollController;
  @override
  void onInit() {
    super.onInit();
    scrollController = ScrollController()..addListener(_scrollListener);
  }

  Future<void> _scrollListener() async {
    if ((scrollController?.position.extentAfter ?? 0) < 900) {
      await loadBooks();
    }
  }

  loadBooks() async {
    if (!loadingMore.value && hasNext) {
      loadingMore.value = true;
      if (!AppController.hasConnection) {
        books.value = (await hiveBoxController.bookBoxRepository.safeGetAll())
            .where((element) =>
                (element.category ?? []).contains(genre.value?.id ?? 0))
            .toList();

        books.refresh();
        hasNext = false;
      } else {
        var rp = await BookRepository()
            .booksByCatId(genre.value?.id ?? 0, offset, count);
        var bItems = (rp?.data ?? [])
          ..forEach((element) {
            element.bindCategory(GenresController.genres.value ?? []);
          });
        var existItems = (books.value ?? []);
        bItems = bItems
            .where((element) =>
                !existItems.map((e) => e.uuid).contains(element.uuid))
            .toList();
        books.value = existItems..addAll(bItems);
        books.refresh();

        if (rp != null) {
          offset += pageLength;
          //count += pageLength;
          hasNext = rp.hasNext ?? false;
        }
        await hiveBoxController.updateBooks(books.value!);
      }
      loadingMore.value = false;
    }
  }
}

class StoriesView extends StatefulWidget {
  final Category genre;
  const StoriesView({Key? key, required this.genre}) : super(key: key);
  static const route = '/discovery';

  @override
  State<StoriesView> createState() => _StoriesViewState();
}

class _StoriesViewState extends State<StoriesView> {
  late StoriesController _controller;
  @override
  void initState() {
    super.initState();
    _controller = StoriesController();
    _controller.genre.value = widget.genre;
    Get.put(_controller, tag: widget.genre.id.toString());
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

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
