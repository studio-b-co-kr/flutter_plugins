import 'package:flutter/material.dart';
import 'package:remedi_auth/feature/phone_verification/input_phone_number_widget.dart';
import 'package:remedi_auth/viewmodel/i_phone_verification_viewmodel.dart';
import 'package:remedi_widgets/remedi_widgets.dart';
import 'package:stacked_mvvm/stacked_mvvm.dart';

import 'input_code_widget.dart';

class PhoneVerificationView extends IView<IPhoneVerificationViewModel> {
  final String title;
  final String description;

  PhoneVerificationView({
    Key? key,
    required this.title,
    required this.description,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, IPhoneVerificationViewModel viewModel) {
    return Scaffold(
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
        child: SingleChildScrollView(
          child: Column(children: [
            _textGuide(),
            PhoneNumberInputWidget(
              onRequestVerification: (phoneNumber) {},
            ),
            InputCodeWidget(
              inputPhoneVerificationCode: '',
              confirmVerificationCode: '',
            ),
            SizedBox(height: 40)
          ]),
        ),
      ),
    );
  }

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
}
