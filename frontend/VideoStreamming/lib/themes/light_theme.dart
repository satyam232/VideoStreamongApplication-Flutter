import 'package:videostreaming/custom_colors.dart/custom_color.dart';
import 'package:flutter/material.dart';

ThemeData lightTheme() {
  final ThemeData base = ThemeData.light();
  return base.copyWith(
      scaffoldBackgroundColor: Colors.white,
      backgroundColor: CustomColors.lightpink,
      navigationBarTheme:
          NavigationBarThemeData(backgroundColor: CustomColors.lightpink),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
          backgroundColor: CustomColors.lightpink,
          selectedItemColor: Colors.white));
}
