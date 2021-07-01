import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:remedi_auth/viewmodel/i_phone_verification_viewmodel.dart';
import 'package:remedi_widgets/text.dart';
import 'package:stacked_mvvm/stacked_mvvm.dart';

import 'input_code_widget.dart';
import 'input_phone_number_widget.dart';

class PhoneVerificationPage extends IPage<IPhoneVerificationViewModel> {
  static const routeName = "/phone_verification";

  final String title;
  final String description;
  final String messageWaitingAndInputVerificationCode;
  final String messageOnErrorVerifying;
  final String messageCompleted;
  final String messageChecking;
  final String messageVerify;
  final String messageVerified;
  final String messageChangePhoneNumber;
  final String messageRequestVerificationCode;
  final Function(String phoneNumber) onVerified;

  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final FocusNode _codeInputFocus = FocusNode();
  final FocusNode _phoneNumberInputFocus = FocusNode();

  final TextEditingController _inputPhoneNumberController =
      TextEditingController();
  final TextEditingController _inputCodeController = TextEditingController();

  final ExpandableController _expandablePhoneNumberController =
      ExpandableController(initialExpanded: true);
  final ExpandableController _expandableCodeController =
      ExpandableController(initialExpanded: false);

  PhoneVerificationPage({
    Key? key,
    required IPhoneVerificationViewModel viewModel,
    required this.title,
    required this.description,
    required this.messageWaitingAndInputVerificationCode,
    required this.messageOnErrorVerifying,
    required this.messageCompleted,
    required this.messageChecking,
    required this.messageVerify,
    required this.messageVerified,
    required this.messageChangePhoneNumber,
    required this.messageRequestVerificationCode,
    required this.onVerified,
  }) : super(key: key, viewModel: viewModel) {}

