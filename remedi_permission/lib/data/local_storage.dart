import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class LocalStorage {
  static LocalStorage _instance;

  static LocalStorage get instance {
    if (_instance == null) {
      _instance = LocalStorage._();
    }
    return _instance;
  }

  LocalStorage._();

  static const _KEY_SKIP = "KEY_SKIP";
  static const _VALUE_SKIP = "skipped";
  final FlutterSecureStorage _storage = FlutterSecureStorage();

  Future skip() async {
    return await _storage.write(key: _KEY_SKIP, value: _VALUE_SKIP);
  }

  Future<bool> get skipped async =>
      await _storage.read(key: _KEY_SKIP) == _VALUE_SKIP;
}