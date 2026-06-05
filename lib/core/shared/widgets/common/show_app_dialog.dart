import "package:flutter/material.dart";
import 'dart:math' as math;


/// Constant factor to convert and angle from degrees to radians.
const double degrees2Radians = math.pi / 180.0;

/// Constant factor to convert and angle from radians to degrees.
const double radians2Degrees = 180.0 / math.pi;


/// Convert [radians] to degrees.
double degrees(double radians) => radians * radians2Degrees;

/// Convert [degrees] to radians.
double radians(double degrees) => degrees * degrees2Radians;


/// show Custom Dialog With Scale Transition
Future<T?> showAppDialog<T extends Object?>({
  required BuildContext context,
  required Widget child,
  bool barrierDismissible = false,
  bool useRootNavigator = false,
  bool barrierColor = true,
  bool canPop = false,
  AxisDirection? direction,
}) async {

  return await showGeneralDialog(
    context: context,
    useRootNavigator: useRootNavigator,
    barrierDismissible: barrierDismissible,
    barrierLabel: barrierDismissible ? "Show Custom Dialog" : null,
    barrierColor: barrierColor ? Colors.black.withValues(alpha: 0.5) : const Color(0x80000000),
    transitionDuration: Duration(milliseconds: 600),
    transitionBuilder: (BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation, Widget widget) {
      if (direction != null) {
        return PopScope(
          canPop: canPop,
          child: SlideTransition(
            position: Tween<Offset>(
              begin: getBeginOffset(direction),
              end: Offset.zero,
            ).animate(animation),
            child: child,
          ),
        );
      }
      return PopScope(
        canPop: canPop,
        child: ScaleTransition(
          scale: Tween<double>(begin: 0.5, end: 1.0).animate(animation),
          child: FadeTransition(
            opacity: Tween<double>(begin: 0.5, end: 1.0).animate(animation),
            child: child,
          ),
        ),
      );
    },
    pageBuilder: (BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation) {
      return Container();
    },
  );
}


/// show Custom Dialog With Slide Transition
Future<T?> showAppDialogLock<T extends Object?>({
  required BuildContext context,
  required Widget child,
  bool barrierDismissible = false,
  AxisDirection direction = AxisDirection.up,
}) async {

  return await showGeneralDialog(
    context: context,
    // useRootNavigator: false,
    barrierDismissible: barrierDismissible,
    barrierLabel: barrierDismissible ? "Show Custom Dialog" : null,
    barrierColor: Colors.black.withValues(alpha: 0.5),
    transitionDuration: Duration(milliseconds: 400),
    transitionBuilder: (BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation, Widget widget) {
      return SlideTransition(
        position: Tween<Offset>(
          begin: getBeginOffset(direction),
          end: Offset.zero,
        ).animate(animation),
        child: child,
      );
    },
    pageBuilder: (BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation) {
      return Container();
    },
  );
}


/// show Custom Dialog With Transform Rotate
Future<T?> showAppDialogTransformRotate<T extends Object?>({
  required BuildContext context,
  required Widget child,
  bool barrierDismissible = false,
}) async {

  return await showGeneralDialog(
    context: context,
    // useRootNavigator: false,
    barrierDismissible: barrierDismissible,
    barrierLabel: barrierDismissible ? "Show Custom Dialog" : null,
    barrierColor: Colors.black.withValues(alpha: 0.5),
    transitionDuration: Duration(milliseconds: 400),
    transitionBuilder: (BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation, Widget widget) {
      return Transform.rotate(
        angle: radians(animation.value * 360),
        child: child,
      );
    },
    pageBuilder: (BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation) {
      return Container();
    },
  );
}


/// show Custom Dialog With Transform Rotate and opacity
Future<T?> showAppDialogTransformRotateOpacity<T extends Object?>({
  required BuildContext context,
  required Widget child,
  bool barrierDismissible = false,
}) async {

  return await showGeneralDialog(
    context: context,
    // useRootNavigator: false,
    barrierDismissible: barrierDismissible,
    barrierLabel: barrierDismissible ? "Show Custom Dialog" : null,
    barrierColor: Colors.black.withValues(alpha: 0.5),
    transitionDuration: Duration(milliseconds: 400),
    transitionBuilder: (BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation, Widget widget) {
      return Transform.rotate(
        angle: radians(animation.value * 360),
        child: Opacity(
          opacity: animation.value,
          child: child,
        ),
      );
    },
    pageBuilder: (BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation) {
      return Container();
    },
  );
}


/// show Custom Dialog With CurvesEaseInOutBack
Future<T?> showAppDialogCurvesEaseInOutBack<T extends Object?>({
  required BuildContext context,
  required Widget child,
  bool barrierDismissible = false,
}) async {

  return await showGeneralDialog(
    context: context,
    // useRootNavigator: false,
    barrierDismissible: barrierDismissible,
    barrierLabel: barrierDismissible ? "Show Custom Dialog" : null,
    barrierColor: Colors.black.withValues(alpha: 0.5),
    transitionDuration: Duration(milliseconds: 400),
    transitionBuilder: (BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation, Widget widget) {
      final curvedValue = Curves.easeInOutBack.transform(animation.value) - 1.0;
      return Transform(
        transform: Matrix4.translationValues(0.0, curvedValue * 200, 0.0),
        child: Opacity(
          opacity: animation.value,
          child: child,
        ),
      );
    },
    pageBuilder: (BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation) {
      return Container();
    },
  );
}


/// show Custom Dialog With Transform scale
Future<T?> showAppDialogTransformScale<T extends Object?>({
  required BuildContext context,
  required Widget child,
  bool barrierDismissible = false,
}) async {

  return await showGeneralDialog(
    context: context,
    // useRootNavigator: false,
    barrierDismissible: barrierDismissible,
    barrierLabel: barrierDismissible ? "Show Custom Dialog" : null,
    barrierColor: Colors.black.withValues(alpha: 0.5),
    transitionDuration: Duration(milliseconds: 400),
    transitionBuilder: (BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation, Widget widget) {
      return Transform.scale(
        scale: animation.value,
        child: Opacity(
          opacity: animation.value,
          child: child,
        ),
      );
    },
    pageBuilder: (BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation) {
      return Container();
    },
  );
}


/// Get begin offset based on direction
Offset getBeginOffset(AxisDirection direction) {
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

