import 'package:flutter/widgets.dart';
import 'package:permission_handler/permission_handler.dart';

class AppPermission {
  final Widget icon;
  final String title;
  final String description;
  final bool mandatory;
  final Permission permission;
  final String errorDescription;

  AppPermission(
    this.permission, {
    this.icon,
    this.title,
    this.description,
    this.errorDescription,
    this.mandatory = false,
  })  : assert(permission != null),
        assert(!mandatory ||
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
        ret = PermissionPlatform.ios;
        break;

      case 8: //phone
      case 18: //accessMediaLocation
      case 19: //activityRecognition
        ret = PermissionPlatform.android;
        break;

      case 20: //unknown
      default:
        break;
    }
    return ret;
  }
}

extension PermissionEx on AppPermission {
  Future<bool> get isError async => mandatory && !await permission.isGranted;

  Future<bool> get isGranted async => await permission.isGranted;

  Future<PermissionStatus> get status async => await permission.status;
}

enum PermissionPlatform {
  ios,
  android,
  both,
  none,
}

/*

  /// Android: Calendar
  /// iOS: Calendar (Events)
  static const calendar = Permission._(0);

  /// Android: Camera
  /// iOS: Photos (Camera Roll and Camera)
  static const camera = Permission._(1);

  /// Android: Contacts
  /// iOS: AddressBook
  static const contacts = Permission._(2);

  /// Android: Fine and Coarse Location
  /// iOS: CoreLocation (Always and WhenInUse)
  static const location = PermissionWithService._(3);

  /// Android:
  ///   When running on Android < Q: Fine and Coarse Location
  ///   When running on Android Q and above: Background Location Permission
  /// iOS: CoreLocation - Always
  static const locationAlways = PermissionWithService._(4);

  /// Android: Fine and Coarse Location
  /// iOS: CoreLocation - WhenInUse
  static const locationWhenInUse = PermissionWithService._(5);

  /// Android: None
  /// iOS: MPMediaLibrary
  static const mediaLibrary = Permission._(6);

  /// Android: Microphone
  /// iOS: Microphone
  static const microphone = Permission._(7);

  /// Android: Phone
  /// iOS: Nothing
  static const phone = PermissionWithService._(8);

  /// Android: Nothing
  /// iOS: Photos
  /// iOS 14+ read & write access level
  static const photos = Permission._(9);

  /// Android: Nothing
  /// iOS: Photos
  /// iOS 14+ read & write access level
  static const photosAddOnly = Permission._(10);

  /// Android: Nothing
  /// iOS: Reminders
  static const reminders = Permission._(11);

  /// Android: Body Sensors
  /// iOS: CoreMotion
  static const sensors = Permission._(12);

  /// Android: Sms
  /// iOS: Nothing
  static const sms = Permission._(13);

  /// Android: Microphone
  /// iOS: Speech
  static const speech = Permission._(14);

  /// Android: External Storage
  /// iOS: Access to folders like `Documents` or `Downloads`. Implicitly
  /// granted.
  static const storage = Permission._(15);

  /// Android: Ignore Battery Optimizations
  static const ignoreBatteryOptimizations = Permission._(16);

  /// Android: Notification
  /// iOS: Notification
  static const notification = Permission._(17);

  /// Android: Allows an application to access any geographic locations
  /// persisted in the user's shared collection.
  static const accessMediaLocation = Permission._(18);

  /// When running on Android Q and above: Activity Recognition
  /// When running on Android < Q: Nothing
  /// iOS: Nothing
  static const activityRecognition = Permission._(19);

  /// The unknown only used for return type, never requested
  static const unknown = Permission._(20);

  /// iOS 13 and above: The authorization state of Core Bluetooth manager.
  /// When running < iOS 13 or Android this is always allowed.
  static const bluetooth = Permission._(21);
 */
