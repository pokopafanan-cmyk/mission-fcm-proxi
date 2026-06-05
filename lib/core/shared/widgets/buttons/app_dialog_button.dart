import 'package:flutter/material.dart';
import '../../../theme/app_color.dart';
import '../../../theme/app_theme.dart';
import '../common/app_text.dart';


class AppDialogButton extends StatelessWidget {

  final String text;
  final bool enabled;
  final VoidCallback onTap;
  final Color backgroundColor;


  const AppDialogButton({
    super.key,
    required this.text,
    this.enabled = false,
    required this.onTap,
    this.backgroundColor = AppColor.primaryColor,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      borderRadius: BorderRadius.circular(8),
      color: enabled ? backgroundColor : backgroundColor.withValues(alpha: 0.3),
      child: Ink(
        height: 35,
        width: MediaQuery.sizeOf(context).width * 0.35,
        decoration: BoxDecoration(
          color: enabled ? backgroundColor : backgroundColor.withValues(alpha: 0.3),
          borderRadius: BorderRadius.circular(8),
        ),
        child: InkWell(
          onTap: enabled ? onTap : null,
          borderRadius: BorderRadius.circular(8),
          child: Center(
            child: AppText(
              color: Colors.white,
              fontSize: 14,
              text: text,
            ),
          ),
        ),
      ),
    );
  }
}



