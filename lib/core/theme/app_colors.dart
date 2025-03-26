import 'package:flutter/material.dart';
import '../utils/extensions/hex_color.dart';

// Multiple Color Flavors
AppColorsMain AppColors = AppColorsLightTheme();

abstract class AppColorsMain {
  Color get backgroundColor;
  Color get gradient1;
  Color get gradient2;
  Color get gradient3;
  Color get borderColor;
  Color get primaryBorderColor;
  Color get whiteColor;
  Color get transparentColor;
  Color get primaryColor;
  Color get selectedItemColor;
  Color get unselectedItemColor;
  Color get secondaryBackgroundColor;
  Color get primaryTextColor;
  Color get secondaryTextColor;
  Color get textFieldTitleColor;
  Color get textFieldHintColor;
  Color get textFieldBGColor;
  Color get warningColor;
  Color get primaryCardColor;
  Color get primaryButtonTextColor;
}

class AppColorsDarkTheme implements AppColorsMain {
  @override Color backgroundColor = Color.fromRGBO(24, 24, 32, 1);
  @override Color gradient1 = Color.fromRGBO(187, 63, 221, 1);
  @override Color gradient2 = Color.fromRGBO(251, 109, 169, 1);
  @override Color gradient3 = Color.fromRGBO(255, 159, 124, 1);
  @override Color borderColor = Color.fromRGBO(52, 51, 67, 1);
  @override Color primaryBorderColor = Color.fromRGBO(251, 109, 169, 1);
  @override Color whiteColor = Colors.white;
  @override Color transparentColor = Colors.transparent;
  @override Color primaryColor = Color.fromRGBO(251, 109, 169, 1);
  @override Color selectedItemColor = Color.fromRGBO(251, 109, 169, 1);
  @override Color unselectedItemColor = HexColor.fromHex("9095A0");
  @override Color secondaryBackgroundColor = HexColor.fromHex("ffffff");
  @override Color primaryTextColor = HexColor.fromHex("FFFFFF");
  @override Color secondaryTextColor = HexColor.fromHex("000000");
  @override Color textFieldTitleColor = HexColor.fromHex("000000").withOpacity(0.87);
  @override Color textFieldHintColor = HexColor.fromHex("000C08");
  @override Color textFieldBGColor = HexColor.fromHex("FFFFFF");
  @override Color warningColor = Colors.red;
  @override Color primaryCardColor = Colors.black;
  @override Color primaryButtonTextColor = HexColor.fromHex("#000C08");
}


class AppColorsLightTheme implements AppColorsMain {
  @override Color backgroundColor = Colors.white;
  @override Color gradient1 = Color.fromRGBO(187, 63, 221, 1);
  @override Color gradient2 = Color.fromRGBO(251, 109, 169, 1);
  @override Color gradient3 = Color.fromRGBO(255, 159, 124, 1);
  @override Color borderColor = Color.fromRGBO(52, 51, 67, 1);
  @override Color primaryBorderColor = Color.fromRGBO(251, 109, 169, 1);
  @override Color whiteColor = Colors.white;
  @override Color transparentColor = Colors.transparent;
  @override Color primaryColor = Color.fromRGBO(251, 109, 169, 1);
  @override Color selectedItemColor = Color.fromRGBO(251, 109, 169, 1);
  @override Color unselectedItemColor = HexColor.fromHex("9095A0");
  @override Color secondaryBackgroundColor = HexColor.fromHex("000000");
  @override Color primaryTextColor = HexColor.fromHex("000000");
  @override Color secondaryTextColor = HexColor.fromHex("FFFFFF");
  @override Color textFieldTitleColor = HexColor.fromHex("000000").withOpacity(0.87);
  @override Color textFieldHintColor = HexColor.fromHex("000C08");
  @override Color textFieldBGColor = HexColor.fromHex("f5f5f5");
  @override Color warningColor = Colors.red;
  @override Color primaryCardColor = Colors.black;
  @override Color primaryButtonTextColor = HexColor.fromHex("#000C08");
}



