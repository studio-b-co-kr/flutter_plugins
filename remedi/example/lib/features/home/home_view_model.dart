import 'package:example/features/contents/contents_page.dart';
import 'package:example/features/settings/settings_page.dart';
import 'package:flutter/widgets.dart';
import 'package:remedi/remedi.dart';

class HomeViewModel extends ViewModel {
  final StateData<CountState, int> stateData =
      StateData(state: CountState.waiting, data: 0);

  increase() {
    if (stateData.data != null) {
      stateData.data = stateData.data! + 1;
      updateUi();
    }
  }

  int get count => stateData.data!;

  void goSettings() {
    RemediRouter.pushNamed(SettingsPage.routeName);
  }

  void goContents() {
    RemediRouter.pushNamed(ContentsPage.routeName);
  }

  @override
  initialise(BuildContext context) {}
}

enum CountState {
  waiting,
  increased,
}
