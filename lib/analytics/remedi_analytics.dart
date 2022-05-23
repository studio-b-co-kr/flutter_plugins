import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_core/firebase_core.dart';

import '../app/app.dart';

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
  static Future logScreenView({
    final String? screenName,
  }) async {
    List<Future> logger = [];
    if (enabledGoogleAnalytics) {
      logger.add(_logger!.logScreenView(screenName: screenName));
    }

    if (enabledRemediAnalytics) {
      logger.add(_gaLogger!.logScreenView(screenName: screenName));
    }

    return Future.wait(logger);
  }

  static Future logEvent(
      {required final String name,
      final Map<String, dynamic>? parameters}) async {
    List<Future> logger = [];
    if (enabledGoogleAnalytics) {
      logger.add(_logger!.logEvent(name: name, parameters: parameters));
    }

    if (enabledRemediAnalytics) {
      logger.add(_gaLogger!.logEvent(name: name, parameters: parameters));
    }

    return Future.wait(logger);
  }
}

abstract class Logger {
  Future setUserId({
    final String? id,
  });

  Future setUserProperty({
    required final String name,
    final String? value,
  });

  /// set this on screen class.
  Future setCurrentScreen({
    final String? screenName,
  });

  /// call this before transition screen
  Future logScreenView({
    final String? screenName,
  });

  Future logEvent(
      {required final String name, final Map<String, dynamic>? parameters});
}

class _FirebaseLogger extends Logger {
  @override
  Future setUserId({
    final String? id,
  }) async {
    return FirebaseAnalytics.instance.setUserId(
      id: id,
    );
  }

  @override
  Future setUserProperty({
    required final String name,
    final String? value,
  }) async {
    return FirebaseAnalytics.instance.setUserProperty(
      name: name,
      value: value,
    );
  }

  /// set this on screen class.
  @override
  Future setCurrentScreen({
    final String? screenName,
  }) async {
    return FirebaseAnalytics.instance.setCurrentScreen(
      screenName: screenName,
    );
  }

  /// call this before transition screen
  @override
  Future logScreenView({
    final String? screenName,
  }) async {
    return FirebaseAnalytics.instance.logScreenView(
      screenName: screenName,
    );
  }

  @override
  Future logEvent({
    required final String name,
    final Map<String, dynamic>? parameters,
  }) async {
    return FirebaseAnalytics.instance.logEvent(
      name: name,
      parameters: parameters,
    );
  }
}