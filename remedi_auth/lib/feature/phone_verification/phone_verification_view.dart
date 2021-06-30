import 'dart:developer' as dev;

import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:remedi_widgets/remedi_widgets.dart';
import 'package:stacked_mvvm/stacked_mvvm.dart';

import 'input_code_widget.dart';
import 'input_phone_number_widget.dart';

class PhoneVerificationView extends StatefulWidget {
  final String title;
  final String description;
  final StateData<PhoneVerification, PhoneVerificationState> state;

  PhoneVerificationView({
    Key? key,
    required this.title,
    required this.description,
    required this.state,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => PhoneVerificationViewState();
}

class PhoneVerificationViewState extends State<PhoneVerificationView> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final FocusNode _codeInputFocus = FocusNode(
    debugLabel: "code_input",
    onKey: (fn, event) {
      dev.log("node = $fn, event = $event", name: "code_input");
    },
    skipTraversal: true,
    descendantsAreFocusable: false,
    canRequestFocus: true,
  );
  final FocusNode _phoneNumberInputFocus = FocusNode(
    debugLabel: "phone_number_input",
    onKey: (fn, event) {
      dev.log("node = $fn, event = $event", name: "phone_number_input");
    },
    skipTraversal: true,
    descendantsAreFocusable: false,
    canRequestFocus: true,
  );

  final TextEditingController _inputPhoneNumberController =
      TextEditingController();
  final TextEditingController _inputCodeController = TextEditingController();

  final ExpandableController _expandablePhoneNumberController =
      ExpandableController(initialExpanded: true);
  final ExpandableController _expandableCodeController =
      ExpandableController(initialExpanded: false);

  bool _showRequestButton = false;
  bool _showVerifyButton = false;

  PhoneNumber? _phoneNumber;

  @override
  void initState() {
    // _setState(widget.state.state);
    _phoneNumberInputFocus.requestFocus();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
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
              widget.title,
              style: TextStyle(
                color: Colors.grey.shade800,
                fontSize: 16,
              ),
            ),
          ),
          actions: [
            InkWell(
              onTap: () {
                Navigator.of(context).pop();
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

  Widget _textGuide() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 32, horizontal: 16),
      child: FixedScaleText(
        text: Text(
          widget.description,
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
        SizedBox(
          width: 8,
        ),
        Expanded(
          child: FixedScaleText(
            text: Text(
              _phoneNumber?.phoneNumber ?? "",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.grey.shade700,
              ),
            ),
          ),
        ),
        InkWell(
          onTap: () {
            _inputCodeController.text = "";
            _inputPhoneNumberController.text = "";
            _setStateInputPhoneNumber();
            _phoneNumberInputFocus.requestFocus();
          },
          child: Container(
            height: double.maxFinite,
            child: Row(
              children: [
                FixedScaleText(
                  text: Text(
                    "변경하기",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.blue.shade700,
                    ),
                  ),
                ),
              ],
            ),
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
              _phoneNumber = phoneNumber;
            },
            onInputValidated: (value) {
              bool before = _showRequestButton;

              if (before != value) {
                setState(() {
                  _showRequestButton = value;
                });
              }
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
        onCodeChanged: (code) {
          bool before = _showVerifyButton;

          if (before != (code.length == 6)) {
            setState(() {
              _showVerifyButton = code.length == 6;
            });
          }
        },
      ),
      collapsed: Container(),
      controller: _expandableCodeController,
    );
  }

  Widget _message(BuildContext context) {
    Widget child;
    switch (widget.state.state) {
      case PhoneVerificationState.verifying:
        child = Row(
            crossAxisAlignment: CrossAxisAlignment.start,
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
                    "인증코드를 발송했습니다.\n코드를 입력 후 인증을 완료해주세요.",
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
            crossAxisAlignment: CrossAxisAlignment.start,
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
                    "오류가 발생했습니다.",
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
            crossAxisAlignment: CrossAxisAlignment.start,
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
                    "인증이 완료되었습니다.",
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
        padding: EdgeInsets.all(16),
        child: child,
      ),
    );
  }

  Widget _buttons(BuildContext context) {
    if (_showRequestButton &&
        widget.state.state == PhoneVerificationState.inputPhoneNumber) {
      return InkWell(
        onTap: () {
          _showRequestButton = false;
          _setStateInputCode();
          _codeInputFocus.requestFocus();
        },
        child: Container(
          alignment: Alignment.center,
          color: Colors.blue,
          height: 48,
          child: FixedScaleText(
            text: Text(
              "인증코드 요청",
              style: TextStyle(
                  color: Colors.blue.shade50,
                  fontWeight: FontWeight.bold,
                  fontSize: 16),
            ),
          ),
        ),
      );
    }

    if (_showVerifyButton &&
        widget.state.state == PhoneVerificationState.inputCode) {
      return InkWell(
        onTap: () {
          _showVerifyButton = false;
          _setStateVerifying();
          _codeInputFocus.unfocus();
        },
        child: Container(
          alignment: Alignment.center,
          color: Colors.green,
          height: 48,
          child: FixedScaleText(
            text: Text(
              "인증하기",
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

  @override
  void dispose() {
    _codeInputFocus.unfocus();
    _phoneNumberInputFocus.unfocus();
    _codeInputFocus.dispose();
    _phoneNumberInputFocus.dispose();
    _expandableCodeController.dispose();
    _expandablePhoneNumberController.dispose();

    super.dispose();
  }

  // void _setState(PhoneVerificationState state) {
  //   switch (state) {
  //     case PhoneVerificationState.inputPhoneNumber:
  //       _setStateInputPhoneNumber();
  //       break;
  //     case PhoneVerificationState.inputCode:
  //       _setStateInputCode();
  //       break;
  //     case PhoneVerificationState.verifying:
  //       _setStateVerifying();
  //       break;
  //     case PhoneVerificationState.errorOnVerifying:
  //       _setStateErrorOnVerifying();
  //       break;
  //     case PhoneVerificationState.verified:
  //       _setStateVerified();
  //       break;
  //   }
  // }

  void _setStateInputPhoneNumber() async {
    setState(() {
      widget.state.state = PhoneVerificationState.inputPhoneNumber;
    });
    _expandableCodeController.expanded = false;
    _expandablePhoneNumberController.expanded = true;
  }

  void _setStateInputCode() async {
    setState(() {
      widget.state.state = PhoneVerificationState.inputCode;
    });
    _expandableCodeController.expanded = true;
    _expandablePhoneNumberController.expanded = false;
  }

  void _setStateVerifying() {
    setState(() {
      widget.state.state = PhoneVerificationState.verifying;
      _expandableCodeController.expanded = true;
      _expandablePhoneNumberController.expanded = false;
    });
  }

  void _setStateErrorOnVerifying() {
    setState(() {
      widget.state.state = PhoneVerificationState.errorOnVerifying;
      _expandableCodeController.expanded = true;
      _expandablePhoneNumberController.expanded = false;
    });
  }

  void _setStateVerified() {
    setState(() {
      widget.state.state = PhoneVerificationState.verified;
      _expandableCodeController.expanded = false;
      _expandablePhoneNumberController.expanded = false;
    });
  }
}

enum PhoneVerificationState {
  inputPhoneNumber,
  inputCode,
  verifying,
  errorOnVerifying,
  verified,
}

class PhoneVerification {
  String phoneNumber;

  String verificationCode;

  PhoneVerification({
    this.phoneNumber = "",
    this.verificationCode = "",
  });
}
