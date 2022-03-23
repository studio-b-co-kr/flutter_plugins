import 'package:example/features/home/home_page.dart';
import 'package:example/features/splash/splash_view_model.dart';
import 'package:flutter/material.dart';
import 'package:remedi_architecture/remedi_architecture.dart';

class SplashPage extends ViewModelView<SplashViewModel> {
  static const routeName = '/splash';

  const SplashPage({
    Key? key,
    required ViewModelBuilder<SplashViewModel> viewModelBuilder,
  }) : super(key: key, viewModelBuilder: viewModelBuilder);

  @override
  Widget build(
    BuildContext context,
    SplashViewModel watch,
    SplashViewModel read,
  ) {
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
  void onActionChanged(BuildContext context, action) {
    super.onActionChanged(context, action);
    RemediRouter.pushReplacementNamed(HomePage.routeName);
  }
}
