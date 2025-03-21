import 'package:flutter/material.dart';

import '../../main.dart';

void showSnackBar(String content, [BuildContext? context]) {

  // Ensure a valid context is available
  final snackBarContext = context ?? globalNavigatorKey.currentContext;

  if (snackBarContext == null) {
    debugPrint('Error: No valid context provided for SnackBar.');
    return;
  }

  ScaffoldMessenger.of(snackBarContext)
    ..hideCurrentSnackBar()
    ..showSnackBar(
      SnackBar(
        content: Text(content),
      ),
    );
}
