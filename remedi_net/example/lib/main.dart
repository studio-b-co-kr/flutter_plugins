import 'dart:developer' as dev;

import 'package:flutter/material.dart';
import 'package:remedi_net/remedi_net.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: const Text("TEST"),
      ),
      body: FutureBuilder(
        future: getGoogle(),
        builder: (context, snapshot) => Center(
          child: Text(
            '${snapshot.data}',
          ),
        ),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  Future<dynamic> getGoogle() async {
    var ret = await GoogleApiService().get();
    dev.log("$ret", name: 'getGoogle');
    return ret;
  }
}

class GoogleApiService extends ApiService<String> {
  get() async {
    return requestGet(path: '/books/v1/volumes', queries: {'q': '{http}'});
  }

  @override
  DioRequest get client => DioRequest(DioBuilder.fromUrl(
      baseUrl: 'https://www.googleapis.com',
      enableLogging: true,
      futureHeaders: {'accessKey': accessKey()}));

  @override
  String? fromJson(json) {}
}

Future<String> accessKey() async {
  await Future.delayed(const Duration(seconds: 1));
  return "abcde";
}
