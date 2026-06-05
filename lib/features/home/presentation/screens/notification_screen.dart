import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../../core/shared/widgets/common/app_text.dart';
import '../widgets/history_section.dart';
import '../widgets/last_notif_card.dart';
import '../widgets/permission_card.dart';
import '../widgets/token_card.dart';
import 'notify_detail_screen.dart';

class NotificationScreen extends StatefulWidget {

  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  String _token = 'Chargement...';
  String _lastMessage = 'Aucune notification reçue';
  int _notifCount = 0;
  bool _permissionGranted = false;
  bool _isLoading = true;
  final List<Map<String, String>> _history = [];

  @override
  void initState() {
    super.initState();
    _initFirebaseMessaging();
  }

  /// Initialisation et configuration des écouteurs FCM
  Future<void> _initFirebaseMessaging() async {
    try {
      final token = await FirebaseMessaging.instance.getToken();
      final settings = await FirebaseMessaging.instance.getNotificationSettings();

      if (mounted) {
        setState(() {
          _token = token ?? 'Token indisponible';
          _permissionGranted = settings.authorizationStatus == AuthorizationStatus.authorized;
          _isLoading = false;
        });
      }

      // 1. État Foreground (Application ouverte au premier plan)
      FirebaseMessaging.onMessage.listen((RemoteMessage message) {
        if (!mounted) return;
        setState(() {
          _notifCount++;
          _lastMessage = message.notification?.title ?? 'Sans titre';
          _history.insert(0, {
            'title': message.notification?.title ?? 'Sans titre',
            'body': message.notification?.body ?? '',
            'time': _formattedTime(),
          });
        });
      });

      // 2. État Background (Application en arrière-plan - clic sur la notification)
      FirebaseMessaging.onMessageOpenedApp.listen(_navigateToDetails);

      // 3. État Terminated (Application totalement fermée - démarrage à froid)
      final initialMessage = await FirebaseMessaging.instance.getInitialMessage();
      if (initialMessage != null) {
        _navigateToDetails(initialMessage);
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _token = 'Erreur lors de la récupération';
          _isLoading = false;
        });
      }
    }
  }

  /// Formatage de l'heure pour l'historique local
  String _formattedTime() {
    final now = DateTime.now();
    final minutes = now.minute.toString().padLeft(2, '0');
    return '${now.hour}:$minutes';
  }

  /// Gestion de la navigation sécurisée vers l'écran des détails
  void _navigateToDetails(RemoteMessage message) {
    if (!mounted) return;
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => NotifyDetailScreen(message: message),
      ),
    );
  }

  /// Action de copie du token avec retour utilisateur (SnackBar)
  void _copyToken() {
    Clipboard.setData(ClipboardData(text: _token));
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: AppText(text: 'Token copié dans le presse-papier'),
        backgroundColor: Colors.deepPurple,
        duration: Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF6F6FB),
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,
        elevation: 0,
        title: const AppText(
          text: 'FCM — Notifications',
          fontSize: 18,
          fontWeight: FontWeight.w600,
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 8),
            child: Stack(
              alignment: Alignment.center,
              children: [
                IconButton(
                  icon: const Icon(Icons.notifications_outlined),
                  onPressed: () {},
                ),
                if (_notifCount > 0)
                  Positioned(
                    top: 8,
                    right: 8,
                    child: Container(
                      padding: const EdgeInsets.all(4),
                      decoration: const BoxDecoration(
                        color: Colors.red,
                        shape: BoxShape.circle,
                      ),
                      constraints: const BoxConstraints(
                        minWidth: 18,
                        minHeight: 18,
                      ),
                      child: AppText(
                        text: _notifCount > 99 ? '99+' : '$_notifCount',
                        fontSize: 10,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
      body: _isLoading
          ? const Center(
        child: CircularProgressIndicator(color: Colors.deepPurple),
      )
          : SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            PermissionCard(granted: _permissionGranted),
            const SizedBox(height: 10),
            TokenCard(token: _token, onCopy: _copyToken),
            const SizedBox(height: 10),
            LastNotifCard(message: _lastMessage, count: _notifCount),
            const SizedBox(height: 16),
            if (_history.isNotEmpty) HistorySection(history: _history),
          ],
        ),
      ),
    );
  }
}