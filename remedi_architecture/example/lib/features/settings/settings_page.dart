import 'package:example/app_models/settings_app_model.dart';
import 'package:flutter/material.dart';
import 'package:remedi_architecture/remedi_architecture.dart';

class SettingsPage extends StatelessWidget {
  static const String routeName = '/settings';

  const SettingsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
              context.read<SettingsAppModel>().toggleThemeMode();
            },
            child: const Text('Toggle Theme'),
          ),
        ),
      ]),
    );
  }
}
