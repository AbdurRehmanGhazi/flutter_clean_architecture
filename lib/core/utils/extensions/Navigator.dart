import 'package:flutter/material.dart';

extension NavigatorExtensions on NavigatorState {
  /// Pops all routes until reaching the root screen.
  void popToRoot() {
    this.popUntil((route) => route.isFirst);
  }
}

extension ContextNavigatorExtensions on BuildContext {
  /// Pops all routes until reaching the root screen using the context.
  void popToRoot() {
    Navigator.of(this).popUntil((route) => route.isFirst);
  }
}
