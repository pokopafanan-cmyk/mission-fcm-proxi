import 'package:flutter/material.dart';

import '../../../../core/shared/widgets/common/app_text.dart';
import '../../../../core/theme/app_color.dart';

class WelcomeSection extends StatelessWidget {
  final String name;
  const WelcomeSection({super.key, required this.name});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppText(
          text: "Hello $name,",
          fontSize: 22,
          fontWeight: FontWeight.bold,
          color: AppColor.blackColor,
        ),
        const SizedBox(height: 4),
        const AppText(
          text: "choisissez votre catégorie",
          fontSize: 15,
          color: Colors.grey,
        ),
      ],
    );
  }
}

