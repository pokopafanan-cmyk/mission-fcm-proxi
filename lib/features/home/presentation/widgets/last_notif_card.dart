
import 'package:flutter/material.dart';
import 'package:proxi/core/shared/widgets/common/app_text.dart';

class LastNotifCard extends StatelessWidget {

  final String message;
  final int count;

  const LastNotifCard({
    super.key,
    required this.message,
    required this.count,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Colors.deepPurple[50],
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Icon(
              Icons.notifications_rounded,
              color: Colors.deepPurple,
              size: 22,
            ),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const AppText(
                  text: 'Dernière notification',
                  fontSize: 11,
                  color: Colors.grey,
                ),
                AppText(
                  text: message,
                  fontWeight: FontWeight.w600,
                  fontSize: 24,
                ),
              ],
            ),
          ),
          if (count > 0)
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: Colors.deepPurple,
                borderRadius: BorderRadius.circular(20),
              ),
              child: AppText(
                text: '$count',
                fontSize: 13,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
        ],
      ),
    );
  }
}