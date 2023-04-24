import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:love_novel/ui/components/app_theme.dart';

class FontSelectBox<T> extends StatefulWidget {
  final T? value;
  final String? textField;
  final String? valueField;
  final ValueChanged<T?>? onChanged;
  final List<T>? items;
  final double width;
  final double height;
  FontSelectBox(
      {Key? key,
      this.value,
      this.textField,
      this.valueField,
      this.width = double.infinity,
      this.height = 56,
      this.onChanged,
      this.items = const []})
      : assert(
          items == null ||
              items.isEmpty ||
              value == null ||
              items.where((item) {
                    return item == value;
                  }).length ==
                  1,
          "There should be exactly one item with [DropdownButton]'s value "
          'Either zero or 2 or more [DropdownMenuItem]s were detected '
          'with the same value',
        ),
        super(key: key);

  @override
  _FontSelectBoxState<T> createState() => _FontSelectBoxState<T>();
}

class _FontSelectBoxState<T> extends State<FontSelectBox<T>> {
  T? _selectedItem;
  @override
  void initState() {
    super.initState();
    // _selectedItem = widget.value ?? widget.items![0];
  }

  @override
  Widget build(BuildContext context) {
    var value = widget.value ?? widget.items![0];
    return Padding(
      padding: const EdgeInsets.all(2),
      child: Container(
        width: widget.width,
        height: widget.height,
        padding: const EdgeInsets.symmetric(horizontal: 12),
        alignment: Alignment.center,
        decoration: BoxDecoration(
            border: Border(bottom: BorderSide(color: AppTheme.brightColor))),
        child: DropdownButton<T>(
          dropdownColor: Colors.black.withOpacity(0.86),
          isDense: true,
          isExpanded: true,
          value: value,
          icon: const Icon(Icons.font_download),
          iconSize: 24,
          elevation: 16,
          underline: SizedBox(
            height: 1,
          ),
          onChanged: (T? newValue) {
            if (widget.onChanged != null) widget.onChanged!(newValue ?? null);
            // setState(() {
            //   _selectedItem = newValue;
            // });
          },
          items: widget.items!.map((T item) {
            return DropdownMenuItem<T>(
              value: item,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Text(item.toString(),
                    style: TextStyle(
                        color: Colors.white, fontFamily: item.toString(), fontSize: 18)),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}
