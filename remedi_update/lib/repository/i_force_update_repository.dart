import 'package:stacked_mvvm/stacked_mvvm.dart';

abstract class IForceUpdateRepository extends BaseRepository {
  String get androidAppId;

  String get iosAppId;

  Future<bool> get needToUpdate;
}
