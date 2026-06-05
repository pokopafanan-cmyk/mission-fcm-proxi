import 'package:flutter/material.dart';
import '../../../theme/app_color.dart';
import 'app_text.dart';

class ScreenTitle extends StatelessWidget {

  final String title;
  final String subtitle;

  const ScreenTitle({super.key, required this.title, required this.subtitle});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 25),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          AppText(
            text: title,
            fontSize: 16,
            textAlign: TextAlign.center,
            color: AppColor.blackColor,
            fontWeight: FontWeight.bold,
          ),
          AppText(
            text: subtitle,
            fontSize: 14,
            textAlign: TextAlign.center,
            color: AppColor.greyColor,
          ),
        ],
      ),
    );
  }
}


