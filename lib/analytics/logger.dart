part of 'remedi_analytics.dart';

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
  Future viewScreen({
    final String? screenName,
  });

  Future event(
      {required final String name, final Map<String, dynamic>? parameters});
}
