import 'package:flutter/material.dart';
import 'package:love_novel/ui/components/app_theme.dart';

class AppMenu extends StatelessWidget {
  final int currentIndex;
  final Color? selectedItemColor;
  final ValueChanged<int>? onTap;
  final List<AppMenuItem> items;
  const AppMenu({
    Key? key,
    this.currentIndex = 0,
    this.selectedItemColor,
    this.onTap,
    required this.items,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var index = 0;
    return Container(
      decoration: BoxDecoration(color: AppTheme.brightColor, boxShadow: [
        BoxShadow(
            offset: Offset(0, -1),
            color: AppTheme.greyColorLight.withOpacity(0.2),
            blurRadius: 2)
      ]),
      padding: EdgeInsets.only(
        right: 16,
        left: 16,
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: items.map((e) {
              var i = index + 0;
              index++;
              return _AppMenuItem(
                index: i,
                title: e.title,
                iconData: e.iconData,
                activated: currentIndex == i,
                onTap: () {
                  if (onTap != null) onTap!(i);
                },
              );
            }).toList(),
          ),
          SizedBox(height: MediaQuery.of(context).padding.bottom)
        ],
      ),
    );
  }
}

class AppMenuItem {
  final String title;
  final IconData iconData;
  const AppMenuItem({
    required this.title,
    required this.iconData,
  });
}

class _AppMenuItem extends StatelessWidget {
  final int index;
  final String title;
  final IconData iconData;
  final bool activated;
  final VoidCallback? onTap;
  const _AppMenuItem({
    Key? key,
    required this.index,
    required this.title,
    required this.iconData,
    this.activated = false,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var color = activated ? AppTheme.primaryColor : AppTheme.greyColorDark;
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.all(4.0),
        child: Column(
          children: [
            Icon(
              iconData,
              color: color,
              size: 30,
            ),
            Text(
              title,
              style: TextStyle(color: color, fontSize: 10),
            )
          ],
        ),
      ),
    );
  }
}
