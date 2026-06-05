import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AppPage {

  // Durée standard pour toutes les transitions
  // static const _duration = Duration(milliseconds: 600);
  static const _duration = Duration(milliseconds: 400);

  /// Slide transition (par défaut : de droite vers gauche)
  static CustomTransitionPage slide({
    required Widget child,
    required GoRouterState state,
    Offset begin = const Offset(1, 0),
    // Offset begin = const Offset(0, 1),
  }) {

    // Tween réutilisable avec courbe "ease"
    final tween = Tween(begin: begin, end: Offset.zero).chain(CurveTween(curve: Curves.ease));

    return CustomTransitionPage(
      key: state.pageKey,
      child: child,
      transitionDuration: _duration,
      reverseTransitionDuration: _duration,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        return SlideTransition(
          position: Tween<Offset>(
            begin: _getBeginOffset(),
            end: Offset.zero,
          ).animate(animation),
          child: child,
        );
        return SlideTransition(
          position: animation.drive(tween),
          child: child,
        );
      },
    );
  }

  /// Transition en fondu (fade in/out)
  static CustomTransitionPage fade({
    required Widget child,
    required GoRouterState state,
  }) {
    return CustomTransitionPage(
      key: state.pageKey,
      child: child,
      transitionDuration: _duration,
      reverseTransitionDuration: _duration,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        return FadeTransition(
          opacity: animation,
          child: child,
        );
      },
    );
  }

  /// Transition en zoom (scale)
  static CustomTransitionPage scale({
    required Widget child,
    required GoRouterState state,
  }) {
    return CustomTransitionPage(
      key: state.pageKey,
      child: child,
      transitionDuration: _duration,
      reverseTransitionDuration: _duration,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        return ScaleTransition(
          scale: animation,
          child: child,
        );
      },
    );
  }

  /// Retourne un Offset de départ en fonction d’une direction donnée
  static Offset _getBeginOffset({AxisDirection direction = AxisDirection.up}) {
    switch (direction) {
      case AxisDirection.up:
        return Offset(0, 1);
      case AxisDirection.down:
        return Offset(0, -1);
      case AxisDirection.right:
        return Offset(-1, 0);
      case AxisDirection.left:
        return Offset(1, 0);
    }
  }

}

