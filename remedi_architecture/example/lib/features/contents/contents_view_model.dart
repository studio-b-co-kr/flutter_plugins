import 'package:remedi_architecture/mvvm/mvvm.dart';

class ContentsViewModel extends IViewModel {
  static ContentsViewModel? _instance;

  ContentsViewModel._();

  static ContentsViewModel get instance {
    if (_instance?.isDisposed ?? true) {
      _instance = null;
      _instance = ContentsViewModel._();
    }
    return _instance!;
  }

  @override
  initialise() {}
}
