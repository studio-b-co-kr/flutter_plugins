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

  // static Future<T?>? pushUri<T extends Object?>(RouteUri uri) {
  //   return navigatorKey.currentState
  //       ?.pushNamed<T>(uri.name, arguments: uri.data);
  // }

  static Future<T?>? popAndPushNamed<T extends Object?, TO extends Object?>(
    String routeName, {
    TO? result,
    Object? arguments,
  }) async {
    await Future.delayed(Duration.zero);
    return navigatorKey.currentState?.popAndPushNamed<T, TO>(
      routeName,
      result: result,
      arguments: arguments,
    );
  }

  // static Future<T?>? popAndPushUri<T extends Object?, TO extends Object?>(
  //   RouteUri uri, {
  //   TO? result,
  // }) {
  //   return navigatorKey.currentState
  //       ?.popAndPushNamed<T, TO>(uri.name, result: result, arguments: uri.data);
  // }

  static Future<T?>?
      pushReplacementNamed<T extends Object?, TO extends Object?>(
    String routeName, {
    TO? result,
    Object? arguments,
  }) async {
    await Future.delayed(Duration.zero);
    return navigatorKey.currentState?.pushReplacementNamed<T, TO>(
      routeName,
      result: result,
      arguments: arguments,
    );
  }

  // static Future<T?>? pushReplacementUri<T extends Object?, TO extends Object?>(
  //   RouteUri uri, {
  //   TO? result,
  // }) {
  //   return navigatorKey.currentState?.pushReplacementNamed<T, TO>(
  //     uri.name,
  //     arguments: uri.data,
  //   );
  // }

  static Future<T?>? pushNamedAndRemoveUntil<T extends Object?>(
    String newRouteName,
    RoutePredicate predicate, {
    Object? arguments,
  }) async {
    await Future.delayed(Duration.zero);
    return navigatorKey.currentState?.pushNamedAndRemoveUntil<T>(
      newRouteName,
      predicate,
      arguments: arguments,
    );
  }

  // static Future<T?>? pushUriAndRemoveUntil<T extends Object?>(
  //   RouteUri uri,
  //   RoutePredicate predicate,
  // ) {
  //   return navigatorKey.currentState?.pushNamedAndRemoveUntil<T>(
  //     uri.name,
  //     predicate,
  //     arguments: uri.data,
  //   );
  // }

  static void pop<T extends Object?>([T? result]) {
    return navigatorKey.currentState?.pop<T>(result);
  }
}
