import 'dart:async';
import 'dart:developer' as dev;

/// AppConfig is in charge of managing product flavor, device info and os info.
import 'dart:io';
import 'dart:ui' as ui;

import 'package:device_info_plus/device_info_plus.dart';
import 'package:firebase_app_installations/firebase_app_installations.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:remedi_flutter/remedi_flutter.dart';

part 'app_log.dart';
part 'remedi_app.dart';
part 'remedi_router.dart';
part 'remedi_uri.dart';
part 'route_generator.dart';

class AppConfig {
  static final Map<String, String> values = {};
  static bool _isRelease = false;
  static String? _endpoint;
  static String? _appVersion;
  static String? _buildNumber;
  static bool _enablePrintLog = !_isRelease;
  static String? _osVersion;
  static int? _osVersionSdk = 0;
  static String? _deviceManufacturer;
  static String? _deviceModel;
  static String? appId;

  static bool get isRelease => _isRelease;

  static String? get endpoint => _endpoint;

  static String? get appVersion => _appVersion;

  static String? get buildNumber => _buildNumber;

  static bool get enablePrintLog => _enablePrintLog;

  static String? get osVersion => _osVersion;

  static int? get osVersionSdk => _osVersionSdk;

  static String? get deviceManufacturer => _deviceManufacturer;

  static String? get deviceModel => _deviceModel;

  // set device info.
  static Future init() async {
    return await Future.wait([
      _setPackageInfo(),
      _setDeviceInfo(),
      _setAppId(),
    ]);
  }

  /// baseUrl, baseWebUrl, endpoint flavor, logging
  /// user set this config in main()
  static setFlavorConfig({
    Map<String, String> urls = const {},
    bool isRelease = false,
    String? endpoint,
    bool enablePrintLog = false,
  }) {
    AppConfig.values.addAll(urls);
    AppConfig._isRelease = isRelease;
    AppConfig._endpoint = endpoint ?? "";
    AppConfig._enablePrintLog = enablePrintLog;
  }

  static String get platform {
    if (Platform.isIOS) {
      return "ios";
    }

    if (Platform.isAndroid) {
      return "android";
    }

    if (Platform.isFuchsia) {
      return "fuchsia";
    }

    if (Platform.isLinux) {
      return "linux";
    }

    if (Platform.isMacOS) {
      return "macOs";
    }

    if (Platform.isWindows) {
      return "windows";
    }

    return "unknown";
  }

  static Future _setPackageInfo() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    AppConfig._appVersion = packageInfo.version;
    AppConfig._buildNumber = packageInfo.buildNumber;
  }

  static Future _setDeviceInfo() async {
    final DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    try {
      if (Platform.isIOS) {
        IosDeviceInfo info = await deviceInfo.iosInfo;
        AppConfig._osVersion = info.systemVersion;
        List<String>? split = AppConfig._osVersion?.split(".");
        if (split != null && split.isNotEmpty) {
          AppConfig._osVersionSdk = int.parse(split[0]);
        }
        AppConfig._deviceManufacturer = "apple";
        AppConfig._deviceModel = info.model;
      }

      if (Platform.isAndroid) {
        AndroidDeviceInfo info = await deviceInfo.androidInfo;
        AppConfig._osVersion = info.version.release;
        AppConfig._osVersionSdk = info.version.sdkInt;
        AppConfig._deviceManufacturer = info.manufacturer;
        AppConfig._deviceModel = info.model;
      }
    } on PlatformException {
      throw Exception();
    }
  }

  static Future _setAppId() async {
    appId = await FirebaseInstallations.instance.getId();
  }

  static void log() async {
    AppLog.log(values.toString(), name: "values");
    AppLog.log("$_isRelease", name: "isRelease");
    AppLog.log(_endpoint ?? "unknown", name: "endpoint");
    AppLog.log(_appVersion ?? "unknown", name: "appVersion");
    AppLog.log(_buildNumber ?? "unknown", name: "buildNumber");
    AppLog.log(platform, name: "platform");
    AppLog.log(_osVersion ?? "unknown", name: "osVersion");
    AppLog.log("$_osVersionSdk", name: "osVersionSdk");
    AppLog.log(_deviceManufacturer ?? "unknown", name: "deviceManufacturer");
    AppLog.log(_deviceModel ?? "unknown", name: "deviceModel");
    AppLog.log(await FirebaseInstallations.instance.getId(), name: "appId");
    AppLog.log("${ui.window.physicalSize.width}", name: "physicalSize.width");
    AppLog.log("${ui.window.devicePixelRatio}", name: "devicePixelRatio");
  }
}
