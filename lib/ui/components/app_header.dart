import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:love_novel/data/models/category/category.dart';
import 'package:love_novel/ui/components/app_theme.dart';
import 'package:love_novel/ui/pages/discovery/controller.dart';

class AppHeader extends StatelessWidget {
  final Color? selectedItemColor;
  final ValueChanged<int>? onTap;
  final List<Category> items;
  AppHeader({
    Key? key,
    this.selectedItemColor,
    this.onTap,
    required this.items,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var index = 0;
    return Row(
      children: [
        Expanded(
          child: Container(
            decoration: BoxDecoration(color: Colors.white, boxShadow: [
              BoxShadow(
                  offset: Offset(0, 3),
                  color: AppTheme.greyColorLight.withOpacity(0.3),
                  blurRadius: 1)
            ]),
            child: Container(
              padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: items.map((e) {
                    var i = index + 0;
                    index++;
                    return Obx(() => _AppHeaderItem(
                          index: i,
                          title: e.name ?? "",
                          activated:
                              DiscoveryController.currentIndex.value == i,
                          onTap: () {
                            if (onTap != null) onTap!(i);
                          },
                        ));
                  }).toList(),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _AppHeaderItem extends StatelessWidget {
  final int index;
  final String title;
  final bool activated;
  final VoidCallback? onTap;
  const _AppHeaderItem({
    Key? key,
    required this.index,
    required this.title,
    this.activated = false,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var tcolor = activated ? AppTheme.primaryColor : AppTheme.greyColor;
    var color = activated ? AppTheme.primaryColor : Colors.white;
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(4.0),
        decoration: BoxDecoration(
            border: Border(bottom: BorderSide(color: color, width: 3))),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            title,
            style: TextStyle(
                color: tcolor, fontWeight: FontWeight.bold, height: 2),
          ),
        ),
      ),
    );
  }
}
