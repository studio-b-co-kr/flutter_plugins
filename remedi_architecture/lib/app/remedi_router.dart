part of 'app.dart';

class RemediRouter {
  static final navigatorKey = GlobalKey<NavigatorState>();

  static Future<T?>? pushNamed<T extends Object?>(
    String routeName, {
    Object? arguments,
  }) {
    return navigatorKey.currentState
        ?.pushNamed<T>(routeName, arguments: arguments);
  }

  static Future<T?>? popAndPushNamed<T extends Object?, TO extends Object?>(
    String routeName, {
    TO? result,
    Object? arguments,
  }) {
    return navigatorKey.currentState?.popAndPushNamed<T, TO>(routeName,
        result: result, arguments: arguments);
  }

  static Future<T?>?
      pushReplacementNamed<T extends Object?, TO extends Object?>(
    String routeName, {
    TO? result,
    Object? arguments,
  }) {
    return navigatorKey.currentState?.pushReplacementNamed<T, TO>(
      routeName,
      arguments: arguments,
    );
  }

  static Future<T?>? pushNamedAndRemoveUntil<T extends Object?>(
    String newRouteName,
    RoutePredicate predicate, {
    Object? arguments,
  }) {
    return navigatorKey.currentState?.pushNamedAndRemoveUntil<T>(
      newRouteName,
      predicate,
      arguments: arguments,
    );
  }

  static void pop<T extends Object?>([T? result]) {
    return navigatorKey.currentState?.pop<T>(result);
  }
}
