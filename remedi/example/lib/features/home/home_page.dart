import 'package:example/app_models/color_app_model.dart';
import 'package:example/app_models/settings_app_model.dart';
import 'package:example/features/home/home_view_model.dart';
import 'package:example/features/home/widgets/counter_widget.dart';
import 'package:example/features/home/widgets/login_button_widget.dart';
import 'package:example/features/home/widgets/login_state_widget.dart';
import 'package:flutter/material.dart';
import 'package:remedi/remedi.dart';

class HomePage extends ViewModelBuilder<HomeViewModel> {
  static const String routeName = '/home';

  const HomePage({
    Key? key,
    required HomeViewModel viewModel,
  }) : super(key: key, viewModel: viewModel);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.watch<ColorAppModel>().color,
      appBar: AppBar(
        title: const Text('Remedi Architecture'),
      ),
      body: Column(children: [
        const Expanded(
          child: Center(
            child: LoginStateWidget(),
          ),
        ),
        Container(
          padding: const EdgeInsets.all(16),
          child: const LoginButtonWidget(),
        ),
        const Expanded(
          child: Center(
            child: CountWidget(),
          ),
        ),
        Container(
          padding: const EdgeInsets.all(16),
          child: MaterialButton(
            minWidth: double.infinity,
            color: Colors.blue,
            height: 48,
            onPressed: () {
              viewModel.increase();
            },
            child: const Text('Increase count'),
          ),
        ),
        Container(
          padding: const EdgeInsets.all(16),
          child: MaterialButton(
            minWidth: double.infinity,
            color: Colors.grey,
            height: 48,
            onPressed: () {
              context.read<SettingsAppModel>().toggleThemeMode();
            },
            child: const Text('Toggle Theme'),
          ),
        ),
        Container(
          padding: const EdgeInsets.all(16),
          child: MaterialButton(
            minWidth: double.infinity,
            color: Colors.green,
            height: 48,
            onPressed: () {
              context.read<ColorAppModel>().toggleColor();
            },
            child: const Text('Toggle Color'),
          ),
        ),
        Row(children: [
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(16),
              child: MaterialButton(
                minWidth: double.infinity,
                color: Colors.yellow.shade900,
                height: 48,
                onPressed: () {
                  viewModel.goContents();
                },
                child: const Text('Go View Examples'),
              ),
            ),
          ),
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(16),
              child: MaterialButton(
                minWidth: double.infinity,
                color: Colors.pinkAccent,
                height: 48,
                onPressed: () {
                  viewModel.goSettings();
                },
                child: const Text('Go Settings Page'),
              ),
            ),
          ),
        ])
      ]),
    );
  }
}
