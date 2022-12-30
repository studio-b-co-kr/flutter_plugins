import 'package:flutter_udid/flutter_udid.dart';

class AppRepository {
  static AppRepository _instance = AppRepository._();

  AppRepository._();

  factory AppRepository.instance() => _instance;

  Future<String> get appId async => await FlutterUdid.udid;
}
