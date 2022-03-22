import 'package:remedi_architecture/mvvm/mvvm.dart';

class ContentsViewModel extends ViewModel {
  static ContentsViewModel _instance = ContentsViewModel._();

  ContentsViewModel._();

  factory ContentsViewModel.singleton() {
    if (_instance.isDisposed) {
      _instance = ContentsViewModel._();
    }

    return _instance;
  }

  @override
  initialise() {}
}
