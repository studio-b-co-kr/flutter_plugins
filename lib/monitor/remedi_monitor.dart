part of '../remedi_flutter.dart';

late bool _enableCrashlytics;

class RemediMonitor {
  static init({bool enableCrashlytics = false}) async {
    _enableCrashlytics = enableCrashlytics;
    await FirebaseCrashlytics.instance
        .setCrashlyticsCollectionEnabled(_enableCrashlytics);
  }

  static bool get monitoringCrash => _enableCrashlytics;
}
