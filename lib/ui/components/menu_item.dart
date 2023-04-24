import 'package:flutter/material.dart';

import 'package:love_novel/ui/components/app_theme.dart';

class MenuItem extends StatelessWidget {
  final String title;
  final VoidCallback? onTap;
  final IconData iconData;
  final bool activated;
  final Color? color;
  final Widget? suffix;
  const MenuItem(
      {Key? key,
      required this.title,
      required this.iconData,
      this.onTap,
      this.color,
      this.suffix,
      this.activated = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var _color = color == null ? AppTheme.primaryColorDark : color;
    return Stack(
      alignment: Alignment.center,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
        ),
        Container(
          width: MediaQuery.of(context).size.width * .7,
          height: 58,
          margin: EdgeInsets.all(8),
          decoration: BoxDecoration(
              gradient: LinearGradient(colors: [
                _color!.withOpacity(activated ? 0.4 : 0),
                _color.withBlue(400).withOpacity(activated ? 0.2 : 0),
              ]),
              borderRadius: BorderRadius.all(Radius.circular(32))),
          child: ListTile(
            leading:Icon(
              iconData,
              size: 32,
            ),
            title: Row(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Text(
                      title,
                      style: TextStyle(
                          color: _color, fontSize: 15, fontWeight: FontWeight.bold,
                          ),
                    ),
                  ),
                ),
                suffix ?? SizedBox()
              ],
            ),
            onTap: () {
              if (onTap != null) onTap!();
            },
          ),
        )
      ],
    );
  }
}
