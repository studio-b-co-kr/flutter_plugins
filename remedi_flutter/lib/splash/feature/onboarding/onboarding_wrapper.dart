import 'package:flutter/cupertino.dart';

class OnboardingWrapper extends StatelessWidget {
  static const routeName = '/onboarding';
  final Widget onboardingPage;

  const OnboardingWrapper({Key? key, required this.onboardingPage})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return onboardingPage;
  }
}
