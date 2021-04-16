import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:remedi_base/remedi_base.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  AppConfig.setFlavorConfig(
    baseUrl: "https://google.com",
    baseWebUrl: "https://naver.com",
    isRelease: kReleaseMode,
    // "prod",
    endpoint: "dev",
    enablePrintLog: kReleaseMode,
  );

  // First time, do init()
  await AppConfig.init();

  AppConfig.log();

  runApp(AppContainer(
    app: MaterialApp(
      home: MyApp(),
    ),
  ));
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    initPlatformState();
  }

  Future<void> initPlatformState() async {
    if (!mounted) return;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: FutureBuilder(
            future: GoogleApiService().request(),
            builder: (context, snapshot) {
              String htmlString = 'about:blank';
              if (snapshot.hasData) {
                htmlString = "${snapshot.data}";
              }
              return ListView(
                children: [Text(htmlString)],
              );
            }),
      ),
    );
  }
}

class GoogleApiService extends DioGetApiService<String> {
  GoogleApiService({IClientFactory? clientFactory})
      : super(clientFactory = DioFactory.noneAuth(AppConfig.baseUrl,
            userAgent: AppConfig.platform, appVersion: AppConfig.appVersion));

  @override
  String get path => "";

  @override
  String jsonTo(dynamic json) {
    return json;
  }
}

class GoogleApiDto extends IDto {
  final String html;

  GoogleApiDto({required this.html});

  @override
  Map<String, dynamic> get toJson => {"data": html};
}
