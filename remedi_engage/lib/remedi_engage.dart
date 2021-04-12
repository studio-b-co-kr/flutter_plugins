library remedi_engage;

import 'package:firebase_analytics/firebase_analytics.dart';

class Analytics {
  final String eventName;
  final Map<String, String>? params;
  final bool enableLogging;

  Analytics._(
      {required this.eventName, this.enableLogging = true, this.params});

  factory Analytics.builder(String eventName, Map<String, String>? params) {
    return Analytics._(eventName: eventName, params: params);
  }

  log() async {
    FirebaseAnalytics().logEvent(name: eventName, parameters: params);
  }
}
