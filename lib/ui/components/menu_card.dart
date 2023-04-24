import 'package:flutter/material.dart';

import 'package:love_novel/ui/components/app_theme.dart';

class MenuCard extends StatelessWidget {
  final Color? color;
  final IconData iconData;
  final String title;
  final String? description;
  final Widget? child;
  final VoidCallback onTap;
  final bool showArrow;
  const MenuCard({
    Key? key,
    this.color,
    required this.iconData,
    required this.title,
    this.description,
    this.showArrow = true,
    required this.onTap,
    this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap:onTap,
      child: Container(
          margin: EdgeInsets.only(bottom: 8),
          padding: EdgeInsets.all(8),
          decoration: BoxDecoration(
            color:color?.withOpacity(0.6)?? AppTheme.backgroundColorLight,
            borderRadius: BorderRadius.all(
              Radius.circular(4),
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Icon(
                  iconData,
                  size: 32,
                ),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 12.0, horizontal: 8),
                            child: Text(
                              title,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 16),
                            ),
                          ),
                        ),
                      ],
                    ),
                    if (description != null)
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Text(
                          description!,
                          style: TextStyle(
                            color: AppTheme.disabledColorDark,
                          ),
                        ),
                      ),
                  ],
                ),
              ),
              if (showArrow)
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Icon(
                    Icons.chevron_right,
                    size: 32,
                    color: color == null ? AppTheme.primaryColorDark : color,
                  ),
                ),
            ],
          )),
    );
  }
}
