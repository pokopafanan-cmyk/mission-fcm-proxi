import 'package:flutter/material.dart';
import '../common/app_text.dart';

class AppBtnValidate extends StatelessWidget {

  final String label;
  final bool enabled;
  final String? imgPath;
  final Color? backgroundColor;
  final Color textColor;
  final double? width;
  final double paddingTop;
  final VoidCallback onPress;
  final double height;

  final Border? border;

  const AppBtnValidate({
    super.key,
    required this.label,
    this.imgPath,
    this.backgroundColor,
    this.paddingTop = 15,
    this.width,
    this.enabled = false,
    required this.onPress,
    this.textColor = Colors.white,
    this.height = 50,
    this.border
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: paddingTop),
      child: Material(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(10.0),
        child: InkWell(
          onTap: enabled ? onPress : null,
          borderRadius: BorderRadius.circular(10.0),
          child: Ink(
            height: height,
            padding: const EdgeInsets.all(10),
            width: double.infinity,
            decoration: BoxDecoration(
              color: backgroundColor?.withValues(alpha: enabled ? 1 : 0.3) ?? Theme.of(context).primaryColor.withValues(alpha: enabled ? 1 : 0.3),
              borderRadius: BorderRadius.circular(10.0),
              border: border,
            ),
            child: imgPath != null ? Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const SizedBox(),
                AppText(
                  text: label,
                  color: Colors.white,
                ),
                SizedBox(
                  height: 20,
                  width: 20,
                  child: Image.asset(imgPath!),
                ),
              ],
            ) :
            Center(
              child: AppText(
                textAlign: TextAlign.center,
                text: label,
                color: textColor,
              ),
            ),
          ),
        ),
      ),
    );
  }
}





class AppSelectBtnIcon extends StatelessWidget {

  final String label;
  final bool enabled;
  final Color? backgroundColor;
  final Color textColor;
  final double? width;
  final double paddingTop;
  final VoidCallback onPress;
  final double height;
  final Border? border;

  const AppSelectBtnIcon({
    super.key,
    required this.label,
    this.backgroundColor = const Color(0xFFECEBEB),
    this.paddingTop = 15,
    this.width,
    this.enabled = true,
    required this.onPress,
    this.textColor = const Color(0xFF0973B6),
    this.height = 50,
    this.border
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: paddingTop),
      child: Material(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(10.0),
        child: InkWell(
          onTap: enabled ? onPress : null,
          borderRadius: BorderRadius.circular(10.0),
          child: Ink(
            height: height,
            padding: const EdgeInsets.all(10),
            width: double.infinity,
            decoration: BoxDecoration(
              color: backgroundColor?.withValues(alpha: enabled ? 1 : 0.3) ?? Theme.of(context).primaryColor.withValues(alpha: enabled ? 1 : 0.3),
              borderRadius: BorderRadius.circular(10.0),
              border: Border.all(
                color: const Color(0xFF0973B6),
                width: 1.5,
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                AppText(
                  text: label,
                  color: textColor,
                  textAlign: TextAlign.center,
                ),
                Icon(
                  Icons.arrow_forward_ios,
                  color: textColor,
                  size: 20,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
