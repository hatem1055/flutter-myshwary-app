import 'package:flutter/material.dart';

class ColorPallet {
  final Color appBgColor;
  final Color textColor;
  final Color bgColor;
  ColorPallet({
    @required this.appBgColor,
    @required this.textColor,
    @required this.bgColor,
  });
}

class ColorsProvider with ChangeNotifier {
  final List<ColorPallet> _colors = [
    ColorPallet(
        appBgColor: Color.fromRGBO(249, 249, 249, 1),
        textColor: Color.fromRGBO(56, 56, 60, 1),
        bgColor: Color.fromRGBO(69, 69, 72, 1)),
  ];
  var index = 0;

  ColorPallet get colorPallet {
    return _colors[index];
  }
}
