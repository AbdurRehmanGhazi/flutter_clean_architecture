import 'package:flutter/material.dart';

class SnackBarObserver extends NavigatorObserver {
  void didChangeNext(Route<dynamic>? nextRoute) {
    _hideSnackBar();
  }

  @override
  void didPush(Route route, Route? previousRoute) {
    _hideSnackBar();
  }

  @override
  void didPop(Route route, Route? previousRoute) {
    _hideSnackBar();
  }

  void _hideSnackBar() {
    if (navigator?.context != null) {
      ScaffoldMessenger.of(navigator!.context).hideCurrentSnackBar();
    }
  }
}
