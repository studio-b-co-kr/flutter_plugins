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
    if (_enableLog) {
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

  static e(String tag, {dynamic error, StackTrace? stackTrace}) {
    if (AppConfig.enablePrintLog) {
      stderr.writeln("[debugging log : $tag] $error\n stackTrace:$stackTrace");
    }
  }
}
