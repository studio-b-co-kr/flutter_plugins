import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:remedi_auth/viewmodel/i_phone_verification_viewmodel.dart';
import 'package:remedi_widgets/remedi_widgets.dart';
import 'package:stacked_mvvm/stacked_mvvm.dart';

import 'input_code_widget.dart';
import 'input_phone_number_widget.dart';

class PhoneVerificationPage extends IPage<IPhoneVerificationViewModel> {
  static const routeName = "/phone_verification";

  final String title;
  final String description;
  final String messageWaitingAndInputVerificationCode;
  final String messageOnErrorVerifyingInvalid;
  final String messageOnErrorVerifyingExpired;
  final String messageCompleted;
  final String messageChecking;
  final String messageVerify;
  final String messageVerified;
  final String messageChangePhoneNumber;
  final String messageRequestVerificationCode;
  final String messageErrorCodeSent;
  final String messageErrorExit;
  final Function(String phoneNumber) onVerified;
  final String? initialCountryCode;

  final Color? theme;

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
    required this.messageOnErrorVerifyingInvalid,
    required this.messageOnErrorVerifyingExpired,
    required this.messageCompleted,
    required this.messageChecking,
    required this.messageVerify,
    required this.messageVerified,
    required this.messageChangePhoneNumber,
    required this.messageRequestVerificationCode,
    required this.messageErrorCodeSent,
    required this.onVerified,
    required this.messageErrorExit,
    this.theme,
    this.initialCountryCode,
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
      backgroundColor: theme ?? Colors.white,
      appBar: AppBar(
          backgroundColor: theme ?? Colors.white,
          elevation: 1,
          leadingWidth: 0,
          automaticallyImplyLeading: false,
          centerTitle: false,
          toolbarHeight: 40,
          title: FixedScaleText(
            text: Text(
              title,
              style: TextStyle(
                color: theme != null
                    ? complementary(theme!)
                    : Colors.grey.shade800,
                fontSize: 16,
              ),
            ),
          ),
          actions: [
            InkWell(
              onTap: () {
                String? result;
                if (viewModel.state == PhoneVerificationState.verifiedCode) {
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
          _inputPhoneNumber(context, viewModel),
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
                fontSize: 16,
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
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: _showChangePhoneNumber(viewModel)
                        ? Colors.blue.shade700
                        : theme == null
                            ? Colors.grey.shade300
                            : Colors.grey.shade700,
                  ),
                ),
              ),
            ]),
          ),
        )
      ]),
    );
  }

  Widget _inputPhoneNumber(
      BuildContext context, IPhoneVerificationViewModel viewModel) {
    return Expandable(
      controller: _expandablePhoneNumberController,
      expanded: Column(
        children: [
          _textGuide(),
          InputPhoneNumberWidget(
            theme: theme,
            enabled:
                viewModel.state != PhoneVerificationState.requestingSendCode,
            controller: _inputPhoneNumberController,
            onSubmitted: (phoneNumber) {
              viewModel.phoneNumber = phoneNumber;
            },
            onInputValidated: (value) {
              viewModel.onPhoneNumberValidated(value);
            },
            focusNode: _phoneNumberInputFocus,
            // initialCountryCode: initialCountryCode,
            initialCountryCode: initialCountryCode,
          )
        ],
      ),
      collapsed: _changePhoneNumber(context),
    );
  }

  Widget _inputCode(BuildContext context) {
    return Expandable(
      expanded: InputCodeWidget(
        code: viewModel.verificationCode,
        controller: _inputCodeController,
        focusNode: _codeInputFocus,
        onCodeChanged: (code) async {
          viewModel.verificationCodeChanged(code);
        },
        disabled: _enabledInputCode(),
        theme: theme,
      ),
      collapsed: Container(),
      controller: _expandableCodeController,
    );
  }

  bool _enabledInputCode() {
    bool ret = viewModel.state == PhoneVerificationState.verifyingCode ||
        viewModel.state == PhoneVerificationState.verifiedCode;
    return ret;
  }

  Widget _message(BuildContext context) {
    Widget child;
    switch (viewModel.state) {
      case PhoneVerificationState.requestingSendCode:
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
                    messageWaitingAndInputVerificationCode,
                    maxLines: 2,
                    style: TextStyle(
                      fontSize: 16,
                      color: theme == null
                          ? Colors.grey.shade900
                          : complementary(theme!),
                    ),
                  ),
                ),
              ),
            ]);
        break;
      case PhoneVerificationState.errorRequestingSendCode:
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
                    messageErrorCodeSent,
                    style: TextStyle(
                      fontSize: 16,
                      color: theme == null
                          ? Colors.grey.shade900
                          : complementary(theme!),
                    ),
                  ),
                ),
              ),
            ]);
        break;
      case PhoneVerificationState.errorVerifyingCodeInvalid:
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
                    messageOnErrorVerifyingInvalid,
                    style: TextStyle(
                      fontSize: 16,
                      color: theme == null
                          ? Colors.grey.shade900
                          : complementary(theme!),
                    ),
                  ),
                ),
              ),
            ]);
        break;
      case PhoneVerificationState.errorVerifyingCodeExpired:
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
                    messageOnErrorVerifyingExpired,
                    style: TextStyle(
                      fontSize: 16,
                      color: theme == null
                          ? Colors.grey.shade900
                          : complementary(theme!),
                    ),
                  ),
                ),
              ),
            ]);
        break;
      case PhoneVerificationState.verifiedCode:
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
                      fontSize: 16,
                      color: theme == null
                          ? Colors.grey.shade900
                          : complementary(theme!),
                    ),
                  ),
                ),
              ),
            ]);
        break;
      case PhoneVerificationState.verifyingCode:
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
                      fontSize: 16,
                      color: theme == null
                          ? Colors.grey.shade900
                          : complementary(theme!),
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
    if (viewModel.state == PhoneVerificationState.errorRequestingSendCode) {
      return InkWell(
        onTap: () {
          Navigator.of(context).pop();
        },
        child: Container(
          alignment: Alignment.center,
          color: Colors.red,
          height: 48,
          child: FixedScaleText(
            text: Text(
              messageErrorExit,
              style: TextStyle(
                  color: Colors.red.shade50,
                  fontWeight: FontWeight.bold,
                  fontSize: 16),
            ),
          ),
        ),
      );
    }
    if (viewModel.state == PhoneVerificationState.readyToSendCode ||
        viewModel.state == PhoneVerificationState.errorVerifyingCodeExpired) {
      return InkWell(
        onTap: () {
          viewModel.requestSendCode();
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

    if (viewModel.state == PhoneVerificationState.verifiedCode) {
      return InkWell(
        onTap: () {
          String? result;
          if (viewModel.state == PhoneVerificationState.verifiedCode) {
            result = viewModel.phoneNumber.phoneNumber;
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
      case PhoneVerificationState.errorRequestingSendCode:
        ret = true;
        break;
      case PhoneVerificationState.requestingResendingCode:
      case PhoneVerificationState.inputCode:
      case PhoneVerificationState.readyToVerify:
      case PhoneVerificationState.verifyingCode:
      case PhoneVerificationState.errorVerifyingCodeExpired:
      case PhoneVerificationState.errorVerifyingCodeInvalid:
      case PhoneVerificationState.verifiedCode:
      case PhoneVerificationState.waitingCodeReceive:
      case PhoneVerificationState.timeoutWaitingCodeReceive:
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
      case PhoneVerificationState.errorRequestingSendCode:
        ret = false;
        break;
      case PhoneVerificationState.requestingResendingCode:
      case PhoneVerificationState.inputCode:
      case PhoneVerificationState.readyToVerify:
      case PhoneVerificationState.verifyingCode:
      case PhoneVerificationState.errorVerifyingCodeExpired:
      case PhoneVerificationState.errorVerifyingCodeInvalid:
      case PhoneVerificationState.verifiedCode:
      case PhoneVerificationState.waitingCodeReceive:
      case PhoneVerificationState.timeoutWaitingCodeReceive:
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
      case PhoneVerificationState.verifyingCode:
      case PhoneVerificationState.verifiedCode:
      case PhoneVerificationState.requestingSendCode:
        ret = false;
        break;
      case PhoneVerificationState.requestingResendingCode:
      case PhoneVerificationState.inputCode:
      case PhoneVerificationState.readyToVerify:
      case PhoneVerificationState.errorVerifyingCodeExpired:
      case PhoneVerificationState.errorVerifyingCodeInvalid:
      case PhoneVerificationState.errorRequestingSendCode:
      case PhoneVerificationState.waitingCodeReceive:
      case PhoneVerificationState.timeoutWaitingCodeReceive:
        ret = true;
        break;
    }
    return ret;
  }

  @override
  void onListen(BuildContext context, IPhoneVerificationViewModel viewModel) {
    super.onListen(context, viewModel);

    switch (viewModel.state) {
      case PhoneVerificationState.requestingResendingCode:
      case PhoneVerificationState.verifyingCode:
      case PhoneVerificationState.verifiedCode:
      case PhoneVerificationState.waitingCodeReceive:
        if (_codeInputFocus.hasFocus) {
          _codeInputFocus.unfocus();
        }
        if (PhoneVerificationState.verifiedCode == viewModel.state) {
          this.onVerified(viewModel.phoneNumber.phoneNumber!);
        }
        break;

      case PhoneVerificationState.requestingSendCode:
      case PhoneVerificationState.errorRequestingSendCode:
        if (_phoneNumberInputFocus.hasFocus) {
          _phoneNumberInputFocus.unfocus();
        }
        break;

      case PhoneVerificationState.inputCode:
      case PhoneVerificationState.readyToVerify:
      case PhoneVerificationState.timeoutWaitingCodeReceive:
      case PhoneVerificationState.errorVerifyingCodeExpired:
      case PhoneVerificationState.errorVerifyingCodeInvalid:
        if (viewModel.state ==
                PhoneVerificationState.errorVerifyingCodeInvalid ||
            viewModel.state ==
                PhoneVerificationState.errorVerifyingCodeExpired) {
          _inputCodeController.text = "";
        }

        if (!_codeInputFocus.hasFocus) {
          _codeInputFocus.requestFocus();
        }
        break;

      case PhoneVerificationState.inputPhoneNumber:
      case PhoneVerificationState.readyToSendCode:
        if (!_phoneNumberInputFocus.hasFocus) {
          _phoneNumberInputFocus.requestFocus();
        }
        break;
    }
  }
}

Color complementary(Color color) {
  int red = 255 - color.red;
  int green = 255 - color.green;
  int blue = 255 - color.blue;

  return Color.fromARGB(color.alpha, red, green, blue);
}
