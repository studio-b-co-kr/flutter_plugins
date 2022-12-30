import 'dart:developer' as dev;

import 'package:shared_preferences/shared_preferences.dart';

class LocalStorage {
  static final LocalStorage _instance = LocalStorage._();

  LocalStorage._();

  factory LocalStorage.instance() => _instance;

  static const _KEY_SKIP_ON_SPLASH = "KEY_SKIP_ON_SPLASH";
  static const _VALUE_SKIP = "skipped";

  Future skip() async {
    var sp = await SharedPreferences.getInstance();
    return await sp.setString(_KEY_SKIP_ON_SPLASH, _VALUE_SKIP);
  }

  Future<bool> get skipped async {
    var sp = await SharedPreferences.getInstance();
    bool ret = await await sp.getString(_KEY_SKIP_ON_SPLASH) == _VALUE_SKIP;
    dev.log("skipped = $ret", name: "PermissionManager");
    return ret;
  }
}
