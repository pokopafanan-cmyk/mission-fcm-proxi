
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import 'package:proxi/main.dart';
import '../../../../features/home/presentation/screens/notify_detail_screen.dart';

class NotificationService {
  static final NotificationService _instance = NotificationService._internal();
  factory NotificationService() => _instance;
  NotificationService._internal();

  final FirebaseMessaging _messaging = FirebaseMessaging.instance;
  final FlutterLocalNotificationsPlugin _localNotif = FlutterLocalNotificationsPlugin();

  static GlobalKey<NavigatorState> get navigatorKey => notificationNavigatorKey;

  static const AndroidNotificationChannel channel = AndroidNotificationChannel(
    'high_importance_channel',
    'Notifications importantes',
    description: 'Canal utilisé pour les notifications FCM',
    importance: Importance.high,
  );

  Future<void> initialize() async {
    await _createAndroidChannel();
    await _initLocalNotifications();
    await _requestPermission();
    await _setupToken();
    _listenForeground();
    _listenBackgroundTap();
    await _checkTerminatedMessage();
  }

  Future<void> _createAndroidChannel() async {
    await _localNotif
        .resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel);
  }

  //  v21 — InitializationSettings inline, plus de variable séparée
  Future<void> _initLocalNotifications() async {
    await _localNotif.initialize(
      settings: const InitializationSettings(
        android: AndroidInitializationSettings('@mipmap/ic_launcher'),
        iOS: DarwinInitializationSettings(
          requestAlertPermission: false,
          requestBadgePermission: false,
          requestSoundPermission: false,
        ),
      ),
      onDidReceiveNotificationResponse: _onLocalNotifTapped,
    );
  }

  Future<void> _requestPermission() async {
    final settings = await _messaging.requestPermission(
      alert: true,
      badge: true,
      sound: true,
      announcement: false,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
    );
    debugPrint('[FCM] Permission : ${settings.authorizationStatus}');
  }

  Future<void> _setupToken() async {
    final token = await _messaging.getToken();
    if (token != null) {
      debugPrint('[FCM] Token : $token');
      await sendTokenToBackend(token);
    }
    _messaging.onTokenRefresh.listen((newToken) {
      debugPrint('[FCM] Token rafraîchi : $newToken');
      sendTokenToBackend(newToken);
    });
  }

  void _listenForeground() {
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      debugPrint('[FCM][FG] ${message.notification?.title}');
      _showLocalNotification(message);
    });
  }

  void _listenBackgroundTap() {
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      debugPrint('[FCM][BG tap] ${message.data}');
      _navigateToDetail(message);
    });
  }

  Future<void> _checkTerminatedMessage() async {
    final message = await _messaging.getInitialMessage();
    if (message != null) {
      debugPrint('[FCM][TERMINATED] ${message.data}');
      await Future.delayed(const Duration(seconds: 1));
      _navigateToDetail(message);
    }
  }

  //  v21 — tous les paramètres sont nommés
  Future<void> _showLocalNotification(RemoteMessage message) async {
    final notification = message.notification;
    if (notification == null) return;

    await _localNotif.show(
      id: message.hashCode,
      title: notification.title,
      body: notification.body,
      notificationDetails: const NotificationDetails(
        android: AndroidNotificationDetails(
          'high_importance_channel',
          'Notifications importantes',
          channelDescription: 'Canal utilisé pour les notifications FCM',
          importance: Importance.high,
          priority: Priority.high,
          icon: '@mipmap/ic_launcher',
        ),
        iOS: DarwinNotificationDetails(
          presentAlert: true,
          presentBadge: true,
          presentSound: true,
        ),
      ),
      payload: message.data.toString(),
    );
  }

  void _navigateToDetail(RemoteMessage message) {
    navigatorKey.currentState?.push(
      MaterialPageRoute(
        builder: (_) => NotifyDetailScreen(message: message),
      ),
    );
  }

  void _onLocalNotifTapped(NotificationResponse response) {
    debugPrint('[FCM] Notification locale tappée : ${response.payload}');
  }

  Future<void> sendTokenToBackend(String token) async {
    debugPrint('[FCM] Token prêt pour backend : $token');
  }
}