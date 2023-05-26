import 'package:flutter/material.dart';

@immutable
class LightThemeMaterial3 {
  const LightThemeMaterial3({
    this.primaryColor = const Color(0xff5669ff),
    this.subColor = const Color(0xff747688),
  });

  final Color primaryColor, subColor;

  ThemeData toThemeData() {
    return ThemeData(useMaterial3: true);
  }
}
