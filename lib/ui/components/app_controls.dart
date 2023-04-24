import 'package:date_time_picker/date_time_picker.dart';
import 'package:love_novel/app/utils/datetime_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:love_novel/ui/components/app_theme.dart';
import 'package:love_novel/ui/components/texts.dart';

class AppTextField extends StatelessWidget {
  final String label;
  final String? value;
  final bool require;
  final bool readOnly;
  final ValueChanged<String>? onChanged;
  final String? errorText;
  AppTextField(
      {Key? key,
      required this.label,
      this.onChanged,
      this.value,
      this.errorText,
      this.readOnly = false,
      this.require = false})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    var controller = TextEditingController(text: value);
    controller.selection = TextSelection.fromPosition(
        TextPosition(offset: controller.text.length));
    return Container(
      padding: const EdgeInsets.only(top: 8, left: 4.0, right: 4),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(4.0),
            child: Row(
              children: [
                Flexible(
                  child: Text(
                    "$label:",
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: AppTheme.primaryColor),
                  ),
                ),
                if (require)
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
          Container(
            height: 46,
            padding: EdgeInsets.only(left: 8, bottom: 8),
            decoration: BoxDecoration(
                border: Border.all(color: AppTheme.greyColorLight, width: 1),
                color: AppTheme.primaryColorDark.withOpacity(0.1),
                borderRadius: BorderRadius.circular(24)),
            child: TextField(
              readOnly: readOnly,
              controller: controller,
              onChanged: (value) {
                if (onChanged != null) onChanged!(value);
              },
              style: TextStyle(color: AppTheme.primaryColorDark, height: 1.5),
              decoration: InputDecoration(
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  border: InputBorder.none),
            ),
          ),
          if (errorText != null)
            Padding(
              padding: const EdgeInsets.only(top: 4.0, left: 4),
              child: ErrorText(
                errorText ?? "",
              ),
            )
        ],
      ),
    );
  }
}

class AppTextArea extends StatelessWidget {
  final String label;
  final String? value;
  final bool require;
  final bool readOnly;
  final ValueChanged<String>? onChanged;
  final String? errorText;
  AppTextArea(
      {Key? key,
      required this.label,
      this.onChanged,
      this.value,
      this.errorText,
      this.readOnly = false,
      this.require = false})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    var controller = TextEditingController(text: value);
    controller.selection = TextSelection.fromPosition(
        TextPosition(offset: controller.text.length));
    return Container(
      padding: const EdgeInsets.only(top: 8, left: 4.0, right: 4),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(4.0),
            child: Row(
              children: [
                Flexible(
                  child: Text(
                    "$label:",
                    maxLines: 8,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: AppTheme.primaryColor),
                  ),
                ),
                if (require)
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
          Container(
            height: 46,
            padding: EdgeInsets.only(left: 8, bottom: 8),
            decoration: BoxDecoration(
                border: Border.all(color: AppTheme.greyColorLight, width: 1),
                color: AppTheme.primaryColorDark.withOpacity(0.1),
                borderRadius: BorderRadius.circular(24)),
            child: TextField(
              readOnly: readOnly,
              controller: controller,
              onChanged: (value) {
                if (onChanged != null) onChanged!(value);
              },
              style: TextStyle(color: AppTheme.primaryColorDark, height: 1.5),
              decoration: InputDecoration(
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  border: InputBorder.none),
            ),
          ),
          if (errorText != null)
            Padding(
              padding: const EdgeInsets.only(top: 4.0, left: 4),
              child: ErrorText(
                errorText ?? "",
              ),
            )
        ],
      ),
    );
  }
}
class AppNumericTextField extends StatelessWidget {
  final String label;
  final double? value;
  final bool require;
  final bool readOnly;
  final int digit;
  final ValueChanged<double>? onChanged;
  AppNumericTextField(
      {Key? key,
      required this.label,
      this.require = false,
      this.readOnly = false,
      this.onChanged,
      this.value,
      this.digit = 2})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    var controller =
        TextEditingController(text: value?.toStringAsFixed(digit) ?? "");
    controller.selection = TextSelection.fromPosition(
        TextPosition(offset: controller.text.length));
    return Container(
      padding: const EdgeInsets.only(top: 8, left: 4.0, right: 4),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(4.0),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    "$label:",
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: AppTheme.primaryColor),
                  ),
                ),
                if (require)
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
          Container(
            height: 46,
            padding: EdgeInsets.symmetric(horizontal: 4),
            decoration: BoxDecoration(
                border: Border.all(color: AppTheme.greyColorLight, width: 1),
                color: AppTheme.primaryColorDark.withOpacity(0.1),
                borderRadius: BorderRadius.circular(24)),
            child: TextField(
              keyboardType: TextInputType.number,
              controller: controller,
              onChanged: (value) {
                if (onChanged != null) onChanged!(double.tryParse(value) ?? 0);
              },
              style: TextStyle(color: AppTheme.primaryColorDark, height: 1.5),
              decoration: InputDecoration(
                  contentPadding: EdgeInsets.fromLTRB(4, 0, 4, 4),
                  border: InputBorder.none),
              readOnly: readOnly,
            ),
          ),
        ],
      ),
    );
  }
}

