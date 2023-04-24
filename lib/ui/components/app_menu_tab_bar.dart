import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:love_novel/data/models/category/category.dart';
import 'package:love_novel/ui/components/app_theme.dart';

class AppMenuTabBar extends StatelessWidget {
  final Color? selectedItemColor;
  final ValueChanged<int>? onTap;
  final List<Category> items;
  final int currentIndex;

  const AppMenuTabBar(
      {Key? key,
      this.selectedItemColor,
      this.onTap,
      required this.items,
      required this.currentIndex})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var index = 0;
    return Container(
      decoration: BoxDecoration(color: Colors.white, boxShadow: [
        BoxShadow(
            offset: Offset(0, 3),
            color: AppTheme.greyColorLight.withOpacity(0.3),
            blurRadius: 1)
      ]),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: items.map((e) {
            var i = index + 0;
            index++;
            return _AppMenuTabBarItem(
              index: i,
              title: e.name ?? "",
              activated: currentIndex == i,
              onTap: () {
                if (onTap != null) onTap!(i);
              },
            );
          }).toList(),
        ),
      ),
    );
  }
}

class _AppMenuTabBarItem extends StatelessWidget {
  final int index;
  final String title;
  final bool activated;
  final VoidCallback? onTap;
  const _AppMenuTabBarItem({
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
        padding:  EdgeInsets.all(12.h),
        decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(color: color, width: 3))),
        child: Text(
          title,
          textAlign: TextAlign.center,
          style: TextStyle(
              color: tcolor, fontWeight: FontWeight.bold, fontSize: 14.h),
        ),
      ),
    );
  }
}
