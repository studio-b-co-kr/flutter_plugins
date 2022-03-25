import 'package:flutter/cupertino.dart';

class IntroWrapper extends StatelessWidget {
  static const routeName = '/intro';
  final Widget introPage;

  const IntroWrapper({Key? key, required this.introPage}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return introPage;
  }
}
