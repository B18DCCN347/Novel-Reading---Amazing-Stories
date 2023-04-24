import 'dart:ui';

class ColorHelper {
  static Color hexToColor(String code) {
    code = code.toUpperCase().replaceAll("#", "");
    if (code.length == 6) {
      code = "FF" + code;
    }
    return Color(int.parse(code, radix: 16));
  }
}
