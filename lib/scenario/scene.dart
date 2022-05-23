part of 'scenario.dart';

abstract class Scene extends StatelessWidget {
  final Function() onFinished;
  final List<Provider> providers;

  const Scene({
    Key? key,
    required this.onFinished,
    this.providers = const [],
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget app = MaterialApp(
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
