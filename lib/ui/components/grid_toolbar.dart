import 'package:flutter/material.dart';

import 'package:love_novel/ui/components/app_icon_button.dart';
import 'package:love_novel/ui/components/app_theme.dart';

class GridToolbar extends StatelessWidget {
  final bool loading;
  final int count;
  final VoidCallback? onRefreshed;
  const GridToolbar(
      {Key? key, this.loading = false, this.count = 0, this.onRefreshed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        if (loading)
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: SizedBox(
              width: 24,
              height: 24,
              child: CircularProgressIndicator(
                strokeWidth: 8,
                color: AppTheme.primaryColorLight,
              ),
            ),
          ),
        Container(
          alignment: Alignment.centerLeft,
          padding: EdgeInsets.all(8),
          child: Row(
            children: [
              Text(
                "Số lượng: ",
                style: TextStyle(
                    color: AppTheme.disabledColorDark,
                    fontWeight: FontWeight.bold),
              ),
              Text(
                "${count}",
                style: TextStyle(
                    color: AppTheme.primaryColorDark,
                    fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
        Spacer(),
        AppIconButton(
          disabled: loading,
          onPressed: onRefreshed,
          iconData: Icons.refresh,
        ),
      ],
    );
  }
}
