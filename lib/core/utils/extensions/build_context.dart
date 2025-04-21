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

  /// Presents a screen over the current screen as a full-screen modal.
  void presentScreen(Widget screen) {
    Navigator.of(this).push(
      MaterialPageRoute(
        fullscreenDialog: true, // Makes it appear as a modal
        builder: (context) => screen,
      ),
    );
  }

  /// Presents a custom full-screen dialog
  void presentCustomDialog(Widget dialogContent) {
    showDialog(
      context: this,
      barrierDismissible: true, // Prevents dismissing by tapping outside
      builder: (context) {
        return Dialog(
          backgroundColor: Colors.transparent, // Makes the background transparent
          insetPadding: EdgeInsets.zero, // Ensures full-screen effect
          child: dialogContent,
        );
      },
    );
  }
}
