import 'package:shared_preferences/shared_preferences.dart';

Future<SharedPreferences> _futureStorage = SharedPreferences.getInstance();

class LocalStorage {
  static Future<int?> readInt(String key) async {
    return (await _futureStorage).getInt(key);
  }

  static Future<bool?> readBool(String key) async {
    return (await _futureStorage).getBool(key);
  }

  static Future<double?> readDouble(String key) async {
    return (await _futureStorage).getDouble(key);
  }

  static Future<String?> readString(String key) async {
    return (await _futureStorage).getString(key);
  }

  static Future<List<String>?> readStringList(String key) async {
    return (await _futureStorage).getStringList(key);
  }

  static Future<bool> writeInt(String key, int value) async {
    return (await _futureStorage).setInt(key, value);
  }

  static Future<bool> writeBool(String key, bool value) async {
    return (await _futureStorage).setBool(key, value);
  }

  static Future<bool> writeDouble(String key, double value) async {
    return (await _futureStorage).setDouble(key, value);
  }

  static Future<bool> writeString(String key, String value) async {
    return (await _futureStorage).setString(key, value);
  }

  static Future<bool> writeStringList(String key, List<String> value) async {
    return (await _futureStorage).setStringList(key, value);
  }

  static Future<bool> delete(String key) async {
    return (await _futureStorage).remove(key);
  }
}

class LocalDatabase {}
