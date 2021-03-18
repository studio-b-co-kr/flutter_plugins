import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:remedi_permission/viewmodel/i_permission_viewmodel.dart';
import 'package:remedi_widgets/remedi_widgets.dart';
import 'package:stacked_mvvm/stacked_mvvm.dart';

class PermissionListItemWidget extends BaseWidget<IPermissionViewModel> {
  PermissionListItemWidget(IPermissionViewModel viewModel)
      : super(viewModel: viewModel);

  @override
  BindingView<IPermissionViewModel> body(
      BuildContext context, IPermissionViewModel viewModel, Widget child) {
    return PermissionListItemView();
  }

  @override
  void onListen(BuildContext context, IPermissionViewModel viewModel) {
    super.onListen(context, viewModel);
  }
}

class PermissionListItemView extends BindingView<IPermissionViewModel> {
  @override
  Widget build(BuildContext context, IPermissionViewModel viewModel) {
    return Card(
      color: _background(viewModel),
      margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      elevation: viewModel.state == PermissionViewState.Granted ? 0 : 4,
      child: InkWell(
        onTap: viewModel.repository.isGranted
            ? null
            : () {
                viewModel.requestPermission();
              },
        child: Container(
          padding: EdgeInsets.only(left: 8, right: 8, top: 8, bottom: 16),
          width: double.infinity,
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Row(mainAxisAlignment: MainAxisAlignment.start, children: [
              Container(
                margin: EdgeInsets.only(right: 8),
                child: SizedBox(
                  height: 36,
                  width: 36,
                  child: viewModel.icon ?? _permissionIcon(viewModel),
                ),
              ),
              Container(
                  child: FixedScaleText(
                      text: Text(
                viewModel.title,
                style: TextStyle(
                    color: Colors.blueGrey.shade700,
                    fontSize: 16,
                    fontWeight: FontWeight.bold),
              ))),
            ]),
            SizedBox(height: 16),
            Container(
                margin: EdgeInsets.only(left: 8),
                child: Text(viewModel.description)),
            SizedBox(height: 16),
            Container(
              margin: EdgeInsets.only(left: 8),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  _action(viewModel),
                  SizedBox(width: 8),
                  Expanded(
                      child:
                          FixedScaleText(text: Text(viewModel.statusMessage)))
                ],
              ),
            ),
            viewModel.repository.isPermanentlyDenied
                ? Container(
                    margin: EdgeInsets.only(top: 16, left: 8),
                    child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          FixedScaleText(
                              text: Text(
                            "앱 세팅에서 가서 권한을 부여해주세요",
                            style: TextStyle(
                                color: Colors.blue.shade700,
                                fontSize: 14,
                                fontWeight: FontWeight.bold),
                          )),
                          Icon(Icons.arrow_forward_ios_sharp,
                              color: Colors.blue.shade700, size: 16)
                        ]),
                  )
                : Container(),
          ]),
        ),
      ),
    );
  }

  double _elevation(IPermissionViewModel viewModel) {
    double ret = 4;
    return ret;
  }

  Color _background(IPermissionViewModel viewModel) {
    Color ret = Colors.amber.shade50;
    switch (viewModel.state) {
      case PermissionViewState.Init:
        break;
      case PermissionViewState.Granted:
      case PermissionViewState.Limited:
        ret = Colors.grey.shade50;
        break;
      case PermissionViewState.Denied:
      case PermissionViewState.PermanentlyDenied:
        ret = Colors.grey.shade50;
        break;
      case PermissionViewState.Restricted:
      case PermissionViewState.Disabled:
        ret = Colors.grey.shade50;
        break;
      case PermissionViewState.Error:
        ret = Colors.red.shade50;
        break;
    }
    return ret;
  }

  Widget _action(IPermissionViewModel viewModel) {
    IconData icon = Icons.check_circle_outline;
    Color iconColor = Colors.grey;
    switch (viewModel.state) {
      case PermissionViewState.Init:
        break;
      case PermissionViewState.Granted:
      case PermissionViewState.Limited:
        iconColor = Colors.green;
        break;
      case PermissionViewState.Denied:
      case PermissionViewState.PermanentlyDenied:
        icon = Icons.error_outline_sharp;
        iconColor = Colors.grey;
        break;
      case PermissionViewState.Error:
        icon = Icons.error_outline_sharp;
        iconColor = Colors.red;
        break;
      case PermissionViewState.Restricted:
      case PermissionViewState.Disabled:
        break;
    }
    return Icon(
      icon,
      size: 20,
      color: iconColor,
    );
  }

  String _resultMessage(IPermissionViewModel viewModel) {
    String message = "";

    return message;
  }

  Color _textColor(IPermissionViewModel viewModel) {
    Color ret = Colors.blueGrey.shade700;

    return ret;
  }

  Widget _permissionIcon(IPermissionViewModel viewModel) {
    IconData iconData;
    switch (viewModel.repository.permission.permission.value) {
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

    return Icon(
      iconData,
      color: Colors.blueGrey.shade700,
    );
  }
}
