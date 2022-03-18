part of 'app.dart';

/// 앱의 최상위 위젯의 Wrapper 이다.
/// [appProviders] 은 주로 user 정보, 앱 전체에 영향을 미치는 settings 정보

bool _enableLog = false;

class RemediApp {
  static final navigatorKey = GlobalKey<NavigatorState>();
  final MaterialApp Function(BuildContext context) appBuilder;
  bool enableLog;
  List<InheritedProvider>? appModels;

  RemediApp({
    Key? key,
    this.enableLog = false,
    this.appModels,
    required this.appBuilder,
  });

  Widget _build() {
    _enableLog = enableLog;
    if (appModels?.isEmpty ?? true) {
      return _AppWrapper(appBuilder: appBuilder);
    } else {
      return MultiProvider(
        providers: appModels!,
        builder: (context, widget) {
          return _AppWrapper(appBuilder: appBuilder);
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

class _AppWrapper extends StatelessWidget {
  final MaterialApp Function(BuildContext context) appBuilder;

  const _AppWrapper({Key? key, required this.appBuilder}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return appBuilder(context);
  }
}
