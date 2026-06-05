import "package:flutter/material.dart";

class AppText extends StatelessWidget {

  final String text;
  final bool ellipsis;
  final double fontSize;
  final double? height;
  final FontStyle? fontStyle;
  final FontWeight fontWeight;
  final TextAlign textAlign;
  final TextDecoration decoration;
  final double? letterSpacing;
  final Color? decorationColor;
  final int? maxLines;
  final Color? color;

  const AppText({
    super.key,
    required this.text,
    this.ellipsis = false,
    this.color,
    this.fontSize = 14,
    this.height,
    this.fontWeight = FontWeight.normal,
    this.fontStyle = FontStyle.normal,
    this.textAlign = TextAlign.start,
    this.decoration = TextDecoration.none,
    this.letterSpacing,
    this.decorationColor,
    this.maxLines,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: textAlign,
      maxLines: ellipsis ? (maxLines ?? 1) : null,
      style: TextStyle(
        color: color ?? const Color.fromRGBO(128, 128, 128, 1),
        fontSize: fontSize,
        fontWeight: fontWeight,
        fontStyle: fontStyle,
        height: height,
        decoration: decoration,
        letterSpacing: letterSpacing,
        decorationColor: decorationColor,
        overflow: ellipsis ? TextOverflow.ellipsis : null,
      ),
    );
  }
}