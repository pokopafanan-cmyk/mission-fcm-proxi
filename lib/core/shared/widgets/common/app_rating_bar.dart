import 'package:flutter/material.dart';

import 'app_text.dart';

class AppRatingBar extends StatelessWidget {
  final double rating;
  final double size;
  final Color filledColor;
  final Color emptyColor;

  const AppRatingBar({
    super.key,
    required this.rating,
    this.size = 18.0,
    this.filledColor = Colors.amber,
    this.emptyColor = const Color(0xFFEEEEEE),
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          children: List.generate(5, (index) {
            if (index < rating.floor()) {
              return Icon(Icons.star_rounded, color: filledColor, size: size);
            } else if (index < rating) {
              return Icon(Icons.star_half_rounded, color: filledColor, size: size);
            } else {
              return Icon(Icons.star_rounded, color: emptyColor, size: size);
            }
          }),
        ),
        const SizedBox(width: 8),
       AppText(
          text: rating.toStringAsFixed(1),
          fontWeight: FontWeight.bold,
          fontSize: 13,
          color: Colors.black87,
        ),
      ],
    );
  }
}