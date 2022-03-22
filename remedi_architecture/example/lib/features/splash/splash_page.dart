import 'package:example/features/home/home_page.dart';
import 'package:example/features/splash/splash_view_model.dart';
import 'package:flutter/material.dart';
import 'package:remedi_architecture/remedi_architecture.dart';

class SplashPage extends IViewModelView<SplashViewModel> {
  static const routeUri = RouteUri(path: 'splash', authority: 'remedi.com');

  const SplashPage({
    Key? key,
    required SplashViewModel viewModel,
  }) : super(key: key, viewModel: viewModel);

  @override
  Widget build(BuildContext context, SplashViewModel viewModel) {
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
  void onActionChanged(BuildContext context, SplashViewModel vm, action) {
    super.onActionChanged(context, vm, action);
    RemediRouter.pushReplacementUri(HomePage.routeUri);
  }
}
