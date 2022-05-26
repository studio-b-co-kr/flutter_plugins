part of 'message.dart';

class FirebaseMessagingAppModel extends AppModel {
  FirebaseMessagingAppModel() : super();

  @override
  initialise() {
    FirebaseMessaging.instance
        .getInitialMessage()
        .then((RemoteMessage? message) {
      if (message != null) {
        // todo handle message
        AppLog.log('getInitialMessage', name: 'FirebaseMessagingAppModel');
      }
    });

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      RemoteNotification? notification = message.notification;
      AndroidNotification? android = message.notification?.android;
      if (notification != null && android != null && !kIsWeb) {
        // todo handle message
        AppLog.log('onMessage.$message', name: 'FirebaseMessagingAppModel');
      }
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      // todo handle message
      AppLog.log('onMessageOpenedApp.$message',
          name: 'FirebaseMessagingAppModel');
    });
  }

  Future<void> subscribe({required String topic}) async {
    await FirebaseMessaging.instance.subscribeToTopic(topic);
  }

  Future<void> unsubscribe({required String topic}) async {
    await FirebaseMessaging.instance.unsubscribeFromTopic(topic);
  }

  Future<void> getAPNSToken() async {
    if (defaultTargetPlatform == TargetPlatform.iOS ||
        defaultTargetPlatform == TargetPlatform.macOS) {
      _apnsToken = await FirebaseMessaging.instance.getAPNSToken();
    } else {}
  }

  String? _apnsToken;

  String? _token;

  void getFCMToken() async {
    _token = await FirebaseMessaging.instance.getToken();
  }

  bool _fetching = false;
  bool _requested = false;
  NotificationSettings? _settings;

  Future<void> requestPermissions() async {
    _fetching = true;

    NotificationSettings settings =
        await FirebaseMessaging.instance.requestPermission(
      announcement: true,
      carPlay: true,
      criticalAlert: true,
    );

    _requested = true;
    _fetching = false;
    _settings = settings;
  }

  Future<void> checkPermissions() async {
    _fetching = true;

    NotificationSettings settings =
        await FirebaseMessaging.instance.getNotificationSettings();

    _requested = true;
    _fetching = false;
    _settings = settings;
  }
}
