abstract class IStorage {
  Future<void> write({required String key, required String value});

  Future<String?> read({required String key});

  Future delete({required String key});
}
