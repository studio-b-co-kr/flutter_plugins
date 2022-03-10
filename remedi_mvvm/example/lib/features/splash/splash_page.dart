import 'package:example/features/splash/splash_view_model.dart';
import 'package:flutter/material.dart';
import 'package:remedi_mvvm/remedi_mvvm.dart';

class SplashPage extends ViewModelView<SplashViewModel> {
  static const routeName = '/';

  SplashPage({
    Key? key,
    required SplashViewModel vm,
  }) : super(key: key, vm: vm);

  @override
  Widget buildWidget(BuildContext context, SplashViewModel vm) {
    return Scaffold(
      appBar: AppBar(),
      body: const Center(
        child: Text(
          'SPLASH PAGE',
          style: TextStyle(fontSize: 36, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
