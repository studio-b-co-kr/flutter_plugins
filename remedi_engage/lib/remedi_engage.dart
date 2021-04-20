library remedi_engage;

import 'dart:developer' as dev;

import 'package:firebase_messaging/firebase_messaging.dart';

class FcmManager {
  static String? fcmToken;

  static init() async {
    fcmToken = await FirebaseMessaging.instance.getToken();
    dev.log("$fcmToken", name: "FirebaseMessaging.token");
  }
}

class BranchIoManager {}
