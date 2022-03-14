import 'package:example/features/auth/auth_app_model.dart';
import 'package:flutter/material.dart';
import 'package:remedi_mvvm/remedi_mvvm.dart';

class LoginPage extends ViewModelView<AuthAppModel> {
  static const routeName = '/login';

  const LoginPage({Key? key, required AuthAppModel viewModel})
      : super(key: key, viewModel: viewModel);

  @override
  Widget build(BuildContext context, ViewModel viewModel) {
    return const Scaffold();
  }
}
