import 'package:flutter/material.dart';
import 'package:love_novel/ui/components/app_theme.dart';

class AppButton extends StatelessWidget {
  final Color? color;
  final Color? textColor;
  final String? text;
  final VoidCallback? onPressed;
  const AppButton(
      {Key? key, this.color, this.textColor, this.text, this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(3.0),
      child: InkWell(
        onTap: onPressed,
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          decoration: BoxDecoration(
              color: color ?? AppTheme.primaryColor,
              borderRadius: BorderRadius.circular(8)),
          child: Text(text ?? "Gửi",
              style: TextStyle(
                  color: textColor ?? AppTheme.brightColor,
                  fontWeight: FontWeight.bold)),
        ),
      ),
    );
  }
}

class SmallRoundedButton extends StatelessWidget {
  final Color? color;
  final Color? textColor;
  final String? text;
  final double? width;
  final VoidCallback? onPressed;
  const SmallRoundedButton({
    Key? key,
    this.color,
    this.textColor,
    this.text,
    this.onPressed,
    this.width,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: InkWell(
        onTap: onPressed,
        child: Container(
          padding: EdgeInsets.all(8),
          width: width,
          decoration: BoxDecoration(
              color: color ?? AppTheme.primaryColor,
              borderRadius: BorderRadius.circular(32)),
          child: Text(text ?? "Send",
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: textColor ?? Colors.white,
                  fontWeight: FontWeight.bold)),
        ),
      ),
    );
  }
}
