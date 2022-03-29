import 'package:flutter_branch_sdk/flutter_branch_sdk.dart';

import '../../remedi.dart';

part 'branch.dart';
part 'branch_app_model.dart';

class RemediBranch {
  final List<Map<dynamic, dynamic>> _cache = [];

  List<Map<dynamic, dynamic>> get cache => _cache;

  init() {
    FlutterBranchSdk.initSession().asBroadcastStream().listen((event) {
      _cache.add(event);
    });
  }

  void cacheClear() {
    _cache.clear();
  }
}
