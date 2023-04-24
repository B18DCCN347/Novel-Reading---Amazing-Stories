import 'dart:math';

import 'package:flutter/material.dart';

import 'package:love_novel/ui/components/app_icon_button.dart';
import 'package:love_novel/ui/components/app_theme.dart';

class ChoicesSettingCardItem {
  final double value;
  final String text;
  final String name;
  const ChoicesSettingCardItem(this.value, this.text, this.name);
}

class ChoicesSettingCard extends StatefulWidget {
  final Color? color;
  final IconData iconData;
  final ChoicesSettingCardItem value;
  final String description;
  final Widget? child;
  final ValueChanged<String> onChanged;
  final List<ChoicesSettingCardItem> values;
  const ChoicesSettingCard(
      {Key? key,
      this.color,
      required this.iconData,
      required this.value,
      required this.description,
      required this.onChanged,
      this.child,
      this.values = const []})
      : super(key: key);

  @override
  State<ChoicesSettingCard> createState() => _ChoicesSettingCardState();
}

class _ChoicesSettingCardState extends State<ChoicesSettingCard> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var minValue = widget.values.map((e) => e.value).reduce(min);
    var maxValue = widget.values.map((e) => e.value).reduce(max);
    return Container(
        margin: EdgeInsets.only(bottom: 8),
        padding: EdgeInsets.all(8),
        decoration: BoxDecoration(
            color: AppTheme.backgroundColorLight,
            borderRadius: BorderRadius.all(Radius.circular(12))),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Icon(
                widget.iconData,
                size: 28,
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
                            widget.value.text,
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 16),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Text(
                      widget.description.replaceAll('{text}', widget.value.text.toLowerCase()),
                      style: TextStyle(
                        color: AppTheme.disabledColorDark,
                      ),
                    ),
                  ),
                  Slider(
                    value: widget.value.value,
                    min: minValue,
                    max: maxValue,
                    divisions: 2,
                    label: widget.value.text,
                    activeColor: widget.value.value == maxValue
                        ? AppTheme.errorColor
                        : widget.value.value != minValue
                            ? AppTheme.warningColor
                            : null,
                    onChanged: (value) {
                      var item = widget.values.firstWhere(
                          (element) => element.value == value,
                          orElse: () => widget.values.first);
                      widget.onChanged(item.name);
                    },
                  )
                ],
              ),
            ),
          ],
        ));
  }
}

class SettingCard extends StatelessWidget {
  final Color? color;
  final IconData iconData;
  final String title;
  final String description;
  final Widget? child;
  final bool activated;
  final ValueChanged<bool> onToggled;
  const SettingCard({
    Key? key,
    this.color,
    required this.iconData,
    required this.title,
    required this.description,
    required this.activated,
    required this.onToggled,
    this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.only(bottom: 8),
        padding: EdgeInsets.all(8),
        decoration: BoxDecoration(
            color: activated
                ? AppTheme.backgroundColorLight
                : AppTheme.disabledColor.withOpacity(0.9),
            borderRadius: BorderRadius.all(Radius.circular(12))),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Icon(
                iconData,
                size: 28,
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
                      Switch(
                        value: activated,
                        onChanged: onToggled,
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Text(
                      description,
                      style: TextStyle(
                        color: AppTheme.disabledColorDark,
                      ),
                    ),
                  ),
                  AbsorbPointer(
                    absorbing: !activated,
                    child: child ??
                        SizedBox(
                          height: 8,
                        ),
                  )
                ],
              ),
            ),
          ],
        ));
  }
}

class RangeSettingCard extends StatefulWidget {
  final Color? color;
  final IconData iconData;
  final String title;
  final String description;
  final RangeValues values;
  final String unit;
  final ValueChanged<RangeValues> onChanged;
  final ValueChanged<bool> onToggled;
  final double min;
  final double max;
  const RangeSettingCard({
    Key? key,
    this.color,
    required this.iconData,
    required this.title,
    required this.description,
    required this.values,
    required this.unit,
    required this.onChanged,
    required this.onToggled,
    required this.min,
    required this.max,
  }) : super(key: key);

  @override
  State<RangeSettingCard> createState() => _RangeSettingCardState();
}

class _RangeSettingCardState extends State<RangeSettingCard> {
  late SettingValueController startController;
  late SettingValueController endController;
  @override
  void initState() {
    super.initState();
    startController = SettingValueController(false);
    endController = SettingValueController(false);
  }

