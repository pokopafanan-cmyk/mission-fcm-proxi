
import 'package:flutter/material.dart';
import 'package:proxi/core/shared/widgets/buttons/app_action_button.dart';
import 'package:proxi/core/shared/widgets/common/app_text.dart';

class TokenCard extends StatelessWidget {
  final String token;
  final VoidCallback onCopy;

  const TokenCard({super.key, required this.token, required this.onCopy});

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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.deepPurple[50],
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Icon(
                  Icons.key_rounded,
                  color: Colors.deepPurple,
                  size: 18,
                ),
              ),
              const SizedBox(width: 10),
              const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppText(
                    text: 'Token fcm',
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
                  AppText(
                    text: 'Identifiant unique de cet appareil',
                    fontSize: 11,
                    color: Colors.grey,
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 12),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: const Color(0xFFF6F6FB),
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: Colors.grey[200]!),
            ),
            child: SelectableText(
              token,
              style: const TextStyle(
                fontFamily: 'monospace',
                fontSize: 11,
                color: Colors.black54,
                height: 1.5,
              ),
            ),
          ),
          const SizedBox(height: 12),
          SizedBox(
            width: double.infinity,
            child: AppActionButton(
              title: 'Copier le token',
              icon: Icons.copy_outlined,
              onTap: onCopy,
            ),
          ),
        ],
      ),
    );
  }
}