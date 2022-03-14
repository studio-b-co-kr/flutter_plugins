import 'package:example/features/home/home_page.dart';
import 'package:example/features/splash/splash_view_model.dart';
import 'package:flutter/material.dart';
import 'package:remedi_mvvm/remedi_mvvm.dart';

class SplashPage extends ViewModelView<SplashViewModel> {
  static const routeName = '/';

  const SplashPage({
    Key? key,
    required SplashViewModel viewModel,
  }) : super(key: key, viewModel: viewModel);

  @override
  Widget build(BuildContext context, SplashViewModel viewModel) {
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

  @override
  void onActionChanged(BuildContext context, SplashViewModel vm, action) {
    super.onActionChanged(context, vm, action);
    RemediRouter.pushReplacementNamed(HomePage.routeName);
  }
}
