import 'dart:async';
import 'dart:developer' as dev;

import 'package:flutter/material.dart';
import 'package:remedi_mvvm/remedi_mvvm.dart';

part 'app_log.dart';
part 'i_route_generator.dart';
part 'remedi_router.dart';

/// 앱의 최상위 위젯의 Wrapper 이다.
/// [appProviders] 은 주로 user 정보, 앱 전체에 영향을 미치는 settings 정보

class RemediApp {
  static final navigatorKey = GlobalKey<NavigatorState>();
  static bool enableLog = false;
  final MaterialApp app;

  List<InheritedProvider>? globalProviders;

  RemediApp({
    Key? key,
    required this.app,
    bool enableLog = false,
    this.globalProviders,
    TransitionBuilder? builder,
  });

  Widget _build() {
    RemediApp.enableLog = enableLog;
    if (globalProviders?.isEmpty ?? true) {
      return app;
    } else {
      return MultiProvider(
        providers: globalProviders!,
        builder: (context, widget) {
          return app;
        },
      );
    }
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
