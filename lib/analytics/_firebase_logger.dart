part of 'remedi_analytics.dart';

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
  Future viewScreen({
    final String? screenName,
  }) async {
    return FirebaseAnalytics.instance.logScreenView(
      screenName: screenName,
    );
  }

  @override
  Future event({
    required final String name,
    final Map<String, dynamic>? parameters,
  }) async {
    return FirebaseAnalytics.instance.logEvent(
      name: name,
      parameters: parameters,
    );
  }
}
