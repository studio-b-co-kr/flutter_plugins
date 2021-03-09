import 'package:flutter/widgets.dart';

import 'feature/home/home_page.dart';

typedef Route<dynamic> GenerateRoutes(RouteSettings settings);

GenerateRoutes generateRoute =
    (RouteSettings settings, {Stream<Map<dynamic, dynamic>> deepLinkStream}) {
  Route<dynamic> ret;
  switch (settings.name) {
    case HomePage.ROUTE_NAME:
      ret = HomePage.route(settings);
      break;
  }

  return ret;
};
