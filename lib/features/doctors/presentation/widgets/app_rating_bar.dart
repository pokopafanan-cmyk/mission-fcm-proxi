import 'package:flutter/material.dart';

import '../../../../core/shared/extensions/extensions.dart';
import '../../../../core/shared/widgets/common/app_text.dart';
import '../../../../core/theme/app_color.dart';


class AppRatingBar extends StatelessWidget {
  final double rating;
  final double size;
  final bool showText;

  const AppRatingBar({
    super.key,
    required this.rating,
    this.size = 18,
    this.showText = true,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          children: List.generate(5, (index) {
            IconData icon;
            Color color;

            if (index < rating.floor()) {
              icon = Icons.star_rounded;
              color = Colors.amber;
            } else if (index < rating && rating % 1 != 0) {
              icon = Icons.star_half_rounded;
              color = Colors.amber;
            } else {
              icon = Icons.star_rounded;
              color = Colors.grey[300]!;
            }

            return Icon(
              icon,
              size: size,
              color: color,
            );
          }),
        ),
        if (showText) ...[
          SizedBox(width: 8,),
         AppText(
            text: rating.toStringAsFixed(1),
            fontSize: size * 0.75,
            fontWeight: FontWeight.bold,
            color: AppColor.blackColor,
          ),
        ],
      ],
    );
  }
}