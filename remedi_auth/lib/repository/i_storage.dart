abstract class IStorage {
  Future write({String key, String value});

  Future<String> read(String key);

  Future delete(String key);
}
