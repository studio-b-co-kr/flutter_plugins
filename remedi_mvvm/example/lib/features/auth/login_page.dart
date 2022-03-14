import 'package:example/features/auth/login_view_model.dart';
import 'package:flutter/material.dart';
import 'package:remedi_mvvm/remedi_mvvm.dart';

class LoginPage extends ViewModelView<LoginViewModel> {
  static const routeName = '/login';

  const LoginPage({Key? key, required LoginViewModel viewModel})
      : super(key: key, viewModel: viewModel);

  @override
  Widget build(BuildContext context, ViewModel viewModel) {
    return const Scaffold();
  }
}
