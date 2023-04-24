import 'package:flutter/material.dart';
import 'package:love_novel/ui/components/app_theme.dart';
import 'package:love_novel/ui/components/text_field_container.dart';

class RoundedPasswordField extends StatefulWidget {
  final ValueChanged<String?>? onChanged;
  String hintText;
  String? value;
  RoundedPasswordField({
    Key? key,
    this.hintText = "Password",
    this.value,
    this.onChanged,
  }) : super(key: key);

  @override
  State<RoundedPasswordField> createState() => _RoundedPasswordFieldState();
}

class _RoundedPasswordFieldState extends State<RoundedPasswordField> {
  var _obscured = true;
  String? _value;
  @override
  void initState() {
    super.initState();
    _value = widget.value;
  }

  @override
  Widget build(BuildContext context) {
    var controller = TextEditingController(text: _value);
    controller.selection = TextSelection.fromPosition(
        TextPosition(offset: controller.text.length));
    return TextFieldContainer(
      child: TextField(
        obscureText: _obscured,
        onChanged: (value) {
          _value = value;
          if (widget.onChanged != null) widget.onChanged!(value);
        },
        cursorColor: AppTheme.primaryColor,
        controller:controller,
        decoration: InputDecoration(
          hintText: widget.hintText,
          icon: Icon(
            Icons.lock,
            color: AppTheme.primaryColor,
          ),
          suffixIcon: InkWell(
            onTap: () {
              setState(() {
                _obscured = !_obscured;
              });
            },
            child: Icon(
              _obscured ? Icons.visibility : Icons.visibility_off,
              color: AppTheme.primaryColor,
            ),
          ),
          border: InputBorder.none,
        ),
      ),
    );
  }
}
