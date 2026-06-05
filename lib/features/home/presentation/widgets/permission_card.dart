
import 'package:flutter/material.dart';
import 'package:proxi/core/shared/widgets/common/app_text.dart';

class PermissionCard extends StatelessWidget {

  final bool granted;

  const PermissionCard({super.key, required this.granted});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      decoration: BoxDecoration(
        color: granted ? Colors.green[50] : Colors.red[50],
        borderRadius: BorderRadius.circular(14),
        border: Border.all(
          color: granted ? Colors.green[200]! : Colors.red[200]!,
        ),
      ),
      child: Row(
        children: [
          Icon(
            granted ? Icons.check_circle_rounded : Icons.error_outline_rounded,
            color: granted ? Colors.green[700] : Colors.red[700],
            size: 22,
          ),
          const SizedBox(width: 12),
          AppText(
            text: granted ? 'Notifications autorisées' : 'Permission refusée',
            fontWeight: FontWeight.w600,
            fontSize: 14,
            color: granted ? Colors.green[800] : Colors.red[800],
          ),
          const Spacer(),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            decoration: BoxDecoration(
              color: granted ? Colors.green[100] : Colors.red[100],
              borderRadius: BorderRadius.circular(20),
            ),
            child: AppText(
              text: granted ? 'Actif' : 'Inactif',
              fontSize: 11,
              fontWeight: FontWeight.bold,
              color: granted ? Colors.green[800] : Colors.red[800],
            ),
          ),
        ],
      ),
    );
  }
}