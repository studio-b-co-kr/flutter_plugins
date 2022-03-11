import 'package:example/features/home/home_view_model.dart';
import 'package:flutter/material.dart';
import 'package:remedi_mvvm/remedi_mvvm.dart';

class HomePage extends ViewModelView<HomeViewModel> {
  static const routeName = '/home';

  HomePage({Key? key, required HomeViewModel vm}) : super(key: key, vm: vm);

  @override
  Widget buildWidget(BuildContext context, HomeViewModel vm) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('MVVM Example'),
      ),
      body: Column(children: [
        Expanded(
          child: Center(
            child: Text(
              '${vm.authAppModel.isLogin}\n${vm.deeplinkAppModel.count}',
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 32),
            ),
          ),
        ),
        Container(
          padding: const EdgeInsets.all(16),
          child: MaterialButton(
            minWidth: double.infinity,
            height: 48,
            onPressed: () async {
              vm.authAppModel.isLogin
                  ? vm.authAppModel.logout()
                  : vm.authAppModel.login();
            },
            color: Colors.red,
            child: vm.authAppModel.isLogin
                ? const Text('LOGOUT')
                : const Text('LOGIN'),
          ),
        ),
      ]),
    );
  }
}
