import 'package:flutter/material.dart';
import 'package:love_novel/app/utils/string_helper.dart';
import 'package:love_novel/ui/components/app_theme.dart';

class BoldText extends StatelessWidget {
  final String data;
  const BoldText(
    this.data, {
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      data,
      style: TextStyle(fontWeight: FontWeight.bold, height: 2, fontSize: 16),
    );
  }
}

class ErrorText extends StatelessWidget {
  final bool dense;
  final String data;
  const ErrorText(
    this.data, {
    Key? key,
    this.dense = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      data,
      style: TextStyle(
          fontSize: dense ? null : 12,
          color: AppTheme.errorColor,
          fontWeight: dense ? null : FontWeight.bold),
    );
  }
}

class IvsText extends StatelessWidget {
  final bool isMinus;
  final int? data;
  const IvsText(
    this.data, {
    Key? key,
    this.isMinus = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          (isMinus ? "-" : "+") + StringHelper.toVnNumber((data ?? 0)),
          style: TextStyle(
              fontSize: 16,
              color: isMinus ? AppTheme.errorColor : AppTheme.successColor,
              fontWeight: FontWeight.bold),
        ),
        DisabledText(
          " IVS",
        ),
      ],
    );
  }
}

class SuccessText extends StatelessWidget {
  final bool dense;
  final String data;
  const SuccessText(
    this.data, {
    Key? key,
    this.dense = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      data,
      style: TextStyle(
          fontSize: dense ? null : 12,
          color: AppTheme.successColor,
          fontWeight: dense ? null : FontWeight.bold),
    );
  }
}

class PrimaryText extends StatelessWidget {
  final bool dense;
  final String data;
  const PrimaryText(
    this.data, {
    Key? key,
    this.dense = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      data,
      style: TextStyle(
          fontSize: dense ? 12 : null,
          color: AppTheme.primaryColor,
          fontWeight: dense ? null : FontWeight.bold),
    );
  }
}



class LinkText extends StatelessWidget {
  final String data;
  final VoidCallback onTap;
  const LinkText(this.data,{
    Key? key,
   required this.onTap
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: InkWell(
            child: Text(
              data,
              textAlign: TextAlign.right,
              style: TextStyle(
                  color: AppTheme.primarySwatch,
                  fontWeight: FontWeight.bold,
                  decoration: TextDecoration.underline,
                  height: 3),
            ),
            onTap:onTap,
          ),
        ),
      ],
    );
  }
}

class DisabledText extends StatelessWidget {
  final bool dense;
  final String data;
  final Color? color;
  const DisabledText(
    this.data, {
    Key? key,
    this.dense = false,
    this.color
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      data,
      textAlign: dense ? TextAlign.right : null,
      style: TextStyle(
          fontSize: dense ? 11 : 13,
          color:color?? AppTheme.disabledColorDark,
          fontWeight: dense ? null : FontWeight.bold,
          fontStyle: dense ? FontStyle.italic : null),
    );
  }
}
