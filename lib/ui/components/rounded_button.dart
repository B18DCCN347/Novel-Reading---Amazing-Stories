import 'package:flutter/material.dart';

import 'package:love_novel/ui/components/app_theme.dart';

class RoundedButton extends StatelessWidget {
  final String? text;
  final Function? onPressed;
  Color? color, textColor;
  IconData? iconData;
  RoundedButton(
      {Key? key,
      this.text,
      this.onPressed,
      this.color,
      this.textColor = Colors.white,
      this.iconData})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (color == null) color = AppTheme.primaryColor;
    return InkWell(
      onTap: () {
        if (onPressed != null) onPressed!();
      },
      child: Container(
        width: MediaQuery.of(context).size.width*.6,
        alignment: Alignment.center,
        margin: EdgeInsets.symmetric(vertical: 8),
        padding: EdgeInsets.symmetric(horizontal: 28, vertical: 16),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(28),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (iconData != null)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Icon(iconData!),
              ),
            Text(
              text ?? "",
              style: TextStyle(color: textColor, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
