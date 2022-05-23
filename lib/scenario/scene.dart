part of 'scenario.dart';

/// [Scene] 은 Cut widget 들의 모임이다.
/// Scene 을 이용해 UI Scenario 를 만들 수 있다.
/// 예를 들면 앱을 처음 켰을 때 Splash Scenario, 결재 Scenario 등을 만들 수 있다.
abstract class Scene extends StatelessWidget {
  final Function() onFinished;
  final List<Provider> providers;
  final ThemeData? theme;
  final ThemeData? darkTheme;
  final ThemeMode? themeMode;

  const Scene({
    Key? key,
    required this.onFinished,
    this.providers = const [],
    this.theme,
    this.darkTheme,
    this.themeMode,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget app = MaterialApp(
      theme: theme,
      darkTheme: darkTheme,
      themeMode: themeMode,
      onGenerateRoute: (settings) {
        return buildCutRoute(settings, this, background);
      },
      initialRoute: initialRoute,
    );
    if (providers.isEmpty) {
      return app;
    } else {
      return MultiProvider(
        providers: providers,
        builder: (context, widget) {
          return app;
        },
      );
    }
  }

  Widget? get background {
    return null;
  }

  String get initialRoute;

  Route<dynamic>? buildCutRoute(
      RouteSettings settings, Scene scene, Widget? background);
}
