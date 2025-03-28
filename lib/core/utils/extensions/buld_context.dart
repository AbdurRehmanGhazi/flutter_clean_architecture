import 'package:flutter/material.dart';

extension ContextExtensions on BuildContext {
  bool get isPortrait => MediaQuery.of(this).orientation == Orientation.portrait;
  bool get isLandscape => MediaQuery.of(this).orientation == Orientation.landscape;

  double get screenHeight => MediaQuery.of(this).size.height;
  double get screenWidth => MediaQuery.of(this).size.width;
  double get shortestSide => MediaQuery.of(this).size.shortestSide;

  double get statusBarHeight => MediaQuery.of(this).padding.top;
  double get appBarHeight => AppBar().preferredSize.height;

  double get bodyHeight => screenHeight - statusBarHeight - appBarHeight;

  bool get isTabletOrIpad {
    double deviceWidth = MediaQuery.of(this).size.shortestSide;
    return deviceWidth >= 600; // 600dp is a common threshold for tablets
  }
}
