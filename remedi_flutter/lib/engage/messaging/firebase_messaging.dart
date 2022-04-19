part of 'message.dart';

late AndroidNotificationChannel _channel;

late FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin;

class FirebaseMessage {
  static Future<void> init(
    RemoteMessageHandler messageHandler, {
    bool alert = true,
    bool badge = true,
    bool sound = true,
  }) async {
    FirebaseMessaging.onBackgroundMessage((message) async {
      await Firebase.initializeApp();
      messageHandler(message);
    });

    if (!kIsWeb) {
      _channel = const AndroidNotificationChannel(
        'high_importance_channel', // id
        'High Importance Notifications', // title
        importance: Importance.high,
      );

      await _flutterLocalNotificationsPlugin
          .resolvePlatformSpecificImplementation<
              AndroidFlutterLocalNotificationsPlugin>()
          ?.createNotificationChannel(_channel);

      await FirebaseMessaging.instance
          .setForegroundNotificationPresentationOptions(
        alert: alert,
        badge: badge,
        sound: sound,
      );
    }
  }

  static AndroidNotificationChannel get channel => _channel;

  static FlutterLocalNotificationsPlugin get notificationsPlugin =>
      _flutterLocalNotificationsPlugin;
}
