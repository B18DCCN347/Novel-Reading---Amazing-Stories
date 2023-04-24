import 'package:flutter/material.dart';

import 'package:love_novel/ui/components/app_theme.dart';

class StockLabel extends StatelessWidget {
  final String title;
  final Color? color;
  final bool hasReputation;
  final bool robotControl;
  final bool fixed;
  const StockLabel({
    Key? key,
    required this.title,
    this.color,
    this.hasReputation = false,
    this.robotControl = false,
    this.fixed = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
          alignment: Alignment.center,
          width: fixed ? 42 : null,
          padding: EdgeInsets.symmetric(horizontal: 6),
          height: 22,
          decoration: BoxDecoration(
              color: color == null ? AppTheme.primaryColorDark : color,
              borderRadius: BorderRadius.all(Radius.circular(4))),
          child: Text(
            title,
            style: TextStyle(fontSize: 12, color: Colors.white),
          ),
        ),
        if (hasReputation)
          Positioned(
              top: -8,
              right: -8,
              child: Icon(
                Icons.star,
                size: 16,
              )),
        if (robotControl)
          Positioned(
              bottom: -8,
              right: -8,
              child: Icon(
                Icons.android,
                size: 16,
              ))
      ],
    );
  }
}
