import 'package:example/features/auth/phone/auth_phone.dart';
import 'package:flutter/material.dart';
import 'package:remedi_flutter/app/app.dart';

class AuthScreen extends StatelessWidget {
  static const routeName = '/auth';

  const AuthScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<Widget> _buttons = [
      MaterialButton(
        height: 48,
        color: Colors.red,
        onPressed: () {
          // todo
        },
        child: const Text('Apple Login'),
      ),
      MaterialButton(
        height: 48,
        color: Colors.orange,
        onPressed: () {},
        child: const Text('Google Login'),
      ),
      MaterialButton(
        height: 48,
        color: Colors.yellow,
        onPressed: () {},
        child: const Text('Email Login'),
      ),
      MaterialButton(
        height: 48,
        color: Colors.green,
        onPressed: () {},
        child: const Text('Email/Password Login Login'),
      ),
      MaterialButton(
        height: 48,
        color: Colors.blue,
        onPressed: () {},
        child: const Text('Twitter Login'),
      ),
      MaterialButton(
        height: 48,
        color: Colors.indigo,
        onPressed: () {},
        child: const Text('Facebook Login'),
      ),
      MaterialButton(
        height: 48,
        color: Colors.purple,
        onPressed: () {
          RemediRouter.pushNamed(AuthPhoneScreen.routeName);
        },
        child: const Text('PhoneNumber Login'),
      ),
      MaterialButton(
        height: 48,
        color: Colors.amber,
        onPressed: () {},
        child: const Text('Kakao Login'),
      ),
    ];
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'AUTH',
        ),
      ),
      body: ListView.separated(
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
        itemBuilder: (BuildContext context, int index) {
          return _buttons[index];
        },
        separatorBuilder: (BuildContext context, int index) {
          return const SizedBox(height: 16);
        },
        itemCount: _buttons.length,
      ),
    );
  }
}
