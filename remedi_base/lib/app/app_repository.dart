import 'package:udid/udid.dart';

class AppRepository {
  static AppRepository _instance;

  AppRepository._();

  static AppRepository get instance {
    if (_instance == null) {
      _instance = AppRepository._();
    }
    return _instance;
  }

  Future<String> get appId async => await Udid.udid;
}
