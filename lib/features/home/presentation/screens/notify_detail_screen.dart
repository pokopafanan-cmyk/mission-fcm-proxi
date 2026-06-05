
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../../core/shared/widgets/common/app_text.dart';

class NotifyDetailScreen extends StatelessWidget {

  final RemoteMessage message;

  const NotifyDetailScreen({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    final notif = message.notification;
    final data = message.data;

    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        title: const AppText(
          text: 'Détail de la Notification',
          fontSize: 18,
          fontWeight: FontWeight.w600,
          color: Colors.white,
        ),
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Colors.deepPurple, Colors.purpleAccent],
                ),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Icon(
                    Icons.notifications_active,
                    color: Colors.white,
                    size: 36,
                  ),
                  const SizedBox(height: 12),
                  AppText(
                    text: notif?.title ?? 'Sans titre',
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                  if (notif?.body != null) ...[
                    const SizedBox(height: 6),
                    AppText(
                      text: notif!.body!,
                      color: Colors.white70,
                      fontSize: 14,
                    ),
                  ],
                ],
              ),
            ),
            const SizedBox(height: 24),

             AppText(
              text: 'Informations Techniques',
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
            const SizedBox(height: 12),
            _buildInfoRow('Message ID', message.messageId ?? 'N/A'),
            _buildInfoRow('Envoyé par', message.senderId ?? 'Firebase Console'),
            _buildInfoRow('Date Envoyée', message.sentTime?.toString() ?? 'Inconnue'),
            const SizedBox(height: 24),

            // Bloc Données personnalisées (Data Payload) ──
            if (data.isNotEmpty) ...[
              const AppText(
                text: 'Données personnalisées (Data Payload)',
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
              const SizedBox(height: 10),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: Colors.grey[100],
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Colors.grey[300]!),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: data.entries.map((e) {
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 6),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          AppText(
                            text: "${e.key}: ",
                            fontWeight: FontWeight.bold,
                            color: Colors.deepPurple,
                          ),
                          Expanded(
                            child: AppText(
                              text: e.value.toString(),
                              color: Colors.black87,
                            ),
                          ),
                        ],
                      ),
                    );
                  }).toList(),
                ),
              ),
              const SizedBox(height: 12),
              OutlinedButton.icon(
                onPressed: () {
                  Clipboard.setData(ClipboardData(text: data.toString()));
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Données data copiées !'),
                      backgroundColor: Colors.deepPurple,
                    ),
                  );
                },
                icon: const Icon(Icons.copy, size: 16),
                label: const Text('Copier les métadonnées data'),
                style: OutlinedButton.styleFrom(
                  foregroundColor: Colors.deepPurple,
                  side: const BorderSide(color: Colors.deepPurple),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Row(
        children: [
          SizedBox(
            width: 100,
            child: AppText(
              text: label,
              color: Colors.grey,
              fontSize: 13,
            ),
          ),
          Expanded(
            child: AppText(
              text: value,
              fontWeight: FontWeight.w500,
              fontSize: 13,
              color: Colors.black87,
            ),
          ),
        ],
      ),
    );
  }
}