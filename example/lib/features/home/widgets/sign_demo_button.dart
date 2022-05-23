import 'package:flutter/material.dart';

class SignDemoButton extends StatelessWidget {
  final void Function() onPressed;

  const SignDemoButton({Key? key, required this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: onPressed,
      height: 48,
      color: Colors.yellow.shade700,
      minWidth: double.infinity,
      child: const Text('Go to sign demo'),
    );
  }
}
