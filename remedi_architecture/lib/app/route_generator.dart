part of 'app.dart';

abstract class IRouteGenerator {
  Future Function(String screenName)? screenLogger;

  IRouteGenerator({this.screenLogger});

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
