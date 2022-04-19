import 'dart:developer' as dev;

import 'package:remedi_flutter/remedi_flutter.dart';

class PermissionStorage {
  static const _keySkipOnSplash = "keySkipOnSplash";

  static Future skip() async {
    return await LocalStorage.writeBool(_keySkipOnSplash, true);
  }

  static Future<bool> get skipped async {
    bool ret = await LocalStorage.readBool(_keySkipOnSplash) ?? false;
    dev.log("skipped = $ret", name: "PermissionManager");
    return ret;
  }

  static Future resetSkip() async {
    LocalStorage.delete(_keySkipOnSplash);
  }
}
