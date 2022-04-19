import 'package:remedi_flutter/remedi_flutter.dart';

abstract class IIntroViewModel extends ViewModel {
  void goNext() {
    RemediRouter.pushReplacementNamed(
      RemediSplash.routeName,
      arguments: RemediSplash.afterIntro,
    );
  }
}
