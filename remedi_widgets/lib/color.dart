import 'package:flutter/material.dart';

extension ExtenstionColor on Color {
  Color get complementary {
    int red = 255 - this.red;
    int green = 255 - this.green;
    int blue = 255 - this.blue;

    return Color.fromARGB(this.alpha, red, green, blue);
  }
}
