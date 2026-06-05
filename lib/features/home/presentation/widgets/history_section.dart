
import 'package:flutter/material.dart';
import 'package:proxi/core/shared/widgets/common/app_text.dart';
import 'history_tile.dart';

class HistorySection extends StatelessWidget {

  final List<Map<String, String>> history;

  const HistorySection({super.key, required this.history});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            const AppText(
              text: 'Historique de la session',
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
            const SizedBox(width: 8),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
              decoration: BoxDecoration(
                color: Colors.deepPurple[50],
                borderRadius: BorderRadius.circular(10),
              ),
              child: AppText(
                text: '${history.length}',
                fontSize: 12,
                fontWeight: FontWeight.bold,
                color: Colors.deepPurple,
              ),
            ),
          ],
        ),
        const SizedBox(height: 10),
        ...history.map((n) => HistoryTile(notif: n)),
      ],
    );
  }
}