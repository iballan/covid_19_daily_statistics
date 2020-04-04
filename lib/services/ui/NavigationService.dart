import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class NavigationService {
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  bool pop() {
    return navigatorKey.currentState.pop();
  }

  void pushReplacement(Widget page) {
    navigatorKey.currentState
        .pushReplacement(MaterialPageRoute(builder: (context) => page));
  }

  void push(Widget page) {
    navigatorKey.currentState
        .push(MaterialPageRoute(builder: (context) => page));
  }

  void pushRoute<T extends Object>(Route<T> route) {
    navigatorKey.currentState
        .push(route);
  }

  void present(Widget page, {bool isOpaque = true, bool fullscreenDialog = true}) {
    if (!isOpaque) {
      navigatorKey.currentState.push(
        PageRouteBuilder(
          opaque: isOpaque,
          fullscreenDialog: fullscreenDialog,
          pageBuilder: (_, __, ___) => page
        )
      );
    } else {
      navigatorKey.currentState.push(
          MaterialPageRoute(
              builder: (context) => page, fullscreenDialog: fullscreenDialog));
    }
  }
}
