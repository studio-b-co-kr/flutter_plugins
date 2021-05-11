import 'package:stacked_mvvm/stacked_mvvm.dart';

abstract class IForceUpdateRepository extends IRepository {
  String get androidAppId;

  String get iosAppId;

  Future<bool> get needToUpdate;
}
