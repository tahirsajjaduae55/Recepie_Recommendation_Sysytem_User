import 'package:flutter/material.dart';

class ColorManager {
  static Color transparent = Colors.transparent;
  static Color primary = HexColor.fromHex('#008000');

  static Color secondary = HexColor.fromHex('#FDDC5C');
  static Color primaryLight = HexColor.fromHex('#f7c028');
  static Color yellow = Colors.yellow;

  // static Color secondaryLight = HexColor.fromHex('#F9A84D');
  static Color green = HexColor.fromHex('#062d1f');
  static Color textButton = HexColor.fromHex('#1877F2');
  static Color red = HexColor.fromHex('#FF4949');
  static Color orange = HexColor.fromHex('#FF8F25');
  static Color brown = HexColor.fromHex('#D88437');

  static Color grey = HexColor.fromHex('#EEEEEE');
  static Color darkGrey = HexColor.fromHex('#B1B1B1');
  static Color textGreeen = HexColor.fromHex('#4EBE7B');
  static Color accent = HexColor.fromHex('#FF4949');

  static Color error = HexColor.fromHex('#FF3333'); // red color
  static Color errorLight = Colors.redAccent;
  static Color black = HexColor.fromHex('#000000');
  static Color divider = HexColor.fromHex('#C4C4C4B2');
  static Color divider2 = HexColor.fromHex('#929292');
  static Color white = HexColor.fromHex('#FFFFFF');
  static Color borderColor = HexColor.fromHex('#D0D0D0');
  static Color cardBorder = HexColor.fromHex('#E1E1E1');
  static Color cardbg = HexColor.fromHex('#FCFDFF');
  static Color circleAvatarBg = HexColor.fromHex('#ECEFFF');
  static Color elevationColor = HexColor.fromHex('#000000').withOpacity(0.15);
  //
}

extension HexColor on Color {
  static Color fromHex(String hexColorString) {
    hexColorString = hexColorString.replaceAll('#', '');
    if (hexColorString.length == 6) {
      hexColorString = 'FF$hexColorString'; // 8 char with opacity 100%
    }
    return Color(int.parse(hexColorString, radix: 16));
  }
}
