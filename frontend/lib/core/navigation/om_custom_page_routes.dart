import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class NLCustomPageRoutes {
  /// Returns a [CustomTransitionPage] that overrides the default animation behavior in flutter.
  ///
  /// For some of our navigation, we require no navigation and we can override the default
  /// animation in most flutter navigation types as thus.
  /// (https://stackoverflow.com/questions/57773077/how-to-remove-default-navigation-route-animation)
  static CustomTransitionPage withoutAnimation({
    required Widget child,
  }) {
    return CustomTransitionPage(
      child: child,
      transitionsBuilder: (_, Animation<double> animation, __, Widget child) {
        return child;
      },
    );
  }

  /// Returns a [CustomTransitionPage] that introduces a [FadeTransition] animation.
  ///
  /// For some of our navigation, we require a [FadeTransition] animation and we can
  /// achieve that thus.
  static CustomTransitionPage fadeTransition({
    required Widget child,
  }) {
    return CustomTransitionPage(
      child: child,
      transitionsBuilder: (_, Animation<double> animation, __, Widget child) {
        return FadeTransition(opacity: animation, child: child);
      },
    );
  }

  /// Returns a [CustomTransitionPage] that introduces a LTR(Left-To-Right) [SlideTransition] animation.
  ///
  /// For some of our navigation, we require a LTR [SlideTransition] animation and we can
  /// achieve that thus.
  static CustomTransitionPage ltrSlideTransition({
    required Widget child,
    RouteSettings? settings,
  }) {
    return CustomTransitionPage(
      child: child,
      transitionsBuilder: (_, Animation<double> animation, __, Widget child) {
        return SlideTransition(
          position: Tween<Offset>(
            begin: const Offset(1.0, 0.0),
            end: Offset.zero,
          ).animate(animation),
          child: child,
        );
      },
    );
  }
}
