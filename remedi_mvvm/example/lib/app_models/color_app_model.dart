import 'dart:async';

import 'package:flutter/material.dart';
import 'package:remedi_mvvm/remedi_mvvm.dart';

class ColorAppModel extends IAppModel {
  ColorAppModel({bool? withInit}) : super(withInit: withInit);
  Color color = Colors.purple;
  StreamSubscription? subscription;

  Stream countStream = Stream.periodic(const Duration(seconds: 5));

  @override
  initialise() {
    // subscription = countStream.listen(listenColorChanged);
  }

  void listenColorChanged(event) {
    if (color == Colors.purple) {
      color = Colors.orange;
    } else {
      color = Colors.purple;
    }
    notifyListeners();
  }
}
