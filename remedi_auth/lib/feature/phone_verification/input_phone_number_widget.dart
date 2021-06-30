import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';

// ignore: must_be_immutable
class InputPhoneNumberWidget extends StatefulWidget {
  Function(PhoneNumber) onSubmitted;
  Function(bool)? onInputValidated;
  final TextEditingController controller;
  final FocusNode focusNode;

  InputPhoneNumberWidget({
    Key? key,
    this.onInputValidated,
    required this.onSubmitted,
    required this.controller,
    required this.focusNode,
  }) : super(key: key);

  @override
  PhoneNumberInputState createState() => PhoneNumberInputState();
}

class PhoneNumberInputState extends State<InputPhoneNumberWidget> {
  bool _showRequest = false;
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
        autoFocus: false,
        isEnabled: true,
        onInputChanged: (number) {
          _phoneNumber = number;
          print(number.phoneNumber);
        },
        onInputValidated: (bool value) async {
          if (value == _showRequest) {
            return;
          }

          print(value);

          if (widget.onInputValidated != null) {
            widget.onInputValidated!(value);
          }

          setState(() {
            _showRequest = value;
          });
        },
        selectorConfig: SelectorConfig(
          selectorType: PhoneInputSelectorType.DIALOG,
        ),
        ignoreBlank: false,
        autoValidateMode: AutovalidateMode.disabled,
        selectorTextStyle: TextStyle(color: Colors.black),
        initialValue: PhoneNumber(isoCode: "KR"),
        formatInput: true,
        hintText: hintText(context),
        // keyboardType: TextInputType.phone,
        keyboardType:
            TextInputType.numberWithOptions(signed: true, decimal: false),
        inputBorder: UnderlineInputBorder(),
        spaceBetweenSelectorAndTextField: 0,
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

  bool get showRequest => widget.onInputValidated != null && _showRequest;
}
