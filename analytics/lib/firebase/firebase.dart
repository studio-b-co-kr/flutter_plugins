// import 'dart:io';
//
// import 'package:firebase_analytics/firebase_analytics.dart';
// import 'package:firebase_core/firebase_core.dart';
// import 'package:firebase_crashlytics/firebase_crashlytics.dart';
// import 'package:firebase_performance/firebase_performance.dart';
// import 'package:flutter/widgets.dart';
// import '../app/app_config.dart';
//
// class FirebaseConfig {
//   static Future init(
//       {bool enableAnalytics = false,
//       bool enableCrashlytics = false,
//       bool enablePerformance = false}) async {
//     await Firebase.initializeApp();
//
//     List<Future> works = [];
//
//     if (enableAnalytics) {
//       works.add(FirebaseAnalytics()
//           .setAnalyticsCollectionEnabled(AppConfig.isRelease));
//     }
//
//     if (enablePerformance) {
//       works.add(
//           FirebasePerformance.instance.setPerformanceCollectionEnabled(true));
//     }
//
//     if (enableCrashlytics) {
//       works.add(FirebaseCrashlytics.instance
//           .setCrashlyticsCollectionEnabled(AppConfig.isRelease));
//     }
//
//     await Future.wait(works);
//
//     if (enableCrashlytics) {
//       if (FirebaseCrashlytics.instance.isCrashlyticsCollectionEnabled) {
//         FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterError;
//       } else {
//         FlutterError.onError = (FlutterErrorDetails details) {
//           FlutterError.dumpErrorToConsole(details);
//           if (!AppConfig.isRelease) {
//             exit(1);
//           }
//         };
//       }
//     }
//   }
// }
//
