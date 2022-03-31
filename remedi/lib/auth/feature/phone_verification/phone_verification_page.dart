import 'package:flutter/material.dart';
import 'package:remedi/auth/feature/phone_verification/phone_verification_view_model.dart';

import '../../../remedi.dart';

class PhoneVerificationPage
    extends ViewModelBuilder<PhoneVerificationViewModel> {
  static const routeName = '/phone_verification';

  PhoneVerificationPage(
      {Key? key, required PhoneVerificationViewModel viewModel})
      : super(key: key, viewModel: viewModel);

  @override
  Widget build(BuildContext context, PhoneVerificationViewModel read) {
    return const Scaffold();
  }
}
