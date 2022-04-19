part of 'message.dart';

typedef RemoteMessageHandler = Future<void> Function(RemoteMessage message);
