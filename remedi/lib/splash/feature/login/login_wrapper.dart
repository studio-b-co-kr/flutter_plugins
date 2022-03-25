import 'package:flutter/cupertino.dart';

class LoginWrapper extends StatelessWidget {
  static const routeName = '/login';
  final Widget loginPage;

  const LoginWrapper({Key? key, required this.loginPage}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return loginPage;
  }
}
