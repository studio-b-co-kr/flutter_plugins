import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_multi_formatter/flutter_multi_formatter.dart';

class PhoneNumberInput extends StatefulWidget {
  final String countryCode;
  late final double? fontSize;

  PhoneNumberInput({
    Key? key,
    required this.countryCode,
    this.fontSize,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _PhoneNumberInputState();
}

class _PhoneNumberInputState extends State<PhoneNumberInput> {
  GlobalKey<FormFieldState> _textInputKey = GlobalKey<FormFieldState>();

  @override
  Widget build(BuildContext context) {
    PhoneInputFormatter formatter = PhoneNumberFormatter.formatter();
    return MediaQuery(
      data: MediaQueryData(textScaleFactor: 1),
      child: TextFormField(
          key: _textInputKey,
          initialValue: countryCode2CountryNumber[widget.countryCode],
          autocorrect: false,
          autovalidateMode: AutovalidateMode.always,
          enableSuggestions: false,
          style: TextStyle(
            fontSize: widget.fontSize,
          ),
          autofocus: true,
          enableInteractiveSelection: false,
          keyboardType: TextInputType.phone,
          textInputAction: TextInputAction.next,
          // to widget
          onFieldSubmitted: (submitted) {
            print("[REMEDI] onFieldSubmitted:$submitted");
            bool valid = _textInputKey.currentState?.validate() ?? false;
            print("[REMEDI] onFieldSubmitted:valid:$valid");
          },
          onSaved: (saved) {
            print("[REMEDI] onSaved:$saved");
          },
          onChanged: (changed) {
            print("[REMEDI] onChanged:$changed");
            bool valid = _textInputKey.currentState?.validate() ?? false;
            print("[REMEDI] onChanged:valid:$valid");
          },
          validator: (input) {
            print("[REMEDI] validator:$input");

            String? errorMessage =
                PhoneNumberValidator.validate(widget.countryCode, formatter.unmasked);
            return errorMessage;
          },
          inputFormatters: [
            formatter,
          ]),
    );
  }
}

class PhoneNumberFormatter {
  static PhoneInputFormatter formatter() {
    modifyFormatter();
    return PhoneInputFormatter(
      onCountrySelected: (PhoneCountryData? phoneCountryData) {
        print("[REMEDI] onCountrySelected:$phoneCountryData");
      },
      allowEndlessPhone: false,
    );
  }

  static modifyFormatter() {
    PhoneInputFormatter.replacePhoneMask(
      countryCode: 'KR',
      newMask: '+00 (0)00-0000-0000',
    );
    PhoneInputFormatter.addAlternativePhoneMasks(
      countryCode: 'KR',
      alternativeMasks: [
        '+00 (0)00-000-0000',
      ],
    );
  }
}

Map<String, String> countryCode2CountryNumber = {
  "KR": "+82",
};

class PhoneNumberValidator {
  static String? validate(String countryCode, String? phoneNumber) {
    return null;
  }
}