//số nguyên
class AppIntegerTextField extends StatelessWidget {
  final String label;
  final int? value;
  final bool require;
  final ValueChanged<int>? onChanged;
  AppIntegerTextField(
      {Key? key,
      required this.label,
      this.require = false,
      this.onChanged,
      this.value})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    var controller = TextEditingController(text: value?.toString() ?? "");
    controller.selection = TextSelection.fromPosition(
        TextPosition(offset: controller.text.length));
    return Container(
      padding: const EdgeInsets.only(top: 8, left: 4.0, right: 4),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(4.0),
            child: Row(
              children: [
                Flexible(
                  child: Text(
                    "$label:",
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: AppTheme.primaryColor),
                  ),
                ),
                if (require)
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
          Container(
            height: 46,
            padding: EdgeInsets.symmetric(horizontal: 8),
            decoration: BoxDecoration(
                border: Border.all(color: AppTheme.greyColorLight, width: 1),
                color: AppTheme.primaryColorDark.withOpacity(0.1),
                borderRadius: BorderRadius.circular(24)),
            child: TextField(
              keyboardType: TextInputType.number,
              inputFormatters: <TextInputFormatter>[
                FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
              ],
              controller: controller,
              onChanged: (value) {
                if (onChanged != null)
                  onChanged!((double.tryParse(value) ?? 0).toInt());
              },
              style: TextStyle(color: AppTheme.primaryColorDark, height: 1.5),
              decoration: InputDecoration(
                  contentPadding: EdgeInsets.fromLTRB(8, 0, 4, 4),
                  border: InputBorder.none),
            ),
          ),
        ],
      ),
    );
  }
}

//ngày tháng
class AppDatePicker extends StatefulWidget {
  final String label;
  DateTime? initialDate;
  DateTime? firstDate;
  DateTime? lastDate;
  String? errorText;
  final bool require;
  final bool readOnly;
  ValueChanged<String>? onDateSelected;

  AppDatePicker(
      {Key? key,
      required this.label,
      this.initialDate,
      this.firstDate,
      this.lastDate,
      this.errorText,
      this.require = false,
      this.readOnly = false,
      this.onDateSelected})
      : super(key: key);

  @override
  _AppDatePickerState createState() => _AppDatePickerState();
}

class _AppDatePickerState extends State<AppDatePicker> {
  DateTime? value;

