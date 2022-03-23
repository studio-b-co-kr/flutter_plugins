import 'package:example/features/auth/login_view_model.dart';
import 'package:flutter/material.dart';
import 'package:remedi_architecture/remedi_architecture.dart';

class LoginPage extends ViewModelView<LoginViewModel> {
  static const routeName = '/login';

  const LoginPage({
    Key? key,
    required ViewModelBuilder<LoginViewModel> viewModelBuilder,
  }) : super(
          key: key,
          viewModelBuilder: viewModelBuilder,
        );

  @override
  Widget build(
      BuildContext context, LoginViewModel watch, LoginViewModel read) {
    return const Scaffold();
  }
}
