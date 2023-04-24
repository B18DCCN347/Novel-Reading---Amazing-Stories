import 'package:flutter/material.dart';
import 'package:love_novel/data/models/public/book.dart';
import 'package:love_novel/ui/components/book_card.dart';

class BookListWidget extends StatelessWidget {
  final ScrollController? controller;
  const BookListWidget(
    this.data, {
    Key? key,
    this.controller,
    this.onDeleted,
    this.loading = false,
  }) : super(key: key);

  final List<Book> data;
  final bool loading;
  final ValueChanged<Book>? onDeleted;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      controller: controller,
      child: Padding(
        padding: EdgeInsets.only(bottom: MediaQuery.of(context).padding.bottom),
        child: Column(
          children: []
            ..addAll(data
                .map((item) => BookCard(book: item, onDeleted: onDeleted))
                .toList())
            ..add(Visibility(
              visible: loading,
              child: Container(
                height: 36,
                width: 36,
                padding: EdgeInsets.all(4),
                child: CircularProgressIndicator(),
              ),
            )),
        ),
      ),
    );
  }
}
