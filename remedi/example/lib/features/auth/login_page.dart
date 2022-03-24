import 'package:example/features/auth/login_view_model.dart';
import 'package:flutter/material.dart';
import 'package:remedi/remedi.dart';

class LoginPage extends ViewModelBuilder<LoginViewModel> {
  static const routeName = '/login';

  LoginPage({
    Key? key,
    required LoginViewModel viewModel,
  }) : super(key: key, viewModel: viewModel);

  @override
  Widget build(BuildContext context, LoginViewModel read) {
    return const Scaffold();
  }
}