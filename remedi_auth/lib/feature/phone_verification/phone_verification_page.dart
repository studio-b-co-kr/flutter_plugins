import 'package:flutter/widgets.dart';
import 'package:remedi_auth/feature/phone_verification/phone_verification_view.dart';
import 'package:remedi_auth/viewmodel/i_phone_verification_viewmodel.dart';
import 'package:stacked_mvvm/stacked_mvvm.dart';

class PhoneVerificationPage extends BasePage<IPhoneVerificationViewModel> {
  static const routeName = "/phone_verification";
  final String information;

  PhoneVerificationPage(
      {Key? key,
      required IPhoneVerificationViewModel viewModel,
      required this.information})
      : super(key: key, viewModel: viewModel);

  @override
  BindingView<IPhoneVerificationViewModel> body(BuildContext context,
      IPhoneVerificationViewModel viewModel, Widget? child) {
    return PhoneVerificationView(information: information);
  }

  @override
  Future logScreenOpen(String screenName) async {}

  @override
  String get screenName => "phone_verification";
}
