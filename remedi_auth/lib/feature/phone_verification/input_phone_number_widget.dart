import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:remedi_widgets/remedi_widgets.dart';

// ignore: must_be_immutable
class PhoneNumberInputWidget extends StatefulWidget {
  Function(String) onRequestVerification;
  FocusNode? focusNode;

  PhoneNumberInputWidget({
    Key? key,
    required this.onRequestVerification,
    this.focusNode,
  }) : super(key: key);

  @override
  PhoneNumberInputState createState() => PhoneNumberInputState();
}

class PhoneNumberInputState extends State<PhoneNumberInputWidget> {
  bool _showRequest = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(children: [
        _textInput(context),
        _textError(),
        Container(
          child: _requestVerificationCode(),
        )
      ]),
    );
  }

  Widget _textInput(BuildContext context) {
    return Container(
        padding: EdgeInsets.symmetric(horizontal: 16),
        child: InternationalPhoneNumberInput(
          autoFocus: true,
          onInputChanged: (number) {
            print(number.phoneNumber);
          },
          onInputValidated: (bool value) async {
            print(value);
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
          // textFieldController: controller,
          formatInput: true,
          hintText: hintText(context),
          keyboardType:
              TextInputType.numberWithOptions(signed: true, decimal: true),
          inputBorder: UnderlineInputBorder(),
          onSaved: (number) {
            print('On Saved: $number');
          },

          spaceBetweenSelectorAndTextField: 0,
        ));
  }

  Widget _textError() {
    return Container(
      height: 24,
    );
  }

  Widget _requestVerificationCode() {
    return Container(
        height: 40,
        child: _showRequest
            ? InkWell(
                child: Container(
                  height: 40,
                  padding: EdgeInsets.symmetric(vertical: 8, horizontal: 8),
                  child:
                      Row(mainAxisAlignment: MainAxisAlignment.end, children: [
                    FixedScaleText(
                      text: Text(
                        "인증코드 요청",
                        style: TextStyle(
                          height: 1.3,
                          color: Colors.blue.shade700,
                        ),
                      ),
                    ),
                    Icon(
                      Icons.navigate_next,
                      color: Colors.blue.shade600,
                    )
                  ]),
                ),
              )
            : Container());
  }

  String hintText(BuildContext context) {
    return "10-1234-5678";
  }
}
