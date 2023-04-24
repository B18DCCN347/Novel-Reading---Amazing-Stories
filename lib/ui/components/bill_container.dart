import 'package:flutter/material.dart';
import 'package:love_novel/ui/components/app_theme.dart';

class BillContainer extends StatelessWidget {
  final List<Widget> children;
  const BillContainer({Key? key, this.children = const []}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 12.0, right: 12, bottom: 12),
      child: Container(
        padding: const EdgeInsets.all(12.0),
        decoration: BoxDecoration(
            color: AppTheme.disabledColor,
            borderRadius: BorderRadius.all(Radius.circular(8))),
        child: Column(
          children: children,
        ),
      ),
    );
  }
}
