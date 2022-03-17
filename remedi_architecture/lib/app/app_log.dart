part of 'app.dart';

class AppLog {
  static log(
    String message, {
    DateTime? time,
    int? sequenceNumber,
    int level = 0,
    String name = '',
    Zone? zone,
    Object? error,
    StackTrace? stackTrace,
  }) {
    if (RemediApp.enableLog) {
      dev.log(message,
          time: time,
          sequenceNumber: sequenceNumber,
          level: level,
          name: name,
          zone: zone,
          error: error,
          stackTrace: stackTrace);
    }
  }
}
