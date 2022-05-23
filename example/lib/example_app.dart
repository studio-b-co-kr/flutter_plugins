import 'package:example/app_models/auth_app_model.dart';
import 'package:example/app_models/color_app_model.dart';
import 'package:example/app_models/settings_app_model.dart';
import 'package:example/example_app_route_generator.dart';
import 'package:example/features/splash/splash_scene.dart';
import 'package:flutter/material.dart';
import 'package:remedi_flutter/remedi_flutter.dart';

RemediApp _app = RemediApp(
  enableLog: true,
  appModels: [
    /// 홈화면의 배경색정보를 제공한다.
    ChangeNotifierProvider<ColorAppModel>(create: (context) => ColorAppModel()),

    /// 앱의 테마 정보를 제공한다.
    ChangeNotifierProvider<SettingsAppModel>(
      create: (context) => SettingsAppModel(),
    ),

    /// 로그인 정보를 제공한다.
    ChangeNotifierProvider<AuthAppModel>(create: (context) => AuthAppModel()),
  ],
  appBuilder: (context) => MaterialApp(
    /// context 없이 route 를 사용할수있도록  navigatorKey를 RemediApp.navigatorKey로 설정한다.
    navigatorKey: RemediRouter.navigatorKey,
    themeMode: context.watch<SettingsAppModel>().themeMode,
    darkTheme: context.watch<SettingsAppModel>().themeDark,
    theme: context.watch<SettingsAppModel>().themeLight,

    /// 첫화면은 스플래시 화면이다.
    initialRoute: SplashScene.routeName,

    /// RouteGenerator 는 route 시에 로깅을 할 수 있는 인터페이스를 제공한다.
    onGenerateRoute: (settings) =>
        ExampleAppRouteGenerator(screenLogger: (routeName) async {
      AppLog.log(routeName, name: 'ScreenLogger');
    }).route(settings),
  ),
);

void run({
  Future Function()? readyToRun,
  Future Function(dynamic error, StackTrace stackTrace)? handleError,
}) {
  _app.run(readyToRun: readyToRun, errorHandler: handleError);
}
