import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class CustomPageRoute {
  static PageRoute route(Widget page) {
    return Platform.isIOS
        ? CupertinoPageRoute(builder: (context) => page)
        : MaterialPageRoute(builder: (context) => page);
  }
}

class CustomPage {
  static Page route({required Widget page, required GoRouterState state}) {
    return Platform.isIOS
        ? CupertinoPage(
      key: state.pageKey,
      child: page,
    ) : MaterialPage(
      key: state.pageKey,
      child: page,
    );
  }
}
