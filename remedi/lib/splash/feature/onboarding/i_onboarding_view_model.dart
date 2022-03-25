import 'package:remedi/remedi.dart';

abstract class IOnboardingViewModel extends ViewModel {
  void goNext() {
    RemediRouter.pushReplacementNamed(
      RemediSplash.routeName,
      arguments: RemediSplash.afterOnboarding,
    );
  }
}
