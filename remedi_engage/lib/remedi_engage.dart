library remedi_engage;

import 'dart:developer' as dev;

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

final FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

class FcmManager {
  static String? fcmToken;

  static Future Function(RemoteMessage message)? onBackgroundMessage;

  static init(
      {required Future Function(RemoteMessage message) onBackgroundMessage,
      required List<AndroidNotificationChannelWrapper> channels}) async {
    fcmToken = await FirebaseMessaging.instance.getToken();
    dev.log("$fcmToken", name: "FirebaseMessaging.token");

    FcmManager.onBackgroundMessage = onBackgroundMessage;

    await Future.forEach<AndroidNotificationChannelWrapper>(channels,
        (channel) async {
      await _flutterLocalNotificationsPlugin
          .resolvePlatformSpecificImplementation<
              AndroidFlutterLocalNotificationsPlugin>()
          ?.createNotificationChannel(channel.channel);
    });

    await FirebaseMessaging.instance
        .setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );
  }

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

  static handleInitialMessage(
      {required Function(RemoteMessage message)? handler}) {
    FirebaseMessaging.instance
        .getInitialMessage()
        .then((RemoteMessage? message) {
      if (message != null && handler != null) {
        handler(message);
      }
    });
  }

  static handleOnMessage(
      {required List<AndroidNotificationChannelWrapper> channels}) {
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      RemoteNotification? notification = message.notification;
      AndroidNotification? android = message.notification?.android;
      if (notification != null && android != null) {
        channels.forEach((AndroidNotificationChannelWrapper channel) {
          if (channel.channel.id == android.channelId) {
            _flutterLocalNotificationsPlugin.show(
                notification.hashCode,
                notification.title,
                notification.body,
                NotificationDetails(
                  android: AndroidNotificationDetails(
                    channel.id,
                    channel.name,
                    channel.description,
                    icon: channel.icon,
                  ),
                ));
          }
        });
      }
    });
  }

  static handleOnMessageOpenedApp(
      {required Function(RemoteMessage message) handler}) {
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      print('A new onMessageOpenedApp event was published!');
      handler(message);
    });
  }
}

class AndroidNotificationChannelWrapper {
  final AndroidNotificationChannel channel;
  final String? icon;

  const AndroidNotificationChannelWrapper({required this.channel, this.icon});

  String get id => channel.id;

  String get name => channel.name;

  String get description => channel.description;
}

class BranchIoManager {}
