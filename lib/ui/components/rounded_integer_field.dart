import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:love_novel/ui/components/app_theme.dart';
import 'package:love_novel/ui/components/text_field_container.dart';

class RoundedIntegerField extends StatelessWidget {
  final String? hintText;
  final IconData icon;
  final String? value;
  final ValueChanged<int>? onChanged;
  final bool readOnly;
  const RoundedIntegerField(
      {Key? key,
      this.value,
      this.hintText,
      this.icon = Icons.money,
      this.onChanged,
      this.readOnly = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var controller = TextEditingController(text: value?.toString() ?? "");
    controller.selection = TextSelection.fromPosition(
        TextPosition(offset: controller.text.length));
    return TextFieldContainer(
      child: TextField(
          keyboardType: TextInputType.number,
          inputFormatters: <TextInputFormatter>[
            FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
          ],
          controller: controller,
          onChanged: (value) {
            if (onChanged != null) {
              onChanged!((double.tryParse(value) ?? 0).toInt());
            }
          },
          cursorColor: AppTheme.primaryColor,
          decoration: InputDecoration(
            icon: Icon(
              icon,
              color: AppTheme.primaryColor,
            ),
            hintText: hintText,
            border: InputBorder.none,
          ),
          readOnly: readOnly),
    );
  }
}
