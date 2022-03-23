import 'package:example/features/settings/settings_view_model.dart';
import 'package:flutter/material.dart';
import 'package:remedi_architecture/remedi_architecture.dart';

class SettingsPage extends ViewModelView<SettingsViewModel> {
  static const String routeName = '/settings';

  const SettingsPage(
      {Key? key, required ViewModelBuilder<SettingsViewModel> viewModelBuilder})
      : super(key: key, viewModelBuilder: viewModelBuilder);

  @override
  Widget build(
    BuildContext context,
    SettingsViewModel watch,
    SettingsViewModel read,
  ) {
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
              read.toggleThemeMode();
            },
            child: const Text('Toggle Theme'),
          ),
        ),
      ]),
    );
  }
}
