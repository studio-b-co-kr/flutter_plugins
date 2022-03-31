import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:remedi/architecture/architecture.dart';

import 'login_viewmodel.dart';

class LoginPage extends ViewModelBuilder<LoginViewModel> {
  static const routeName = '/login';

  final Widget background;

  LoginPage(
      {Key? key, required this.background, required LoginViewModel viewModel})
      : super(key: key, viewModel: viewModel);

  @override
  Widget build(BuildContext context, LoginViewModel read) {
    return background;
  }
}
