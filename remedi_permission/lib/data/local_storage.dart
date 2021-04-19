import 'dart:developer' as dev;

import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class LocalStorage {
  static final LocalStorage _instance = LocalStorage._();

  LocalStorage._();

  factory LocalStorage.instance() => _instance;

  static const _KEY_SKIP_ON_SPLASH = "KEY_SKIP_ON_SPLASH";
  static const _VALUE_SKIP = "skipped";
  final FlutterSecureStorage _storage = FlutterSecureStorage();

  Future skip() async {
    return await _storage.write(key: _KEY_SKIP_ON_SPLASH, value: _VALUE_SKIP);
  }

  Future<bool> get skipped async {
    bool ret = await _storage.read(key: _KEY_SKIP_ON_SPLASH) == _VALUE_SKIP;
    dev.log("allGranted = $ret", name: "PermissionManager");
    return ret;
  }
}
