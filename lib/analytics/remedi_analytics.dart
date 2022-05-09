import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:remedi_flutter/net/net.dart';

bool _enableGoogleAnalytics = false;
bool _enableRemediAnalytics = false;
String? baseUrl;

class RemediAnalytics {
  static init({
    bool enableGoogleAnalytics = false,
    bool enableRemediAnalytics = false,
    String? baseUrl,
  }) {
    _enableGoogleAnalytics = enableGoogleAnalytics;
    _enableRemediAnalytics = enableRemediAnalytics;
    if (_enableGoogleAnalytics) {
      assert(
        _enableRemediAnalytics &&
            (baseUrl?.isNotEmpty ?? false) &&
            Uri.parse(baseUrl!).isAbsolute,
      );
      baseUrl = baseUrl;
    }
  }

  static get enabledGoogleAnalytics => _enableGoogleAnalytics;

  static get enabledRemediAnalytics => _enableRemediAnalytics;
}

class RequestAppEvent extends IDto {
  final String platform;
  final String name;
  Map<String, dynamic>? data;

  void addData(String key, dynamic value) {
    data ??= {};
    data?.update(key, (v) => value, ifAbsent: () => value);
  }

  void addAll(Map<String, dynamic> params) {
    assert(params.isNotEmpty);
    data?.addAll(params);
  }

  RequestAppEvent({
    required this.platform,
    required this.name,
  }) : super();

  @override
  dynamic get toJson {
    return {
      "app_event": {
        "platform": platform,
        "name": name,
        "data": data,
      }
    };
  }
}

DioRequest get _dioLoggerRequest {
  return DioRequest(
    builder: DioBuilder.json(
      baseUrl: baseUrl!,
      extraHeaders: {
        'User-Agent': AppConfig.platform,
        'App-Version': AppConfig.appVersion,
        'Os-Version': AppConfig.osVersion,
        'App-Id': AppConfig.appId,
      },
      enableLogging: AppConfig.enablePrintLog,
    ),
  );
}

class _AppEventApiService extends ApiService<bool> {
  _AppEventApiService() : super(request: _dioLoggerRequest);

  Future<dynamic> post(RequestAppEvent event) async {
    return await requestPost(path: '/api/v1/app_events', data: event.toJson);
  }

  @override
  bool? onSuccess({int? statusCode, dynamic json}) {
    return true;
  }
}

class _RemediLogger {
  Future setUserId({
    final String? id,
  }) async {
    return FirebaseAnalytics.instance.setUserId(
      id: id,
    );
  }

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
  Future setCurrentScreen({
    final String? screenName,
  }) async {
    return FirebaseAnalytics.instance.setCurrentScreen(
      screenName: screenName,
    );
  }

  /// call this before transition screen
  Future logScreenView({
    final String? screenName,
  }) async {
    return FirebaseAnalytics.instance.logScreenView(
      screenName: screenName,
    );
  }

  Future logEvent(
      {required final String name,
      final Map<String, dynamic>? parameters}) async {
    return FirebaseAnalytics.instance.logEvent(
      name: name,
      parameters: parameters,
    );
  }
}

class _FirebaseLogger {
  Future setUserId({
    final String? id,
  }) async {
    return FirebaseAnalytics.instance.setUserId(
      id: id,
    );
  }

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
  Future setCurrentScreen({
    final String? screenName,
  }) async {
    return FirebaseAnalytics.instance.setCurrentScreen(
      screenName: screenName,
    );
  }

  /// call this before transition screen
  Future logScreenView({
    final String? screenName,
  }) async {
    return FirebaseAnalytics.instance.logScreenView(
      screenName: screenName,
    );
  }

  Future logEvent(
      {required final String name,
      final Map<String, dynamic>? parameters}) async {
    return FirebaseAnalytics.instance.logEvent(
      name: name,
      parameters: parameters,
    );
  }
}
