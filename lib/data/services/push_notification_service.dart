import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:toeic/data/services/api/api_clients/device_token_api_client.dart';

class PushNotificationService {
  final FirebaseMessaging _messaging = FirebaseMessaging.instance;
  final FlutterLocalNotificationsPlugin _localNotifications = FlutterLocalNotificationsPlugin();

  Future<void> initialize() async {
    // Bắt buộc phải khởi tạo Firebase nếu chưa
    await Firebase.initializeApp();

    // Yêu cầu quyền thông báo
    await _messaging.requestPermission(
      alert: true,
      badge: true,
      sound: true,
    );

    // Khởi tạo local notifications
    const AndroidInitializationSettings androidInitSettings =
    AndroidInitializationSettings('@mipmap/ic_launcher');
    const InitializationSettings initSettings = InitializationSettings(
      android: androidInitSettings,
    );
    await _localNotifications.initialize(initSettings);

    // Nhận token
    String? token = await _messaging.getToken();
    if (token != null) {
      await _updateDeviceToken(token);
    }

    // Lắng nghe token thay đổi
    _messaging.onTokenRefresh.listen(_updateDeviceToken);

    // Xử lý khi đang foreground
    FirebaseMessaging.onMessage.listen(_handleForegroundMessage);

    // Xử lý khi background
    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

    await _requestNotificationPermission();
  }

  Future<void> _updateDeviceToken(String token) async {
    // TODO: Gửi token lên server của bạn
    debugPrint('Device Token: $token');
    DeviceTokenApiClient().setDeviceToken(token);
  }

  void _handleForegroundMessage(RemoteMessage message) {
    RemoteNotification? notification = message.notification;
    AndroidNotification? android = message.notification?.android;

    if (notification != null && android != null) {
      _localNotifications.show(
        notification.hashCode,
        notification.title,
        notification.body,
        NotificationDetails(
          android: AndroidNotificationDetails(
            'default_channel',
            'Thông báo chung',
            channelDescription: 'Kênh thông báo mặc định',
            importance: Importance.max,
            priority: Priority.high,
            icon: '@mipmap/ic_launcher',
          ),
        ),
      );
    }
  }
}

// Xử lý khi app đang tắt hoặc chạy nền
@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  // TODO: Xử lý message background nếu cần
  debugPrint("Received background message: ${message.messageId}");
}

Future<void> _requestNotificationPermission() async {
  if (await Permission.notification.isDenied) {
    await Permission.notification.request();
  }
}
