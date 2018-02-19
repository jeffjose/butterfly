import 'package:flutter/material.dart';

class Colors {
  const Colors();

  static const Color appBarTitle = const Color(0xCCFFFFFF);
  static const Color appBarIconColor = const Color(0xFFFFFFFF);
  static const Color appBarDetailBackground = const Color(0x00FFFFFF);
  static const Color appBarGradientStart = const Color(0xFFEC008C);
  static const Color appBarGradientEnd = const Color(0xFFFC6767);

  static const Color mediaBackground = const Color(0xFFFFFFFF);
}

class TextStyles {
  const TextStyles();

  static const TextStyle appBarTitle = const TextStyle(
      color: Colors.appBarTitle, fontFamily: 'OpenSans', fontSize: 32.0);
}
