import 'package:flutter/widgets.dart';
import 'package:permission_handler/permission_handler.dart';

class AppPermission {
  final Widget? icon;
  final String? title;
  final String? description;
  final Permission permission;
  final String? errorDescription;
  final bool mandatory;

  AppPermission(
    this.permission, {
    this.icon,
    this.title,
    this.description,
    this.errorDescription,
    this.mandatory = false,
  }) : assert(!mandatory ||
            (mandatory &&
                (errorDescription != null && errorDescription.isNotEmpty)));

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

  Future<PermissionStatus> request() async {
    if (permission == Permission.notification) {
      final status = await Permission.notification.request();

      if (status.isGranted) {
        return PermissionStatus.granted;
      } else if (status.isDenied) {
        return PermissionStatus.denied;
      } else if (status.isPermanentlyDenied) {
        return PermissionStatus.denied;
      }
    }

    return await permission.request();
  }

  Future<PermissionStatus> get status async {
    if (permission == Permission.notification) {
      var status = await Permission.notification.status;
      if (status.isGranted) {
        return PermissionStatus.granted;
      } else if (status.isDenied) {
        return PermissionStatus.denied;
      } else if (status.isPermanentlyDenied) {
        return PermissionStatus.denied;
      }
    }
    return await permission.status;
  }
}

extension PermissionEx on AppPermission {
  Future<bool> get isError async {
    return mandatory && !await isGranted;
  }

  Future<bool> get isGranted async {
    if (permission == Permission.notification) {
      var permissionStatus = await status;
      return (permissionStatus == PermissionStatus.granted ||
          permissionStatus == PermissionStatus.limited);
    }
    return await permission.isGranted;
  }
}

enum PermissionPlatform {
  ios,
  android,
  both,
  none,
}
