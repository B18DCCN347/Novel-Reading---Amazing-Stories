import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:love_novel/app/global/controller.dart';
import 'package:love_novel/data/models/category/category.dart';
import 'package:love_novel/ui/components/app_theme.dart';
import 'package:love_novel/ui/pages/genres/books.dart';
import 'package:love_novel/ui/pages/genres/controller.dart';

class GenreBox extends StatelessWidget {
  final Category data;
  const GenreBox(
    this.data, {
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        GenresController.instance.genre.value = data;
        AppController.toNamed(GenresBooksView.route);
      },
      child: Container(
        alignment: Alignment.center,
        margin: EdgeInsets.all(8),
        decoration: BoxDecoration(
            color: AppTheme.greyColorDark,
            borderRadius: BorderRadius.all(Radius.circular(12)),
            boxShadow: AppTheme.boxShadows),
        child: Text(
          data.name ?? "",
          style: TextStyle(
              color: AppTheme.brightColor, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
