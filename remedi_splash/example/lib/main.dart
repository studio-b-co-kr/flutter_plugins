import 'package:example/feature/home/home_page.dart';
import 'package:example/feature/splash/splash.dart';
import 'package:flutter/material.dart';
import 'package:remedi/remedi.dart';
import 'package:remedi_splash/remedi_splash.dart';

void main() {
  RemediApp(
      enableLog: true,
      appBuilder: (BuildContext context) {
        return MaterialApp(
          title: 'Flutter Demo',
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          initialRoute: RemediSplash.routeNameAppOpen,
          onGenerateRoute: (settings) {
            Route? ret = RemediSplash.generateRoute(
              settings: settings,
              background: const SplashBackground(),
              repository: SplashRepository(),
            );
            if (ret != null) {
              return ret;
            }
            switch (settings.name) {
              case HomePage.routeName:
                ret = MaterialPageRoute(
                    settings: settings,
                    builder: (context) {
                      return const HomePage();
                    });
                break;
            }

            return ret;
          },
        );
      }).run();
}
