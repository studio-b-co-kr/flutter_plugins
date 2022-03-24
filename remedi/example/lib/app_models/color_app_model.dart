import 'package:flutter/material.dart';
import 'package:remedi/remedi.dart';

class ColorAppModel extends AppModel {
  ColorAppModel({bool? withInit}) : super(withInit: withInit);

  /// Provider 를 통해서 제공되는 색깔 데이터
  Color color = Colors.purple;

  /// Home Page 의 백그라운드 컬러 를 변경 한다.
  void toggleColor() {
    if (color == Colors.purple) {
      color = Colors.orange;
    } else {
      color = Colors.purple;
    }

    /// 실시간으로 변경을 알려야 할 경우 notifyListeners() 를 호출 한다.
    notifyListeners();
  }

  @override
  initialise() {}
}