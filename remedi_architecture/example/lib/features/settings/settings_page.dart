import 'package:example/features/settings/settings_view_model.dart';
import 'package:flutter/material.dart';
import 'package:remedi_architecture/remedi_architecture.dart';

class SettingsPage extends IViewModelView<SettingsViewModel> {
  static const String routeName = '/settings';

  const SettingsPage({Key? key, required SettingsViewModel viewModel})
      : super(key: key, viewModel: viewModel);

  @override
  Widget build(BuildContext context, SettingsViewModel viewModel) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: Column(children: [
        const Expanded(
          child: Center(
            child: Text('You can change app theme'),
          ),
        ),
        Container(
          padding: const EdgeInsets.all(16),
          child: MaterialButton(
            minWidth: double.infinity,
            height: 48,
            color: Colors.grey,
            onPressed: () {
              viewModel.toggleThemeMode();
            },
            child: const Text('Toggle Theme'),
          ),
        ),
      ]),
    );
  }
}
