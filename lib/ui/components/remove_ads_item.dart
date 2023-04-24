import 'package:flutter/material.dart';
import 'package:love_novel/ui/components/app_icon_button.dart';
import 'package:love_novel/ui/components/app_theme.dart';

class RemoveAdsItem extends StatelessWidget {
  final String text;
  final String price;
  final VoidCallback onTap;
  final bool purchased;
  final Color color;
  const RemoveAdsItem(
      {Key? key,
      required this.text,
      required this.price,
      required this.onTap,
      this.purchased = false,
      required this.color})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.only(bottom: 20, left: 20, right: 20),
        padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        decoration: BoxDecoration(
          color: color,
          border: Border.all(
            color: AppTheme.goldColor,
          ),
          borderRadius: BorderRadius.circular(
            20,
          ),
        ),
        child:
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          Text(
            text,
            style: TextStyle(
                color: color == AppTheme.goldColor
                    ? AppTheme.textColor
                    : Colors.white,
                fontWeight: FontWeight.w600),
          ),
          purchased
              ? AppIconButton(
                  iconData: Icons.done,
                  color: AppTheme.successColor,
                  onPressed: () {},
                )
              : Container(
                  decoration: BoxDecoration(
                    color: AppTheme.successColor,
                    borderRadius: BorderRadius.circular(4),
                  ),
                  padding: EdgeInsets.all(8),
                  child: Text(
                    price,
                    style: TextStyle(color: AppTheme.brightColor),
                  ),
                )
        ]),
      ),
    );
  }
}
