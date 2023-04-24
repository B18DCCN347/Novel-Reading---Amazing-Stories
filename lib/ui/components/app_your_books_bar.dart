import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:love_novel/ui/components/app_theme.dart';

class AppYourBooksBar extends StatelessWidget {
  final String title;
  final ValueChanged<String?>? onSubmited;
  const AppYourBooksBar({
    Key? key,
    required this.title,
    this.onSubmited
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
      child: Container(
        height: 56,
        decoration: BoxDecoration(
            color: AppTheme.backgroundColorLight,
            boxShadow: AppTheme.boxShadows),
        child: Row(children: [
          Padding(
            padding: const EdgeInsets.only(right: 8.0, left: 32),
            child: InkWell(
              onTap: () {
                Get.back();
              },
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Icon(
                  Icons.search,
                  size: 28,
                  color: AppTheme.greyColor,
                ),
              ),
            ),
          ),
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                style: TextStyle(),
                decoration: InputDecoration(
                    hintText: "Type your search here",
                    border: InputBorder.none,
                    hintStyle: TextStyle(
                      fontStyle: FontStyle.italic,
                      color: AppTheme.greyColor,
                    )),
                onSubmitted: (value){

                },
              ),
            ),
          ),
        ]),
      ),
    );
  }
}
