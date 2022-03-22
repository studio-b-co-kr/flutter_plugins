part of 'app.dart';

typedef ScreenLogger = Future<dynamic> Function(String screenName);

abstract class RouteGenerator {
  ScreenLogger? screenLogger;

  RouteGenerator({this.screenLogger});

  Route<dynamic>? route(RouteSettings settings) {
    var ret = generateRoute(settings);

    if (screenLogger != null && ret != null) {
      screenLogger!(settings.name!);
    }

    return ret;
  }

  /// don't call this function  directly
  Route<dynamic>? generateRoute(RouteSettings settings);
}
