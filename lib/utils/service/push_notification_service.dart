import 'dart:async';
import 'dart:convert';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';

import 'log_service.dart';

class PushNotificationService extends GetxService {
  StreamSubscription? onMessageListener;
  StreamSubscription? onMessageOpenedAppListener;

  final _localNotification = FlutterLocalNotificationsPlugin();
  final _firebaseMessaging = FirebaseMessaging.instance;

  Future<String?> get fcmToken {
    return _firebaseMessaging.getToken();
  }

  void listenNotification() async {
    await _firebaseMessaging.requestPermission(badge: false);
    _configLocalNotification();

    onMessageListener = FirebaseMessaging.onMessage.listen(_handleNotificationOnForeground);
    onMessageOpenedAppListener = FirebaseMessaging.onMessageOpenedApp.listen(_handleNotificationOnBackground);
  }

  void cancelNotification() {
    onMessageListener?.cancel();
    onMessageOpenedAppListener?.cancel();
  }

  void handleNotificationOnTerminal() {
    _firebaseMessaging.getInitialMessage().then((message) {});
  }

  void _configLocalNotification() async {
    const initializationSettingsAndroid = AndroidInitializationSettings('app_icon');
    const initializationSettingsIOS = IOSInitializationSettings();

    const initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: initializationSettingsIOS,
    );

    await _localNotification.initialize(
      initializationSettings,
      onSelectNotification: _handleLocalNotification,
    );
  }

  Future<void> _showLocalNotification({
    required String title,
    required String body,
    required String payload,
  }) async {
    const androidPlatformChannelSpecifics = AndroidNotificationDetails(
      'fcm_default_channel_id',
      'fcm_default_channel_name',
      channelDescription: 'fcm_default_channel_description',
    );
    const iOSPlatformChannelSpecifics = IOSNotificationDetails();
    const platformChannelSpecifics = NotificationDetails(
      android: androidPlatformChannelSpecifics,
      iOS: iOSPlatformChannelSpecifics,
    );
    await _localNotification.show(
      0,
      title,
      body,
      platformChannelSpecifics,
      payload: payload,
    );
  }

  void _handleNotificationOnBackground(RemoteMessage message) {
    L.debug('Got a message in the background!');
    L.debug('Message data: ${message.data}');
  }

  void _handleNotificationOnForeground(RemoteMessage message) {
    L.debug('Got a message whilst in the foreground!');
    L.debug('Message data: ${message.data}');

    if (message.notification != null) {
      _showLocalNotification(
        title: message.notification?.title ?? '',
        body: message.notification?.body ?? '',
        payload: json.encode(message.data),
      );
    }
  }

  Future<void> _handleLocalNotification(String? payload) async {
    if (payload != null) {
      final data = json.decode(payload);
      L.debug('onTapMessage: $data');
    }
  }
}
