import 'package:flutter/widgets.dart';
import 'package:remedi/remedi.dart';

class ContentsViewModel extends ViewModel {
  int count = 0;

  void increase() {
    count++;
    notifyListeners();
  }

  @override
  initialise(BuildContext context) {}
}
