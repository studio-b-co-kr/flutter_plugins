import 'package:flutter/widgets.dart';

abstract class IRouteGenerator {
  Future Function(String screenName)? screenLogger;

  IRouteGenerator({this.screenLogger});

  Route<dynamic>? generateRoute(RouteSettings settings);
}
