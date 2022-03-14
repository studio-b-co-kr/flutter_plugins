import 'dart:async';

import 'package:flutter/material.dart';
import 'package:remedi_mvvm/remedi_mvvm.dart';

class ColorAppModel extends AppModel {
  ColorAppModel({bool? withInit}) : super(withInit: withInit);
  Color color = Colors.purple;
  late StreamSubscription subscription;

  @override
  initialise() {
    subscription = Stream.periodic(const Duration(seconds: 5), (count) {
      return count;
    }).listen((event) {
      if (color == Colors.purple) {
        color = Colors.orange;
      } else {
        color = Colors.purple;
      }
      notifyListeners();
    });
  }
}
