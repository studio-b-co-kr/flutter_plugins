part of 'app.dart';

typedef ScreenLogger = Future<dynamic> Function(
    String screenName, Map<String, dynamic>? data);

abstract class IRouteGenerator {
  ScreenLogger? screenLogger;

  IRouteGenerator({this.screenLogger});

  Route<dynamic>? route(RouteSettings settings) {
    var uri = RouteUri._fromSettings(settings);
    var ret = generateRoute(settings, uri?.name, uri?.data);

    if (screenLogger != null && ret != null) {
      screenLogger!(settings.name!, uri?.data);
    }

    return ret;
  }

  /// don't call this function  directly
  Route<dynamic>? generateRoute(
      RouteSettings settings, String? routeName, Map<String, dynamic>? data);
}
