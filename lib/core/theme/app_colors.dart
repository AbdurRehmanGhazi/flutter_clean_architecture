import 'package:flutter/material.dart';
import '../utils/extensions/hex_color.dart';

// Multiple Color Flavors
// AppColorsMain AppColors = AppColorsLightTheme();

abstract class AppColorsMain {
  Color get backgroundColor;
  Color get primaryColor;
  Color get secondaryColor;
  Color get borderColor;
  Color get whiteColor;
  Color get transparentColor;
  Color get selectedItemColor;
  Color get disabledColor;
  Color get secondaryBackgroundColor;
  Color get primaryTextColor;
  Color get secondaryTextColor;
  Color get textFieldTitleColor;
  Color get textFieldHintColor;
  Color get textFieldBGColor;
  Color get warningColor;
  Color get primaryCardColor;
  Color get shadowColor;
}

class AppColorsDarkTheme implements AppColorsMain {
  @override Color backgroundColor = Color.fromRGBO(24, 24, 32, 1);
  @override Color primaryColor = HexColor.fromHex("4A7EF7");
  @override Color secondaryColor = HexColor.fromHex("6D51EC");
  @override Color borderColor = Color.fromRGBO(52, 51, 67, 1);
  @override Color whiteColor = Colors.white;
  @override Color transparentColor = Colors.transparent;
  @override Color selectedItemColor = Color.fromRGBO(251, 109, 169, 1);
  @override Color disabledColor = HexColor.fromHex("9095A0");
  @override Color secondaryBackgroundColor = HexColor.fromHex("ffffff");
  @override Color primaryTextColor = HexColor.fromHex("FFFFFF");
  @override Color secondaryTextColor = HexColor.fromHex("000000");
  @override Color textFieldTitleColor = HexColor.fromHex("000000").withOpacity(0.87);
  @override Color textFieldHintColor = HexColor.fromHex("000C08");
  @override Color textFieldBGColor = HexColor.fromHex("FFFFFF");
  @override Color warningColor = Colors.red;
  @override Color primaryCardColor = Colors.black;
  @override Color shadowColor =  Colors.white.withAlpha(40);
}


class AppColorsLightTheme implements AppColorsMain {
  @override Color backgroundColor = HexColor.fromHex("f5f5f5");
  @override Color primaryColor = HexColor.fromHex("4A7EF7");
  @override Color secondaryColor = HexColor.fromHex("6D51EC");
  @override Color borderColor = Color.fromRGBO(52, 51, 67, 1);
  @override Color whiteColor = Colors.white;
  @override Color transparentColor = Colors.transparent;
  @override Color selectedItemColor = Color.fromRGBO(251, 109, 169, 1);
  @override Color disabledColor = HexColor.fromHex("9095A0");
  @override Color secondaryBackgroundColor = HexColor.fromHex("000000");
  @override Color primaryTextColor = HexColor.fromHex("000000");
  @override Color secondaryTextColor = HexColor.fromHex("FFFFFF");
  @override Color textFieldTitleColor = HexColor.fromHex("000000").withOpacity(0.87);
  @override Color textFieldHintColor = HexColor.fromHex("000C08");
  @override Color textFieldBGColor = HexColor.fromHex("EDEDED");
  @override Color warningColor = Colors.red;
  @override Color primaryCardColor = Colors.white;
  @override Color shadowColor =  Colors.black;
}