  @override
  Widget build(BuildContext context) {
    return SettingCard(
      iconData: widget.iconData,
      title: widget.title,
      description: widget.description,
      activated: widget.values.start > 0 || widget.values.end > 0,
      onToggled: widget.onToggled,
      child: Column(
        children: [
          SizedBox(height: 12),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0),
            child: Row(
              children: [
                SettingValueEditor(
                  controller: startController,
                  value: widget.values.start,
                  min: widget.min,
                  max: widget.values.end,
                  unit: widget.unit,
                  onChanged: (value) {
                    widget.onChanged(RangeValues(value, widget.values.end));
                  },
                ),
                Spacer(),
                SettingValueEditor(
                  controller: endController,
                  value: widget.values.end,
                  min: widget.values.start,
                  max: widget.max,
                  unit: widget.unit,
                  onChanged: (value) {
                    widget.onChanged(RangeValues(widget.values.start, value));
                  },
                ),
              ],
            ),
          ),
          Row(
            children: [
              Expanded(
                child: RangeSlider(
                  values: RangeValues(
                    widget.values.start,
                    widget.values.end,
                  ),
                  labels: RangeLabels(
                    widget.values.start.toStringAsFixed(0),
                    widget.values.end.toStringAsFixed(0),
                  ),
                  onChanged: (values) {
                    widget.onChanged(values);
                    if (startController.value) startController.value = false;
                    if (endController.value) endController.value = false;
                  },
                  min: widget.min,
                  max: widget.max,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class ValueSettingCard extends StatefulWidget {
  final Color? color;
  final IconData iconData;
  final String title;
  final String description;
  final String unit;
  final double value;
  final ValueChanged<double> onChanged;
  final ValueChanged<bool> onToggled;
  final double min;
  final double max;
  const ValueSettingCard({
    Key? key,
    this.color,
    required this.iconData,
    required this.title,
    required this.description,
    required this.value,
    required this.onChanged,
    required this.onToggled,
    required this.unit,
    required this.min,
    required this.max,
  }) : super(key: key);

  @override
  State<ValueSettingCard> createState() => _ValueSettingCardState();
}

class _ValueSettingCardState extends State<ValueSettingCard> {
  late SettingValueController valueController;
  @override
  void initState() {
    super.initState();
    valueController = SettingValueController(false);
  }

  @override
  Widget build(BuildContext context) {
    return SettingCard(
      iconData: widget.iconData,
      title: widget.title,
      description: widget.description,
      onToggled: widget.onToggled,
      activated: widget.value > 0,
      child: Column(
        children: [
          SizedBox(height: 12),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0),
            child: Row(
              children: [
                SettingValueEditor(
                  value: widget.value,
                  min: widget.min,
                  max: widget.max,
                  unit: widget.unit,
                  onChanged: widget.onChanged,
                  controller: valueController,
                ),
                Spacer(),
              ],
            ),
          ),
          Slider(
            value: widget.value,
            label: widget.value.toStringAsFixed(0),
            onChanged: (value) {
              if (valueController.value)
                setState(() {
                  valueController.value = false;
                });
              widget.onChanged(value);
            },
            min: widget.min,
            max: widget.max,
          ),
        ],
      ),
    );
  }
}

class SettingValueController extends ValueNotifier<bool> {
  SettingValueController(bool value) : super(value);
}

class SettingValueEditor extends StatefulWidget {
  final double value;
  final double min;
  final double max;
  final String unit;
  final ValueChanged<double> onChanged;
  SettingValueController controller;
  SettingValueEditor(
      {Key? key,
      required this.value,
      required this.min,
      required this.max,
      required this.unit,
      required this.onChanged,
      required this.controller})
      : super(key: key);

  @override
  _SettingValueEditorState createState() => _SettingValueEditorState();
}

class _SettingValueEditorState extends State<SettingValueEditor> {
  late TextEditingController _controller;
  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.value.toStringAsFixed(0));
  }

  _changeValue() {
    var value = double.tryParse(_controller.text) ?? 0;
    if (value < widget.min) {
      value = widget.min;
    } else if (value > widget.max) value = widget.max;
    _controller.text = value.toStringAsFixed(0);
    widget.onChanged(value);
  }

  _loadValue() {
    _controller.text = widget.value.toStringAsFixed(0);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 12.0),
      child: Row(
        children: [
          widget.controller.value
              ? Container(
                  height: 36,
                  width: 68,
                  margin: EdgeInsets.only(bottom: 4),
                  child: TextField(
                    keyboardType: TextInputType.number,
                    controller: _controller,
                    textAlign: TextAlign.right,
                    style: TextStyle(color: AppTheme.primaryColorDark),
                  ),
                )
              : Text(
                  "${widget.value.toStringAsFixed(0)}",
                  style: TextStyle(color: AppTheme.primaryColorDark, height: 2),
                ),
          Text(
            widget.unit,
            style: TextStyle(color: AppTheme.primaryColorDark, height: 2),
          ),
          Container(
            padding: EdgeInsets.only(top: 6),
            child: widget.controller.value
                ? AppIconButton(
                    iconData: Icons.save,
                    size: 20,
                    color: AppTheme.successColor,
                    onPressed: () {
                      setState(() {
                        widget.controller.value = false;
                      });
                      _changeValue();
                    },
                  )
                : AppIconButton(
                    iconData: Icons.edit,
                    size: 20,
                    color: AppTheme.warningColor,
                    onPressed: () {
                      setState(() {
                        widget.controller.value = true;
                      });
                      _loadValue();
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