  @override
  void initState() {
    super.initState();
    value = widget.initialDate;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(4.0),
            child: Row(
              children: [
                Text(
                  "${widget.label}:",
                  style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: AppTheme.primaryColor),
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
          Container(
            height: 46,
            padding: EdgeInsets.symmetric(horizontal: 4),
            decoration: BoxDecoration(
                border: Border.all(color: AppTheme.greyColorLight, width: 1),
                color: AppTheme.primaryColorDark.withOpacity(0.1),
                borderRadius: BorderRadius.circular(24)),
            child: InkWell(
              onTap: widget.readOnly
                  ? null
                  : () async {
                      var date = await showDatePicker(
                          context: context,
                          initialDate: value ?? DateTime.now(),
                          firstDate: widget.firstDate ?? DateTime.now(),
                          lastDate: widget.lastDate ?? DateTime.now(),
                          locale: Locale('vi', 'VN'));
                      setState(() {
                        value = date;
                      });
                      if (widget.onDateSelected != null)
                        widget.onDateSelected!(DateTimeHelpers.dateTimeToString(
                            date ?? DateTime.now(), "yyyy-MM-dd"));
                    },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Icon(
                      Icons.date_range,
                      color: AppTheme.primaryColor,
                    ),
                  ),
                  DisabledText(value != null
                      ? DateTimeHelpers.formatDDMMYYYY(value ?? DateTime.now())
                      : ""),
                ],
              ),
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

//thời gian

class AppDateTimePicker extends StatelessWidget {
  final String label;
  DateTime? initialTime;
  DateTime? firstTime;
  DateTime? lastTime;
  final bool require;
  ValueChanged<String>? onDateSelected;

  AppDateTimePicker(
      {Key? key,
      required this.label,
      this.initialTime,
      this.firstTime,
      this.require = false,
      this.lastTime,
      this.onDateSelected})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding:
              const EdgeInsets.only(top: 8.0, left: 4, right: 4, bottom: 4),
          child: Text(
            "$label:",
            style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.bold,
                color: AppTheme.primaryColor),
          ),
        ),
        Container(
          decoration: BoxDecoration(
              border: Border.all(color: AppTheme.greyColorLight, width: 1),
              color: AppTheme.primaryColorDark.withOpacity(0.1),
              borderRadius: BorderRadius.circular(24)),
          child: DateTimePicker(
            type: DateTimePickerType.dateTime,
            dateMask: "HH:mm dd/MM/yyyy",
            controller: TextEditingController(
                text: initialTime == null
                    ? ""
                    : DateTimeHelpers.formatDDMMYYYY(
                        initialTime ?? DateTime.now())),
            firstDate: firstTime,
            lastDate: lastTime,
            // dateLabelText: 'Ngày',
            // timeLabelText: "Giờ",
            decoration: InputDecoration(
                border: InputBorder.none,
                prefixIcon: Icon(
                  Icons.event,
                  color: AppTheme.primaryColor,
                )),
            use24HourFormat: true,
            locale: Locale('vi', 'VN'),
            onChanged: (value) {
              if (onDateSelected != null) {
                var time =
                    DateTimeHelpers.stringToDateTime(value, "yyyy-MM-dd HH:mm");
                onDateSelected!(DateTimeHelpers.dateTimeToString(
                    time, "yyyy-MM-dd HH:mm:ss"));
              }
            },
            // validator: (val) {
            //   setState(() => _valueToValidate1 = val ?? '');
            //   return null;
            // },
            // onSaved: (val) => setState(() => _valueSaved1 = val ?? ''),
          ),
        ),
      ],
    );
  }
}

//bool
class AppCheckbox extends StatefulWidget {
  final String label;
  bool value;
  final bool require;
  final ValueChanged<bool>? onChanged;
  AppCheckbox(
      {Key? key,
      required this.label,
      this.require = false,
      this.onChanged,
      required this.value})
      : super(key: key);

  @override
  _AppCheckboxState createState() => _AppCheckboxState();
}

class _AppCheckboxState extends State<AppCheckbox> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 8, left: 4.0, right: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            constraints: BoxConstraints(
                maxWidth: MediaQuery.of(context).size.width * .65),
            child: Padding(
              padding: const EdgeInsets.all(4.0),
              child: Text(
                "${widget.label}:",
                overflow: TextOverflow.visible,
                style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: AppTheme.primaryColor),
              ),
            ),
          ),
          if (widget.require)
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 4.0),
              child: Text(
                " * ",
                style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: AppTheme.errorColor),
              ),
            ),
          SizedBox(
            height: 30,
            child: Checkbox(
                value: widget.value,
                onChanged: (value) {
                  widget.value = value ?? false;
                  widget.onChanged!(value ?? false);
                  setState(() {});
                }),
          ),
        ],
      ),
    );
  }
}
