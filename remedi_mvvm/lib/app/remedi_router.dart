import 'package:flutter/widgets.dart';
import 'package:remedi_mvvm/remedi_mvvm.dart';

extension RemediRouter on RemediApp {
  static Future<T?>? pushNamed<T extends Object?>(
    String routeName, {
    Object? arguments,
  }) {
    return RemediApp.navigatorKey.currentState
        ?.pushNamed<T>(routeName, arguments: arguments);
  }

  static Future<T?>? popAndPushNamed<T extends Object?, TO extends Object?>(
    String routeName, {
    TO? result,
    Object? arguments,
  }) {
    return RemediApp.navigatorKey.currentState?.popAndPushNamed<T, TO>(
        routeName,
        result: result,
        arguments: arguments);
  }

  static Future<T?>?
      pushReplacementNamed<T extends Object?, TO extends Object?>(
    String routeName, {
    TO? result,
    Object? arguments,
  }) {
    return RemediApp.navigatorKey.currentState?.pushReplacementNamed<T, TO>(
      routeName,
      arguments: arguments,
    );
  }

  static Future<T?>? pushNamedAndRemoveUntil<T extends Object?>(
    String newRouteName,
    RoutePredicate predicate, {
    Object? arguments,
  }) {
    return RemediApp.navigatorKey.currentState?.pushNamedAndRemoveUntil<T>(
      newRouteName,
      predicate,
      arguments: arguments,
    );
  }

  static void pop<T extends Object?>([T? result]) {
    return RemediApp.navigatorKey.currentState?.pop<T>(result);
  }
}
