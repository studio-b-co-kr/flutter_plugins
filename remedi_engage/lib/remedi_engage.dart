library remedi_engage;

import 'dart:developer' as dev;

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

class FcmManager {
  static String? fcmToken;

  static Future Function(RemoteMessage message)? onBackgroundMessage;

  static init(
      {required Future Function(RemoteMessage message) onBackgroundMessage,
      AndroidNotificationChannel? channel}) async {
    fcmToken = await FirebaseMessaging.instance.getToken();
    dev.log("$fcmToken", name: "FirebaseMessaging.token");

    FcmManager.onBackgroundMessage = onBackgroundMessage;

    if (channel != null) {
      await createAndroidNotificationChannel(channel!);
    }

    await setForegroundNotificationPresentationOptions(
        alert: true, badge: true, sound: true);
  }

  static createAndroidNotificationChannel(
          AndroidNotificationChannel channel) async =>
      await flutterLocalNotificationsPlugin
          .resolvePlatformSpecificImplementation<
              AndroidFlutterLocalNotificationsPlugin>()
          ?.createNotificationChannel(channel!);

  static requestIOSPermission() async {
    NotificationSettings settings =
        await FirebaseMessaging.instance.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );
  }

  static setForegroundNotificationPresentationOptions(
      {required bool alert, required bool badge, required bool sound}) async {
    FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
      alert: alert,
      badge: badge,
      sound: sound,
    );
  }
}

class BranchIoManager {}
