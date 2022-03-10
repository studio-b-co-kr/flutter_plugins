import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:remedi_mvvm/remedi_mvvm.dart';

/// 앱의 최상위 위젯의 Wrapper 이다.
/// [appProviders] 은 주로 user 정보, 앱 전체에 영향을 미치는 settings 정보
class RemediApp {
  static final navigatorKey = GlobalKey<NavigatorState>();
  final MaterialApp Function() appBuilder;

  List<InheritedProvider> Function()? globalProviderBuilder;

  RemediApp({
    Key? key,
    required this.appBuilder,
    this.globalProviderBuilder,
    TransitionBuilder? builder,
  });

  Widget _build() {
    if (globalProviderBuilder == null) {
      return appBuilder();
    }

    return MultiProvider(
      providers: globalProviderBuilder!(),
      builder: (context, widget) => appBuilder(),
    );
  }

  run({
    Future Function()? readyToRun,
    Future Function(dynamic error, StackTrace stackTrace)? handleError,
  }) async {
    runZonedGuarded(() async {
      WidgetsFlutterBinding.ensureInitialized();
      if (readyToRun != null) {
        await readyToRun();
      }
      runApp(_build());
    }, (dynamic error, StackTrace stackTrace) async {
      if (handleError != null) {
        await handleError(error, stackTrace);
      }
    });
  }
}

extension AppRouter on RemediApp {
  static Future<T?>? pushNamed<T extends Object?>(
    String routeName, {
    Object? arguments,
  }) {
    return RemediApp.navigatorKey.currentState
        ?.pushNamed<T>(routeName, arguments: arguments);
  }

  static Future<T?>? popAndPushNamed<T extends Object?, TO extends Object?>(
    String routeName, {
    TO? result,
    Object? arguments,
  }) {
    return RemediApp.navigatorKey.currentState?.popAndPushNamed<T, TO>(
        routeName,
        result: result,
        arguments: arguments);
  }

  static Future<T?>?
      pushReplacementNamed<T extends Object?, TO extends Object?>(
    String routeName, {
    TO? result,
    Object? arguments,
  }) {
    return RemediApp.navigatorKey.currentState?.pushReplacementNamed<T, TO>(
      routeName,
      arguments: arguments,
    );
  }

  static Future<T?>? pushNamedAndRemoveUntil<T extends Object?>(
    String newRouteName,
    RoutePredicate predicate, {
    Object? arguments,
  }) {
    return RemediApp.navigatorKey.currentState?.pushNamedAndRemoveUntil<T>(
      newRouteName,
      predicate,
      arguments: arguments,
    );
  }

  static void pop<T extends Object?>([T? result]) {
    return RemediApp.navigatorKey.currentState?.pop<T>(result);
  }
}

abstract class IRouteGenerator {
  Future Function(String screenName)? screenLogger;

  IRouteGenerator({this.screenLogger});

  Route<dynamic>? generateRoute(RouteSettings settings);
}
