import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'app_routes.dart' as routes;
import 'feature/home/home_page.dart';

class ExampleApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: HomePage.ROUTE_NAME,
      onGenerateRoute: (settings) => routes.generateRoute(settings),
    );
  }
}
