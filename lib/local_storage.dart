part of 'remedi_flutter.dart';

FlutterSecureStorage _futureStorage = const FlutterSecureStorage();

class LocalStorage {
  static Future<void> writeInt(String key, int value) async {
    return await _futureStorage.write(
      key: key,
      value: value.toString(),
    );
  }

  static Future<void> writeBool(String key, bool value) async {
    return await _futureStorage.write(
      key: key,
      value: value.toString(),
    );
  }

  static Future<void> writeDouble(String key, double value) async {
    return await _futureStorage.write(
      key: key,
      value: value.toString(),
    );
  }

  static Future<void> writeString(String key, String value) async {
    return await _futureStorage.write(
      key: key,
      value: value,
    );
  }

  static Future<int?> readInt(String key) async {
    String? read = await _futureStorage.read(key: key);

    int? ret;
    try {
      ret = read == null ? null : int.parse(read);
    } catch (e) {
      return null;
    }
    return ret;
  }

  static Future<bool?> readBool(String key) async {
    String? read = await _futureStorage.read(key: key);
    bool? ret;
    try {
      ret = read == null ? null : read == 'true';
    } catch (e) {
      return null;
    }
    return ret;
  }

  static Future<double?> readDouble(String key) async {
    String? read = await _futureStorage.read(key: key);

    double? ret;
    try {
      ret = read == null ? null : double.parse(read);
    } catch (e) {
      return null;
    }
    return ret;
  }

  static Future<String?> readString(String key) async {
    String? read = await _futureStorage.read(key: key);
    return read;
  }

  static Future<void> delete(String key) async {
    return await _futureStorage.delete(key: key);
  }
}

class LocalDatabase {}
