import 'package:example/features/home/home_page.dart';
import 'package:example/features/splash/splash_view_model.dart';
import 'package:flutter/material.dart';
import 'package:remedi/remedi.dart';

class SplashPage extends ViewModelBuilder<SplashViewModel> {
  static const routeName = '/splash';

  SplashPage({
    Key? key,
    required SplashViewModel viewModel,
  }) : super(key: key, viewModel: viewModel);

  @override
  Widget build(BuildContext context, SplashViewModel read) {
    return const Scaffold(
      body: Center(
        child: Text(
          'SPLASH PAGE',
          style: TextStyle(fontSize: 36, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  @override
  void onActionReceived(BuildContext context, action) {
    super.onActionReceived(context, action);
    RemediRouter.pushReplacementNamed(HomePage.routeName);
  }
}