  @override
  Widget body(
    BuildContext context,
    IPhoneVerificationViewModel viewModel,
    Widget? child,
  ) {
    _expandablePhoneNumberController.expanded =
        _expandInputPhoneNumber(viewModel);
    _expandableCodeController.expanded = _expandInputCode(viewModel);

    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Colors.white,
      appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 1,
          leadingWidth: 0,
          automaticallyImplyLeading: false,
          centerTitle: false,
          toolbarHeight: 40,
          title: FixedScaleText(
            text: Text(
              title,
              style: TextStyle(
                color: Colors.grey.shade800,
                fontSize: 16,
              ),
            ),
          ),
          actions: [
            InkWell(
              onTap: () {
                String? result;
                if (viewModel.state == PhoneVerificationState.verified) {
                  result = viewModel.phoneNumber.phoneNumber;
                }
                Navigator.of(context).pop(result);
              },
              child: Container(
                padding: EdgeInsets.all(8),
                child: Icon(
                  Icons.close,
                  color: Colors.grey.shade800,
                  size: 20,
                ),
              ),
            )
          ]),
      body: SafeArea(
        child: Column(children: [
          _inputPhoneNumber(context),
          _inputCode(context),
          _message(context),
          _buttons(context),
        ]),
      ),
    );
  }

  @override
  Future logScreenOpen(String screenName) async {}

  @override
  String get screenName => "phone_verification";

  Widget _textGuide() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 32, horizontal: 16),
      child: FixedScaleText(
        text: Text(
          description,
          style: TextStyle(
            color: Colors.grey.shade700,
            fontSize: 14,
          ),
        ),
      ),
    );
  }

  Widget _changePhoneNumber(BuildContext context) {
    return Container(
      height: 48,
      alignment: Alignment.centerLeft,
      padding: EdgeInsets.only(left: 8, right: 8),
      child: Row(children: [
        Icon(
          Icons.send_to_mobile,
          color: Colors.grey.shade700,
          size: 24,
        ),
        SizedBox(width: 8),
        Expanded(
          child: FixedScaleText(
            text: Text(
              viewModel.phoneNumber.phoneNumber ?? "",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.grey.shade700,
              ),
            ),
          ),
        ),
        InkWell(
          onTap: _showChangePhoneNumber(viewModel)
              ? () {
                  _inputCodeController.text = "";
                  _inputPhoneNumberController.text = "";
                  viewModel.changePhoneNumber();
                }
              : null,
          child: Container(
            height: double.maxFinite,
            child: Row(children: [
              FixedScaleText(
                text: Text(
                  messageChangePhoneNumber,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: _showChangePhoneNumber(viewModel)
                        ? Colors.blue.shade700
                        : Colors.grey.shade300,
                  ),
                ),
              ),
            ]),
          ),
        )
      ]),
    );
  }

  Widget _inputPhoneNumber(BuildContext context) {
    return Expandable(
      controller: _expandablePhoneNumberController,
      expanded: Column(
        children: [
          _textGuide(),
          InputPhoneNumberWidget(
            controller: _inputPhoneNumberController,
            onSubmitted: (phoneNumber) {
              viewModel.phoneNumber = phoneNumber;
            },
            onInputValidated: (value) {
              viewModel.onPhoneNumberValidated(value);
            },
            focusNode: _phoneNumberInputFocus,
          )
        ],
      ),
      collapsed: _changePhoneNumber(context),
    );
  }

  Widget _inputCode(BuildContext context) {
    return Expandable(
      expanded: InputCodeWidget(
        controller: _inputCodeController,
        focusNode: _codeInputFocus,
        onCodeChanged: (code) async {
          viewModel.verificationCodeChanged(code);
        },
      ),
      collapsed: Container(),
      controller: _expandableCodeController,
    );
  }

  Widget _message(BuildContext context) {
    Widget child;
    switch (viewModel.state) {
      case PhoneVerificationState.inputCode:
        child = Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                margin: EdgeInsets.symmetric(vertical: 2),
                height: 28,
                width: 28,
                alignment: Alignment.center,
                child: Icon(
                  Icons.circle_notifications,
                  color: Colors.yellow.shade900,
                  size: 28,
                ),
              ),
              SizedBox(width: 8),
              Container(
                child: FixedScaleText(
                  text: Text(
                    messageWaitingAndInputVerificationCode,
                    maxLines: 2,
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey.shade900,
                    ),
                  ),
                ),
              ),
            ]);
        break;
      case PhoneVerificationState.errorOnVerifying:
        child = Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                margin: EdgeInsets.symmetric(vertical: 2),
                height: 28,
                width: 28,
                alignment: Alignment.center,
                child: Icon(
                  Icons.error_outline,
                  color: Colors.red,
                  size: 28,
                ),
              ),
              SizedBox(width: 8),
              Container(
                child: FixedScaleText(
                  text: Text(
                    messageOnErrorVerifying,
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey.shade900,
                    ),
                  ),
                ),
              ),
            ]);
        break;
      case PhoneVerificationState.verified:
        child = Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                margin: EdgeInsets.symmetric(vertical: 2),
                height: 28,
                width: 28,
                alignment: Alignment.center,
                child: Icon(
                  Icons.check_circle_outline,
                  color: Colors.green,
                  size: 28,
                ),
              ),
              SizedBox(width: 8),
              Container(
                child: FixedScaleText(
                  text: Text(
                    messageVerified,
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey.shade900,
                    ),
                  ),
                ),
              ),
            ]);
        break;
      case PhoneVerificationState.verifying:
        child = Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                margin: EdgeInsets.symmetric(vertical: 2),
                height: 28,
                width: 28,
                alignment: Alignment.center,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                ),
              ),
              SizedBox(width: 8),
              Container(
                child: FixedScaleText(
                  text: Text(
                    messageChecking,
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey.shade900,
                    ),
                  ),
                ),
              ),
            ]);
        break;
      default:
        child = Container();
        break;
    }
    return Expanded(
      child: Container(
        alignment: Alignment.topLeft,
        padding: EdgeInsets.all(16),
        child: child,
      ),
    );
  }

  Widget _buttons(BuildContext context) {
    if (viewModel.state == PhoneVerificationState.readyToSendCode) {
      return InkWell(
        onTap: () {
          viewModel.requestSendCode();
          // _codeInputFocus.requestFocus();
        },
        child: Container(
          alignment: Alignment.center,
          color: Colors.blue,
          height: 48,
          child: FixedScaleText(
            text: Text(
              messageRequestVerificationCode,
              style: TextStyle(
                  color: Colors.blue.shade50,
                  fontWeight: FontWeight.bold,
                  fontSize: 16),
            ),
          ),
        ),
      );
    }

    if (viewModel.state == PhoneVerificationState.readyToVerify) {
      return InkWell(
        onTap: () {
          viewModel.requestVerify();
          _codeInputFocus.unfocus();
        },
        child: Container(
          alignment: Alignment.center,
          color: Colors.green,
          height: 48,
          child: FixedScaleText(
            text: Text(
              messageVerify,
              style: TextStyle(
                  color: Colors.blue.shade50,
                  fontWeight: FontWeight.bold,
                  fontSize: 16),
            ),
          ),
        ),
      );
    }

    if (viewModel.state == PhoneVerificationState.verified) {
      return InkWell(
        onTap: () {
          String? result;
          if (viewModel.state == PhoneVerificationState.verified) {
            // result = viewModel.phoneNumber.phoneNumber;
          }
          Navigator.of(context).pop(result);
        },
        child: Container(
          alignment: Alignment.center,
          color: Colors.green,
          height: 48,
          child: FixedScaleText(
            text: Text(
              messageCompleted,
              style: TextStyle(
                  color: Colors.blue.shade50,
                  fontWeight: FontWeight.bold,
                  fontSize: 16),
            ),
          ),
        ),
      );
    }

    return Container();
  }

  bool _expandInputPhoneNumber(IPhoneVerificationViewModel viewModel) {
    bool ret = false;
    switch (viewModel.state) {
      case PhoneVerificationState.inputPhoneNumber:
      case PhoneVerificationState.readyToSendCode:
      case PhoneVerificationState.requestingSendCode:
      case PhoneVerificationState.errorOnRequest:
        ret = true;
        break;
      case PhoneVerificationState.inputCode:
      case PhoneVerificationState.readyToVerify:
      case PhoneVerificationState.verifying:
      case PhoneVerificationState.errorOnVerifying:
      case PhoneVerificationState.verified:
      case PhoneVerificationState.timeout:
        ret = false;
        break;
    }
    return ret;
  }

  bool _expandInputCode(IPhoneVerificationViewModel viewModel) {
    bool ret = false;
    switch (viewModel.state) {
      case PhoneVerificationState.inputPhoneNumber:
      case PhoneVerificationState.readyToSendCode:
      case PhoneVerificationState.requestingSendCode:
      case PhoneVerificationState.errorOnRequest:
        ret = false;
        break;
      case PhoneVerificationState.inputCode:
      case PhoneVerificationState.readyToVerify:
      case PhoneVerificationState.verifying:
      case PhoneVerificationState.errorOnVerifying:
      case PhoneVerificationState.verified:
      case PhoneVerificationState.timeout:
        ret = true;
        break;
    }
    return ret;
  }

  bool _showChangePhoneNumber(IPhoneVerificationViewModel viewModel) {
    bool ret = false;
    switch (viewModel.state) {
      case PhoneVerificationState.inputPhoneNumber:
      case PhoneVerificationState.readyToSendCode:
      case PhoneVerificationState.verifying:
      case PhoneVerificationState.verified:
      case PhoneVerificationState.requestingSendCode:
        ret = false;
        break;
      case PhoneVerificationState.inputCode:
      case PhoneVerificationState.readyToVerify:
      case PhoneVerificationState.errorOnVerifying:
      case PhoneVerificationState.errorOnRequest:
      case PhoneVerificationState.timeout:
        ret = true;
        break;
    }
    return ret;
  }

  @override
  void onListen(BuildContext context, IPhoneVerificationViewModel viewModel) {
    super.onListen(context, viewModel);

    switch (viewModel.state) {

      case PhoneVerificationState.inputCode:
        if (!_codeInputFocus.hasFocus) {
          _codeInputFocus.requestFocus();
        }
        break;

      case PhoneVerificationState.verified:
        this.onVerified(viewModel.phoneNumber.phoneNumber!);
        break;
      case PhoneVerificationState.requestingSendCode:
      case PhoneVerificationState.errorOnRequest:
      case PhoneVerificationState.timeout:
      case PhoneVerificationState.readyToVerify:
      case PhoneVerificationState.verifying:
      case PhoneVerificationState.errorOnVerifying:
      case PhoneVerificationState.inputPhoneNumber:
      case PhoneVerificationState.readyToSendCode:
        break;
    }
  }
}
