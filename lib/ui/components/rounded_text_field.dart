import 'package:flutter/material.dart';
import 'package:love_novel/ui/components/app_theme.dart';
import 'package:love_novel/ui/components/text_field_container.dart';

class RoundedTextField extends StatelessWidget {
  final String? hintText;
  final IconData icon;
  final String? value;
  final ValueChanged<String>? onChanged;
  final bool readOnly;
  const RoundedTextField({
    Key? key,
    this.value,
    this.hintText,
    this.icon = Icons.person,
    this.onChanged,
    this.readOnly=false
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    
    var controller = TextEditingController(text: value);
    controller.selection = TextSelection.fromPosition(
        TextPosition(offset: controller.text.length));
    return TextFieldContainer(
      child: TextField(
        onChanged: onChanged,
        cursorColor: AppTheme.primaryColor,
        controller: controller,
        decoration: InputDecoration(
          icon: Icon(
            icon,
            color: AppTheme.primaryColor,
          ),
          hintText: hintText,
          border: InputBorder.none,
        ),
        readOnly:readOnly
      ),
    );
  }
}
