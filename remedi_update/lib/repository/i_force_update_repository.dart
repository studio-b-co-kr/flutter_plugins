

abstract class IForceUpdateRepository extends BaseRepository {
  Future<bool> get needToUpdate;
}
