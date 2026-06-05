import "package:flutter/material.dart";
import "../common/app_text.dart";


class AppTextButton extends StatelessWidget {

  final String text;
  final Color? textColor;
  final double? width;
  final Color? backgroundColor;
  final VoidCallback onPress;
  final double fontSize;

  const AppTextButton({
    super.key,
    this.width,
    required this.text,
    this.textColor,
    required this.onPress,
    this.backgroundColor,
    this.fontSize = 12,
  });

  @override
  Widget build(BuildContext context) {

    final buttonStyle = TextButton.styleFrom(
      backgroundColor: backgroundColor ?? Colors.white,
      //maximumSize:  const Size(100, 50),
      //visualDensity: VisualDensity.compact,
      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
      padding: EdgeInsets.zero,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5),),
    );

    return SizedBox(
      width: width ?? 130,
      height: 40,
      child: TextButton(
        onPressed: onPress,
        style: buttonStyle,
        child: AppText(
          text: text,
          fontSize: fontSize,
          color: textColor ?? const Color(0xFF0099FF),
        ),
      ),
    );
  }
}