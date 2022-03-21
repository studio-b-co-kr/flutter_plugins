import 'package:flutter/material.dart';
import 'package:remedi_architecture/remedi_architecture.dart';

class ColorAppModel extends IAppModel {
  ColorAppModel({bool? withInit}) : super(withInit: withInit);
  Color color = Colors.purple;

  void toggleColor() {
    if (color == Colors.purple) {
      color = Colors.orange;
    } else {
      color = Colors.purple;
    }
    notifyListeners();
  }

  @override
  initialise() {}
}
