import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

class AppRoundedBtn extends StatelessWidget {


  final Widget? child;
  final IconData? icon;
  final double? btnSize;
  final double? iconSize;
  final Color? iconColor;
  final Color? backgroundColor;
  final VoidCallback? onPress;

  const AppRoundedBtn({
    super.key,
    this.child,
    this.icon,
    this.btnSize,
    this.iconColor,
    this.backgroundColor,
    this.onPress,
    this.iconSize,
  });


  static Uuid uuid = const Uuid();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: btnSize ?? 40,
      width: btnSize ?? 40,
      child: FloatingActionButton(
        elevation: 0,
        mini: true,
        heroTag: uuid.v4(),
        highlightElevation: 0.0,
        hoverColor: Colors.white,
        splashColor: Colors.white,
        foregroundColor: Colors.white,
        disabledElevation: 0.0,
        backgroundColor:  backgroundColor ?? Theme.of(context).primaryColor,
        shape: const CircleBorder(),
        onPressed: onPress,
        child: child ?? Icon(icon, color: iconColor ?? Colors.white, size: iconSize,),
      ),
    );
  }
}