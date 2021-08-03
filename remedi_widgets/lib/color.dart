import 'dart:ui';

extension ExtenstionColor on Color {
  Color get complementary {
    int red = 255 - this.red;
    int green = 255 - this.green;
    int blue = 255 - this.blue;

    return Color.fromARGB(255, red, green, blue);
  }
}
