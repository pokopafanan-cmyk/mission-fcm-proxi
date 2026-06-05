import 'package:flutter/material.dart';
import '../../../../core/shared/widgets/common/app_text.dart';

class NotificationBadge extends StatelessWidget {

  final int count;
  final Widget child;
  final Color badgeColor;

  const NotificationBadge({
    super.key,
    required this.count,
    required this.child,
    this.badgeColor = Colors.red,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        child,
        if (count > 0)
          Positioned(
            top: -6,
            right: -6,
            child: Container(
              padding: const EdgeInsets.all(4),
              decoration: BoxDecoration(
                color: badgeColor,
                shape: count > 9 ? BoxShape.rectangle : BoxShape.circle,
                borderRadius: count > 9 ? BorderRadius.circular(10) : null,
              ),
              constraints: const BoxConstraints(minWidth: 18, minHeight: 18),
              child: AppText(
                text: count > 99 ? '99+' : '$count',
                color: Colors.white,
                fontSize: 10,
                fontWeight: FontWeight.bold,
                textAlign: TextAlign.center,
              ),
            ),
          ),
      ],
    );
  }
}