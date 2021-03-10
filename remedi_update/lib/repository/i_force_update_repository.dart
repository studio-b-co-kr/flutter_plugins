import 'package:stacked_mvvm/stacked_mvvm.dart';

abstract class IForceUpdateRepository extends BaseRepository {
  Future<bool> get needToUpdate;
}
