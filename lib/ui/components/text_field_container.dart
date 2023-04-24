import 'package:flutter/material.dart';
import 'package:love_novel/ui/components/app_theme.dart';

class TextFieldContainer extends StatelessWidget {
  final Widget child;
  const TextFieldContainer({
    Key? key,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      margin: EdgeInsets.symmetric(vertical: 8),
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      width: size.width * 0.8,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(32),
        color: AppTheme.brightColor,
        boxShadow: [
          BoxShadow(offset: Offset(2,2), color: AppTheme.primaryColor.withOpacity(0.3),blurRadius: 6,)
        ]
      ),
      child: child,
    );
  }
}
