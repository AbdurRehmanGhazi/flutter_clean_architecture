import 'package:flutter/cupertino.dart';

import '../../core/theme/app_pallete.dart';

BoxDecoration customContainerBoxDecoration({double borderRadius = 10, Color? borderColor, Color? bgColor}) => BoxDecoration(
    borderRadius: BorderRadius.circular(borderRadius),
    border: Border.all(color: borderColor ?? AppPalette.backgroundColor),
    color: bgColor ?? AppPalette.primaryCardColor
);


BoxDecoration customContainerBoxDecorationForTopBorderOnly() => BoxDecoration(
    borderRadius: const BorderRadius.vertical(top: Radius.circular(32.0)),
    border: Border(top: BorderSide(color: AppPalette.primaryColor)),
    color: AppPalette.backgroundColor);

BoxDecoration customContainerBoxDecorationForRightBorderOnly({double borderSize = 2.5, Color? color}) => BoxDecoration(
    borderRadius: BorderRadius.horizontal(right: Radius.circular(borderSize)),
    color: color ?? AppPalette.primaryColor);

BoxDecoration createCustomBorder({
  Color? bgColor,
  bool top = false,
  bool bottom = false,
  bool left = false,
  bool right = false,
  bool all = false,
  Color? borderColor,
  double borderWidth = 1.0,
  BorderStyle borderStyle = BorderStyle.solid,
  double allRadius = 0,
  double? topLeftRadius,
  double? topRightRadius,
  double? bottomLeftRadius,
  double? bottomRightRadius,
}) {
  final customBorderColor = borderColor ?? AppPalette.unselectedItemColor.withOpacity(0.4);
  return BoxDecoration(
    color: bgColor,
    border: Border(
      top: (top || all)
          ? BorderSide(color: customBorderColor, width: borderWidth, style: borderStyle)
          : BorderSide.none,
      bottom: (bottom || all)
          ? BorderSide(color: customBorderColor, width: borderWidth, style: borderStyle)
          : BorderSide.none,
      left: (left || all)
          ? BorderSide(color: customBorderColor, width: borderWidth, style: borderStyle)
          : BorderSide.none,
      right: (right || all)
          ? BorderSide(color: customBorderColor, width: borderWidth, style: borderStyle)
          : BorderSide.none,
    ),
    borderRadius: BorderRadius.only(
      topLeft: Radius.circular(topLeftRadius ?? allRadius),
      topRight: Radius.circular(topRightRadius ?? allRadius),
      bottomLeft: Radius.circular(bottomLeftRadius ?? allRadius),
      bottomRight: Radius.circular(bottomRightRadius ?? allRadius),
    ),
  );
}