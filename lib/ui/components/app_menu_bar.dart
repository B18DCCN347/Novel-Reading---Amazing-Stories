import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:love_novel/ui/components/app_theme.dart';

class AppMenuBar extends StatelessWidget {
  final bool showBackButton;
  final String title;
  final List<Widget>? actions;
  const AppMenuBar({
    Key? key,
    this.showBackButton = false,
    required this.title,
    this.actions,
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
          if (showBackButton)
            InkWell(
              onTap: () {
                Get.back();
              },
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Icon(Icons.arrow_back),
              ),
            ),
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                title,
                textAlign: showBackButton ? TextAlign.left : TextAlign.center,
                style: TextStyle(
                    color: AppTheme.greyColorDark,
                    fontWeight: FontWeight.w600,
                    overflow: TextOverflow.clip,
                    fontSize: 19),
              ),
            ),
          ),
          ...(actions ?? []),
        ]),
      ),
    );
  }
}
