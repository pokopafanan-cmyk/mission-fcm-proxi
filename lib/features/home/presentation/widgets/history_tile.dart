
import 'package:flutter/material.dart';
import 'package:proxi/core/shared/widgets/common/app_text.dart';

class HistoryTile extends StatelessWidget {

  final Map<String, String> notif;

  const HistoryTile({super.key, required this.notif});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey[100]!),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.02),
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 20,
            backgroundColor: Colors.deepPurple[50],
            child: const Icon(
              Icons.notifications_rounded,
              color: Colors.deepPurple,
              size: 18,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppText(
                  text: notif['title'] ?? '',
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                ),
                if ((notif['body'] ?? '').isNotEmpty) ...[
                  const SizedBox(height: 2),
                  AppText(
                    text: notif['body']!,
                    fontSize: 12,
                    color: Colors.grey,
                    maxLines: 1,
                  ),
                ],
              ],
            ),
          ),
          const SizedBox(width: 8),
          AppText(
            text: notif['time'] ?? '',
            fontSize: 11,
            color: Colors.grey,
          ),
        ],
      ),
    );
  }
}