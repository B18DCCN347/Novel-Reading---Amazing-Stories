import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:love_novel/ui/components/app_theme.dart';
import 'package:love_novel/ui/components/texts.dart';

class AppDropDown<T> extends StatefulWidget {
  final T? value;
  final String? textField;
  final ValueChanged<T?>? onChanged;
  final List<T>? items;
  final double width;
  final double height;
  AppDropDown(
      {Key? key,
      this.value,
      this.textField,
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
  _AppDropDownState<T> createState() => _AppDropDownState<T>();
}

class _AppDropDownState<T> extends State<AppDropDown<T>> {
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
          color: AppTheme.primaryColorDark.withOpacity(0.1),
          borderRadius: BorderRadius.all(Radius.circular(28)),
        ),
        child: DropdownButton<T>(
          isDense: true,
          isExpanded: true,
          value: value,
          icon: const Icon(Icons.arrow_drop_down),
          iconSize: 24,
          elevation: 16,
          underline: SizedBox(
            height: 1,
          ),
          onChanged: (T? newValue) {
            widget.onChanged!(newValue ?? null);
            // setState(() {
            //   _selectedItem = newValue;
            // });
          },
          items: widget.items!.map((T item) {
            var txt = "";
            if (widget.textField != null) {
              var jsonStr = jsonEncode(item);
              var json = jsonDecode(jsonStr);
              txt = json[widget.textField];
            } else
              txt = item.toString();
            return DropdownMenuItem<T>(
              value: item,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Text(txt,
                    style: TextStyle(color: AppTheme.primaryColorDark)),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}

//Button dropdown
class AppButtonDropDown<T> extends StatefulWidget {
  final T? value;
  final String? textField;
  final Icon? icon;
  final ValueChanged<T>? onChanged;
  final List<T?>? items;
  final double size;
  AppButtonDropDown(
      {Key? key,
      this.value,
      this.icon,
      this.textField,
      this.size = 46,
      this.onChanged,
      this.items = const []})
      : super(key: key);

  @override
  _AppButtonDropDownState<T> createState() => _AppButtonDropDownState<T>();
}

class _AppButtonDropDownState<T> extends State<AppButtonDropDown<T>> {
  // T? _selectedItem;
  @override
  void initState() {
    super.initState();
    // _selectedItem = widget.value ?? widget.items![0];
  }

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<T>(
        icon: widget.icon,
        iconSize: widget.size / 2,
        initialValue: widget.value ?? widget.items![0],
        onSelected: (T newValue) {
          widget.onChanged!(newValue);
          // setState(() {
          //   _selectedItem = newValue;
          // });
        },
        itemBuilder: (BuildContext context) => widget.items!.map((item) {
              var txt = "";
              if (widget.textField != null) {
                var jsonStr = jsonEncode(item);
                var json = jsonDecode(jsonStr);
                txt = json[widget.textField];
              } else
                txt = item.toString();
              return PopupMenuItem<T>(
                value: item,
                child: Text(txt,
                    style: TextStyle(color: AppTheme.primaryColorDark)),
              );
            }).toList());
  }
}

class AppDropDownGroup<T> extends StatefulWidget {
  T? value;
  final String? textField;
  final ValueChanged<T?>? onChanged;
  final List<T>? items;
  final double width;
  final double height;
  final String label;
  final String? errorText;
  final bool require;
  final bool readOnly;
  AppDropDownGroup(
      {Key? key,
      this.value,
      this.textField,
      this.width = 100,
      this.height = 36,
      this.onChanged,
      this.require = false,
      this.readOnly = false,
      this.label = "",
      this.errorText,
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
  _AppDropDownGroupState createState() => _AppDropDownGroupState<T>();
}

class _AppDropDownGroupState<T> extends State<AppDropDownGroup<T>> {
  @override
  Widget build(BuildContext context) {
    if (widget.value == null) {
      widget.value = widget.items![0];
    }
    return Container(
      // padding: const EdgeInsets.only(top: 8, left: 4.0, right: 4),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(4.0),
            child: Row(
              children: [
                Flexible(
                  child: Text(
                    "${widget.label}:",
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: AppTheme.primaryColor),
                  ),
                ),
                if (widget.require)
                  Text(
                    " * ",
                    style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: AppTheme.errorColor),
                  ),
              ],
            ),
          ),
          AbsorbPointer(
            absorbing: widget.readOnly,
            child: Container(
              height: 46,
              decoration: BoxDecoration(
                  border: Border.all(color: AppTheme.greyColorLight, width: 1),
                  color: AppTheme.primaryColorDark.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(24)),
              child: AppDropDown<T>(
                  items: widget.items,
                  value: widget.value,
                  width: widget.width,
                  onChanged: widget.onChanged,
                  textField: widget.textField),
            ),
          ),
          if (widget.errorText != null)
            Padding(
              padding: const EdgeInsets.only(top: 4.0, left: 4),
              child: ErrorText(
                widget.errorText ?? "",
              ),
            )
        ],
      ),
    );
  }
}
