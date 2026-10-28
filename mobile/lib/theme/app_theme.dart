import 'package:flutter/material.dart';

class AppTheme {

  static const Color background = Color(0xFF060B17);

  static const Color card = Color(0xFF12182B);

  static const Color primary = Color(0xFF4A9BFF);

  static const Color green = Color(0xFF19D27C);

  static const Color red = Color(0xFFFF4D67);

  static ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    scaffoldBackgroundColor: background,

    appBarTheme: const AppBarTheme(
      backgroundColor: background,
      elevation: 0,
    ),

    cardColor: card,

    colorScheme: ColorScheme.dark(
      primary: primary,
      secondary: green,
    ),
  );
}