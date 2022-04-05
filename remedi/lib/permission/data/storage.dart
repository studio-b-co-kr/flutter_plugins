import 'dart:developer' as dev;

import 'package:remedi/remedi.dart';

class PermissionStorage {
  static const keySkipOnSplash = "keySkipOnSplash";

  static Future skip() async {
    return await LocalStorage.writeBool(keySkipOnSplash, true);
  }

  static Future<bool> get skipped async {
    bool ret = await LocalStorage.readBool(keySkipOnSplash) ?? false;
    dev.log("skipped = $ret", name: "PermissionManager");
    return ret;
  }
}
