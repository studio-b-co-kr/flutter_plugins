part of 'remedi_app.dart';

abstract class IRouteGenerator {
  Future Function(String screenName)? screenLogger;

  IRouteGenerator({this.screenLogger});

  Route<dynamic>? generateRoute(RouteSettings settings);
}
