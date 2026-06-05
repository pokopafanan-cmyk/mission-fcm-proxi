import 'package:flutter/material.dart';
import '../../../theme/app_color.dart';
import '../../../theme/app_theme.dart';
import '../common/app_text.dart';

class AppActionButton extends StatelessWidget {

  final String title;
  final IconData icon;
  final VoidCallback onTap;
  final double paddingBottom;

  const AppActionButton({
    super.key,
    required this.title,
    required this.icon,
    required this.onTap,
    this.paddingBottom = 20,
  });

  @override
  Widget build(BuildContext context) {
    final borderRadius = BorderRadius.circular(30.0);
    return Padding(
      padding: EdgeInsets.only(bottom: paddingBottom),
      child: Material(
        color: AppColor.tertiaryColor,
        borderRadius: borderRadius,
        child: InkWell(
          borderRadius: borderRadius,
          onTap: onTap,
          child: Ink(
            padding: EdgeInsets.only(top: 10, bottom: 10, left: 15, right: 15),
            decoration: BoxDecoration(
              borderRadius: borderRadius,
              color: AppColor.tertiaryColor,
              border: Border.all(
                color: AppColor.secondaryColor,
                width: 0.7,
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(icon, color: AppColor.secondaryColor, size: 25,),
                const SizedBox(width: 15),
                AppText(
                  text: title,
                  fontSize: 14,
                  color: AppColor.primaryColor,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}