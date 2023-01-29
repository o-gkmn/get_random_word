import 'package:flutter/material.dart';

class GreenThemeData {
  final bool isDark;

  GreenThemeData({required this.isDark});

  ThemeData get greenThemeData {
    ColorScheme colorScheme = ColorScheme(
      brightness: isDark ? Brightness.dark : Brightness.light,
      primary: const Color.fromARGB(255, 86, 199, 80),
      onPrimary: const Color(0xFFA0EEC0),
      secondary: const Color(0xFF72A276),
      onSecondary: const Color(0xFF8AE9C1), //For IconButton Color
      error: const Color(0xFFF95738),
      onError: const Color(0xFFF55536),
      background: const Color(0xFFFFFBDB),
      onBackground: const Color(0xFF666B6A), //For text
      surface: const Color.fromARGB(255, 55, 182, 55), //For App Bar
      onSurface: const Color(0xFFFFFFFF), //For Button Text
    );

    ThemeData greenTheme =
        ThemeData.from(colorScheme: colorScheme, useMaterial3: true);
    return greenTheme;
  }
}
