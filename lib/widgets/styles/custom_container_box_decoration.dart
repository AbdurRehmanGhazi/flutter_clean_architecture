import 'package:flutter_clean_architecture/app.dart';
import 'package:flutter_clean_architecture/core/theme/theme_bloc/theme_bloc.dart';
import 'package:flutter_clean_architecture/main.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../core/theme/app_colors.dart';

// BoxDecoration customContainerBoxDecoration({double borderRadius = 10, Color? borderColor, Color? bgColor}) => BoxDecoration(
//     borderRadius: BorderRadius.circular(borderRadius),
//     border: Border.all(color: borderColor ?? AppColors.backgroundColor),
//     color: bgColor ?? AppColors.primaryCardColor
// );

// BoxDecoration customContainerBoxDecorationForTopBorderOnly() => BoxDecoration(
//     borderRadius: const BorderRadius.vertical(top: Radius.circular(32.0)),
//     border: Border(top: BorderSide(color: AppColors.primaryColor)),
//     color: AppColors.backgroundColor);

// BoxDecoration customContainerBoxDecorationForRightBorderOnly({double borderSize = 2.5, Color? color}) => BoxDecoration(
//     borderRadius: BorderRadius.horizontal(right: Radius.circular(borderSize)),
//     color: color ?? AppColors.primaryColor);

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
  AppColorsMain? AppColors = globalNavigatorKey.currentContext?.watch<ThemeBloc>().state.appColors;
  final customBorderColor = borderColor ?? AppColors?.disabledColor.withOpacity(0.4) ?? Colors.grey.withOpacity(0.4);
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