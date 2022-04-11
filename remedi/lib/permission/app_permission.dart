import 'dart:developer' as dev;

import 'package:flutter/material.dart';
import 'package:notification_permissions/notification_permissions.dart'
    as notification;
import 'package:permission_handler/permission_handler.dart';

class AppPermission {
  final String? title;
  final String? description;
  final Permission permission;
  final String? warningDescription;
  final bool mandatory;

  AppPermissionState state = AppPermissionState.denied;

  AppPermission(
    this.permission, {
    this.title,
    this.description,
    this.warningDescription,
    this.mandatory = false,
  }) : assert(!mandatory ||
            (mandatory &&
                (warningDescription != null && warningDescription.isNotEmpty)));

  PermissionPlatform get platform {
    PermissionPlatform ret = PermissionPlatform.none;
    switch (permission.value) {
      case 0: //calendar
      case 1: //camera
      case 2: //contacts
      case 3: //location
      case 4: //locationAlways
      case 5: //locationWhenInUse
      case 7: //microphone
      case 12: //sensors
      case 13: //sms
      case 14: //speech
      case 15: //storage
      case 16: //ignoreBatteryOptimizations

        ret = PermissionPlatform.both;
        break;

      case 6: //mediaLibrary
      case 9: //photos
      case 10: //photosAddOnly
      case 11: //reminders
      case 17: //notification
      case 21: //bluetooth
      case 25: // appTrackingTransparency
      case 26: // criticalAlerts
        ret = PermissionPlatform.ios;
        break;

      case 8: //phone
      case 18: //accessMediaLocation
      case 19: //activityRecognition
      case 22: // manageExternalStorage
      case 23: // systemAlertWindow
      case 24: // requestInstallPackages
      case 27: // accessNotificationPolicy
        ret = PermissionPlatform.android;
        break;

      case 20: //unknown
      default:
        break;
    }

    return ret;
  }

  Future<AppPermission> get loadStatus async {
    if (permission == Permission.notification) {
      var status = await notification.NotificationPermissions
          .getNotificationPermissionStatus();
      state = status.toAppPermissionState();
    } else {
      state = (await permission.status).toAppPermissionState();
    }
    return this;
  }

  Future<AppPermission> request() async {
    if (permission == Permission.notification) {
      var res = await notification.NotificationPermissions
          .requestNotificationPermissions(
              iosSettings: const notification.NotificationSettingsIos(
                  sound: true, badge: true, alert: true));

      state = res.toAppPermissionState();
    } else {
      var res = await permission.request();
      state = res.toAppPermissionState();
    }

    return this;
  }

  bool get isDenied => state != AppPermissionState.granted;

  bool get isPermanentlyDenied => state == AppPermissionState.permanentlyDenied;

  bool get isGranted => state == AppPermissionState.granted;

  bool get shouldBeGranted => mandatory && state != AppPermissionState.granted;

  String get stateMessage {
    String ret = "";
    switch (state) {
      case AppPermissionState.granted:
        ret = "허용됨";
        break;
      case AppPermissionState.unknown:
      case AppPermissionState.denied:
      case AppPermissionState.permanentlyDenied:
        if (mandatory) {
          ret = warningDescription ?? "";
        } else {
          ret = "해당 권한을 허용해주세요.";
        }
        break;
      default:
        ret = "사용 불가능합니다.";
        break;
    }
    return ret;
  }

  IconData get icon {
    IconData iconData;
    switch (permission.value) {
      case 0: //calendar
        iconData = Icons.calendar_today_sharp;
        break;
      case 1: //camera
        iconData = Icons.camera_alt_outlined;
        break;
      case 2: //contacts
        iconData = Icons.contacts_outlined;
        break;
      case 3: //location
      case 4: //locationAlways
      case 5: //locationWhenInUse
        iconData = Icons.location_on_outlined;
        break;
      case 6: //mediaLibrary
        iconData = Icons.library_music_outlined;
        break;
      case 7: //microphone
        iconData = Icons.mic_none_outlined;
        break;
      case 8: //phone
        iconData = Icons.local_phone_outlined;
        break;
      case 9: //photos
        iconData = Icons.photo_size_select_actual_outlined;
        break;
      case 10: //photosAddOnly
        iconData = Icons.add_a_photo_outlined;
        break;
      case 11: //reminders
        iconData = Icons.access_alarms;
        break;
      case 12: //sensors
        iconData = Icons.device_thermostat;
        break;
      case 13: //sms
        iconData = Icons.sms_outlined;
        break;
      case 14: //speech
        iconData = Icons.connect_without_contact;
        break;
      case 15: //storage
        iconData = Icons.sd_storage_outlined;
        break;
      case 16: //ignoreBatteryOptimizations
        iconData = Icons.battery_alert_rounded;
        break;
      case 17: //notification
        iconData = Icons.notifications_active_outlined;
        break;
      case 18: //accessMediaLocation
        iconData = Icons.mediation_sharp;
        break;
      case 19: //activityRecognition
        iconData = Icons.accessibility;
        break;
      case 21: //bluetooth
        iconData = Icons.bluetooth;
        break;
      case 20: //unknown
      default:
        iconData = Icons.device_unknown_sharp;
        break;
    }

    return iconData;
  }
}

enum PermissionPlatform {
  ios,
  android,
  both,
  none,
}

enum AppPermissionState {
  unknown,
  granted,
  denied,
  permanentlyDenied,
}

extension NotificationPermissionStatusEx on notification.PermissionStatus {
  AppPermissionState toAppPermissionState() {
    PermissionStatus status;
    switch (this) {
      case notification.PermissionStatus.granted:
        status = PermissionStatus.granted;
        break;
      case notification.PermissionStatus.denied:
        status = PermissionStatus.denied;
        break;
      case notification.PermissionStatus.provisional:
        status = PermissionStatus.limited;
        break;
      case notification.PermissionStatus.unknown:
      default:
        status = PermissionStatus.denied;
        break;
    }

    return status.toAppPermissionState();
  }
}

extension PermissionStatusEx on PermissionStatus {
  AppPermissionState toAppPermissionState() {
    AppPermissionState state = AppPermissionState.unknown;
    dev.log(name, name: 'PermissionStatus.toAppPermissionState');
    switch (this) {
      case PermissionStatus.granted:
      case PermissionStatus.limited:
        state = AppPermissionState.granted;
        break;
      case PermissionStatus.denied:
      case PermissionStatus.restricted:
        state = AppPermissionState.denied;
        break;
      case PermissionStatus.permanentlyDenied:
        state = AppPermissionState.permanentlyDenied;
        break;
      default:
        break;
    }
    return state;
  }
}
