import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_multi_formatter/flutter_multi_formatter.dart';
import 'package:remedi_auth/viewmodel/i_phone_verification_viewmodel.dart';
import 'package:remedi_widgets/remedi_widgets.dart';
import 'package:stacked_mvvm/stacked_mvvm.dart';

class PhoneVerificationView extends IView<IPhoneVerificationViewModel> {
  final String information;
  final GlobalKey<FormFieldState> _textInputKey = GlobalKey<FormFieldState>();

  PhoneVerificationView({Key? key, required this.information})
      : super(key: key);

  @override
  Widget build(BuildContext context, IPhoneVerificationViewModel viewModel) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: FixedScaleText(
          text: Text("전화번호 인증"),
        ),
      ),
      body: SafeArea(
        child: Container(
          child: Column(children: [
            _textGuide(),
            _textInput(context),
            _textError(),
          ]),
        ),
      ),
    );
  }

  Widget _textGuide() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 16, horizontal: 16),
      child: FixedScaleText(
        text: Text(
          information,
          style: TextStyle(fontSize: 16),
        ),
      ),
    );
  }

  final PhoneInputFormatter phoneInputFormatter = PhoneInputFormatter(
      onCountrySelected: (PhoneCountryData? phoneCountryData) {},
      allowEndlessPhone: false);

  Widget _textInput(BuildContext context) {
    PhoneNumberFormatter.modFormatter();
    return Container(
        margin: EdgeInsets.all(16),
        child: MediaQuery(
          data: MediaQueryData(textScaleFactor: 1),
          child: TextFormField(
              key: _textInputKey,
              initialValue: "+82",
              autofocus: true,
              enableInteractiveSelection: false,
              onFieldSubmitted: (submitted) {
                print("[REMEDI] onFieldSubmitted:$submitted");
              },
              onEditingComplete: () {
                print("[REMEDI] onEditingComplete");
              },
              keyboardType: TextInputType.phone,
              onSaved: (saved) {
                print("[REMEDI] onSaved:$saved");
              },
              onChanged: (changed) {
                print("[REMEDI] onChanged:$changed");
                _textInputKey.currentState?.validate();
              },
              validator: (input) {
                String phoneNumber = phoneInputFormatter.unmasked;
                return null;
              },
              inputFormatters: [
                // phoneInputFormatter,
                // PhoneNumberFormatter(),
                MaskedInputFormatter('###-0000-#####',
                    anyCharMatcher: RegExp(r'[0-9]'))
              ]),
        ));
  }

  Widget _textError() {
    return Container();
  }
}

class PhoneNumberFormatter {
  static modFormatter() {
    PhoneInputFormatter.replacePhoneMask(
        countryCode: "KR", newMask: "+00 (0)00 0000 0000");
    PhoneInputFormatter.addAlternativePhoneMasks(
        countryCode: "KR",
        alternativeMasks: [
          "+00 (0)00 000 0000",
          "+00 (0)00 000 0000",
        ]);
  }
}
