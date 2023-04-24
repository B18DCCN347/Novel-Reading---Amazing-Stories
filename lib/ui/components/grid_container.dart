import 'package:flutter/material.dart';
import 'package:love_novel/ui/components/app_theme.dart';

class GridContainer extends StatelessWidget {
  final List<Widget> children;
  const GridContainer({Key? key, this.children = const []}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 12.0, right: 12, bottom: 12),
      child: Container(
        padding: const EdgeInsets.all(12.0),
        decoration: BoxDecoration(
            color: AppTheme.backgroundColorLight,
            borderRadius: BorderRadius.only(
                topRight: Radius.circular(12),
                topLeft: Radius.circular(12),
                bottomRight: Radius.circular(32),
                bottomLeft: Radius.circular(32))),
        child: Column(
          children: children,
        ),
      ),
    );
  }
}
