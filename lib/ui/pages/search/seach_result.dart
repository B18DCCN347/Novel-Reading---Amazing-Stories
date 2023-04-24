import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:love_novel/ui/components/book_list_widget.dart';
import 'package:love_novel/ui/components/texts.dart';
import 'package:love_novel/ui/pages/search/controller.dart';


class SearchResultView extends StatefulWidget {
  final String keyword;
  const SearchResultView({Key? key, required this.keyword}) : super(key: key);

  @override
  State<SearchResultView> createState() => _SearchResultViewState();
}

class _SearchResultViewState extends State<SearchResultView> {
  late SearchController _controller;
  @override
  void initState() {
    super.initState();
    _controller = SearchController();
    _controller.keyword.value = widget.keyword;
    Get.put(_controller, tag: widget.keyword);
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
          );
        } else
          return Center(
            child: DisabledText("Result not found"),
          );
      }
    });
  }
}
