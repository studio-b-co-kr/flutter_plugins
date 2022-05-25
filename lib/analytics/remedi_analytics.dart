import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';

import '../app/app.dart';

part '_firebase_logger.dart';
part 'logger.dart';

bool _enableGoogleAnalytics = false;
bool _enableRemediAnalytics = false;
Logger? _logger;
Logger? _gaLogger;

/// call this at entry point of app after initializing firebase
class RemediAnalytics {
  static Future init({
    bool enableGoogleAnalytics = false,
    bool enableRemediAnalytics = false,
    Logger? logger,
  }) async {
    _enableGoogleAnalytics = enableGoogleAnalytics;
    _enableRemediAnalytics = enableRemediAnalytics;
    if (_enableRemediAnalytics) {
      assert(_enableRemediAnalytics && logger != null);
      _logger = logger;
    }
    Firebase.app().setAutomaticDataCollectionEnabled(_enableGoogleAnalytics);
    if (_enableGoogleAnalytics) {
      _gaLogger = _FirebaseLogger();
    }

    await setUserId(id: AppConfig.appId);
  }

  static get enabledGoogleAnalytics => _enableGoogleAnalytics;

  static get enabledRemediAnalytics => _enableRemediAnalytics;

  static Future setUserId({
    final String? id,
  }) async {
    List<Future> logger = [];
    if (enabledGoogleAnalytics) {
      logger.add(_logger!.setUserId(id: id));
    }

    if (enabledRemediAnalytics) {
      logger.add(_gaLogger!.setUserId(id: id));
    }

    return Future.wait(logger);
  }

  static Future setUserProperty({
    required final String name,
    final String? value,
  }) async {
    List<Future> logger = [];
    if (enabledGoogleAnalytics) {
      logger.add(_logger!.setUserProperty(name: name, value: value));
    }

    if (enabledRemediAnalytics) {
      logger.add(_gaLogger!.setUserProperty(name: name, value: value));
    }

    return Future.wait(logger);
  }

  /// set this on screen class.
  static Future setCurrentScreen({
    final String? screenName,
  }) async {
    List<Future> logger = [];
    if (enabledGoogleAnalytics) {
      logger.add(_logger!.setCurrentScreen(screenName: screenName));
    }

    if (enabledRemediAnalytics) {
      logger.add(_gaLogger!.setCurrentScreen(screenName: screenName));
    }

    return Future.wait(logger);
  }

  /// call this before transition screen
  static Future viewScreen({
    final String? screenName,
  }) async {
    List<Future> logger = [];
    if (enabledGoogleAnalytics) {
      logger.add(_logger!.viewScreen(screenName: screenName));
    }

    if (enabledRemediAnalytics) {
      logger.add(_gaLogger!.viewScreen(screenName: screenName));
    }

    return Future.wait(logger);
  }

  static Future event(
      {required final String name,
      final Map<String, dynamic>? parameters}) async {
    List<Future> logger = [];
    if (enabledGoogleAnalytics) {
      logger.add(_logger!.event(name: name, parameters: parameters));
    }

    if (enabledRemediAnalytics) {
      logger.add(_gaLogger!.event(name: name, parameters: parameters));
    }

    return Future.wait(logger);
  }

  static Future error(dynamic error) async {
    if (error is Error) {
      AppLog.e('ERROR', error: error, stackTrace: error.stackTrace);
      await FirebaseCrashlytics.instance.log("${error.stackTrace}");
      return;
    }

    AppLog.e('ERROR', error: error);
    await FirebaseCrashlytics.instance.log("$error");
  }
}
