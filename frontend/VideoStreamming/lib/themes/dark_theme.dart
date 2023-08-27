import 'package:videostreaming/custom_colors.dart/custom_color.dart';
import 'package:flutter/material.dart';

ThemeData darkTheme() {
  final ThemeData base = ThemeData.dark();
  return base.copyWith(
      scaffoldBackgroundColor: CustomColors.lightBlack,
      backgroundColor: CustomColors.darkBlack,
      navigationBarTheme:
          NavigationBarThemeData(backgroundColor: CustomColors.darkBlack),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
          backgroundColor: CustomColors.darkBlack,
          selectedItemColor: CustomColors.lightpink));
}
