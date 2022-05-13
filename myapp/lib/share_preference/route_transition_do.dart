import 'package:flutter/material.dart';

enum AnimationType {
  normal,
  fadeIn,
}
class RouteTransitionDo {
  final BuildContext context;
  final AnimationType animationType;
  final Widget child;
  final bool replacement;
  final Duration duration;

  RouteTransitionDo({
    required this.context,
    required this.child,
    this.replacement = false,
    this.animationType = AnimationType.normal,
    this.duration = const Duration(milliseconds: 300),
  }) {
    switch (this.animationType) {
      case AnimationType.normal:
        _normalTransition();
        break;

      case AnimationType.fadeIn:
        _fadeInTransition();
        break;
    }
  }

  void _pushPage(Route route) => Navigator.push(context, route);

  void _pushReplacement(Route route) =>
      Navigator.pushReplacement(context, route);

  void _normalTransition() =>
      Navigator.push(context, MaterialPageRoute(builder: (_) => this.child));

  void _fadeInTransition() {
    final route = PageRouteBuilder(
        pageBuilder: (_, __, ___) => child,
        transitionDuration: this.duration,
        transitionsBuilder: (context, animation, _, child) {
          return FadeTransition(
              child: child,
              opacity: Tween<double>(begin: 0.0, end: 1.0).animate(
                  CurvedAnimation(parent: animation, curve: Curves.easeOut)));
        });

    (this.replacement) ? this._pushReplacement(route) : this._pushPage(route);
  }
}
