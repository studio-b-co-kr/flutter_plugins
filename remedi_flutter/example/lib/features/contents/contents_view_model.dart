import 'package:remedi_flutter/remedi_flutter.dart';

class ContentsViewModel extends ViewModel {
  int count = 0;

  void increase() {
    count++;
    notifyListeners();
  }

  @override
  initialise() {}
}
