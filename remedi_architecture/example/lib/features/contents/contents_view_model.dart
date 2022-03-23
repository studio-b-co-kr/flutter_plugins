import 'package:example/features/contents/examples/example_stateful_state_data_page.dart';
import 'package:example/features/contents/examples/example_stateless_data_page.dart';
import 'package:example/features/contents/examples/example_stateless_state_data_page.dart';
import 'package:remedi_architecture/remedi_architecture.dart';

import 'examples/example_stateful_data_page.dart';

class ContentsViewModel extends ViewModel {
  static ContentsViewModel _instance = ContentsViewModel._();

  ContentsViewModel._();

  factory ContentsViewModel.singleton() {
    if (_instance.isDisposed) {
      _instance = ContentsViewModel._();
    }

    return _instance;
  }

  goStatelessDataView() {
    RemediRouter.pushNamed(ExampleStatelessDataPage.routeName);
  }

  goStatelessStateDataView() {
    RemediRouter.pushNamed(ExampleStatelessStateDataPage.routeName);
  }

  goStatefulDataView() {
    RemediRouter.pushNamed(ExampleStatefulDataPage.routeName);
  }

  goStatefulStateDataView() {
    RemediRouter.pushNamed(ExampleStatefulStateDataPage.routeName);
  }

  @override
  initialise() {}
}
