import 'dart:async';

import 'package:flutter/material.dart';
import 'package:remedi_mvvm/remedi_mvvm.dart';

/// 앱의 최상위 위젯의 Wrapper 이다.
/// [appProviders] 은 주로 user 정보, 앱 전체에 영향을 미치는 settings 정보

class RemediApp {
  static final navigatorKey = GlobalKey<NavigatorState>();
  final MaterialApp app;

  List<InheritedProvider>? globalProviders;
  Function(BuildContext context)? initGlobalProvider;

  RemediApp({
    Key? key,
    required this.app,
    this.globalProviders,
    this.initGlobalProvider,
    TransitionBuilder? builder,
  });

  Widget _build() {
    if (globalProviders?.isEmpty ?? true) {
      return app;
    } else {
      return MultiProvider(
        providers: globalProviders!,
        builder: (context, widget) {
          if (initGlobalProvider != null) {
            initGlobalProvider!(context);
          }
          return _AppWidget(child: app);
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

class _AppWidget extends StatelessWidget {
  final Widget child;

  const _AppWidget({
    Key? key,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return child;
  }
}
