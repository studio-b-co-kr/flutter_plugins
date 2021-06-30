import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:remedi_auth/feature/phone_verification/phone_verification_view.dart';
import 'package:remedi_auth/viewmodel/i_phone_verification_viewmodel.dart';
import 'package:stacked_mvvm/stacked_mvvm.dart';

class PhoneVerificationPage extends IPage<IPhoneVerificationViewModel> {
  static const routeName = "/phone_verification";

  final String title;
  final String description;
  final StateData<PhoneVerification, PhoneVerificationState> state;

  PhoneVerificationPage({
    Key? key,
    required IPhoneVerificationViewModel viewModel,
    required this.title,
    required this.description,
    required this.state,
  }) : super(key: key, viewModel: viewModel) {}

  @override
  Widget body(BuildContext context, IPhoneVerificationViewModel viewModel,
      Widget? child) {
    return PhoneVerificationView(
      title: title,
      description: description,
      state: state,
    );
  }

  @override
  Future logScreenOpen(String screenName) async {}

  @override
  String get screenName => "phone_verification";
}
