import 'dart:developer' as dev;

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:remedi_auth/feature/phone_verification/phone_verification_page.dart';

// ignore: must_be_immutable
class InputPhoneNumberWidget extends StatefulWidget {
  Function(PhoneNumber) onSubmitted;
  Function(bool)? onInputValidated;
  final TextEditingController controller;
  final FocusNode focusNode;
  bool enabled;
  final Color? theme;
  final String? initialCountryCode;

  InputPhoneNumberWidget({
    Key? key,
    this.onInputValidated,
    required this.onSubmitted,
    required this.controller,
    required this.focusNode,
    this.enabled = true,
    this.theme,
    this.initialCountryCode,
  }) : super(key: key);

  @override
  _PhoneNumberInputState createState() => _PhoneNumberInputState();
}

class _PhoneNumberInputState extends State<InputPhoneNumberWidget> {
  PhoneNumber? _phoneNumber;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(children: [
        _textInput(context),
        _textError(),
      ]),
    );
  }

  Widget _textInput(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16),
      child: InternationalPhoneNumberInput(
        focusNode: widget.focusNode,
        textFieldController: widget.controller,
        locale: widget.initialCountryCode,
        autoFocus: true,
        isEnabled: widget.enabled,
        onInputChanged: (number) {
          _phoneNumber = number;
          dev.log(number.phoneNumber ?? "");
        },
        onInputValidated: (bool value) async {
          dev.log("valid = $value");

          if (widget.onInputValidated != null) {
            widget.onInputValidated!(value);
          }

          if (value) widget.onSubmitted(_phoneNumber!);
        },
        selectorConfig: SelectorConfig(
          selectorType: PhoneInputSelectorType.DIALOG,
        ),
        autoValidateMode: AutovalidateMode.disabled,
        selectorTextStyle: TextStyle(
            color: widget.theme == null
                ? Colors.black
                : complementary(widget.theme!),
            fontSize: 16),
        textStyle: TextStyle(
            color: widget.theme == null
                ? Colors.black
                : complementary(widget.theme!),
            fontSize: 20),
        initialValue: PhoneNumber(isoCode: "KR"),
        formatInput: true,
        hintText: hintText(context),
        keyboardType: TextInputType.phone,
        inputBorder: UnderlineInputBorder(),
        cursorColor: Colors.grey,
        spaceBetweenSelectorAndTextField: 0,
        keyboardAction: TextInputAction.go,
        onSubmit: () {
          // TODO somethings...
          int i = 0;
        },
      ),
    );
  }

  Widget _textError() {
    return Container(
      height: 24,
    );
  }

  String hintText(BuildContext context) {
    return "10-1234-5678";
  }
}
