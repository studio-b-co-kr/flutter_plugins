import 'package:remedi/remedi.dart';

abstract class IIntroViewModel extends ViewModel {
  void goNext() {
    RemediRouter.pushReplacementNamed(
      RemediSplash.routeName,
      arguments: RemediSplash.afterIntro,
    );
  }
}
