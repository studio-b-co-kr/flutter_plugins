import 'package:example/features/auth/auth_app_model.dart';
import 'package:flutter/material.dart';
import 'package:remedi_mvvm/remedi_mvvm.dart';

class LoginPage extends ViewModelView<AuthAppModel> {
  static const routeName = '/login';

  LoginPage({Key? key, required AuthAppModel vm}) : super(key: key, vm: vm);

  @override
  Widget buildWidget(BuildContext context, ViewModel vm) {
    return const Scaffold();
  }
}
