
import 'package:flutter/material.dart';
import '../../../../core/shared/widgets/common/app_text.dart';
import '../../../../core/theme/app_color.dart';

class SectionHeader extends StatelessWidget {
  final String title;
  final VoidCallback? onActionTap;

  const SectionHeader({
    super.key,
    required this.title,
    this.onActionTap,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        AppText(
          text: title,
          fontSize: 16,
          fontWeight: FontWeight.bold,
          color: AppColor.blackColor,
        ),
        if (onActionTap != null)
          GestureDetector(
            onTap: onActionTap,
            child: const AppText(
              text: "Voir tout",
              fontSize: 13,
              color: AppColor.primaryColor,
              fontWeight: FontWeight.w500,
            ),
          ),
      ],
    );
  }
}