import 'package:flutter/material.dart';

class AppConstant {
  static Color redColor = Color.fromARGB(255, 131, 4, 4);

  

  TextStyle defaultStyle(
          {Color? color, double? size, FontWeight? fontWeight}) =>
      TextStyle(color: color, fontSize: size, fontWeight: fontWeight);
}
