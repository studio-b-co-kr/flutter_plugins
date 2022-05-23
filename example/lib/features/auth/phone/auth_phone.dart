import 'package:flutter/material.dart';
import 'package:flutterfire_ui/auth.dart';

class AuthPhoneScreen extends StatelessWidget {
  static const routeName = '/auth_phone';

  const AuthPhoneScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PhoneInputScreen();
  }
}
