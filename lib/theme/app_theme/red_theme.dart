import 'package:flutter/material.dart';
import 'package:get_random_word/theme/app_theme/app_theme.dart';
import 'package:get_random_word/theme/text_theme/text_theme.dart';

class RedTheme extends AppTheme {
  @override
  ThemeData get darkTheme {
    TextTheme textTheme = PrimaryTextTheme(isLight: false).primaryTextTheme;

    ColorScheme colorScheme = const ColorScheme(
      brightness: Brightness.dark,
      primary: Color.fromARGB(249, 131, 33, 33),
      onPrimary: Color.fromARGB(248, 208, 37, 37),
      secondary: Color.fromARGB(248, 99, 7, 7),
      onSecondary: Color.fromARGB(248, 173, 14, 14),
      error: Color.fromARGB(255, 255, 17, 0),
      onError: Color.fromARGB(129, 255, 17, 0),
      background: Color.fromARGB(255, 45, 51, 63),
      onBackground: Color.fromARGB(163, 56, 56, 56),
      surface: Color.fromARGB(255, 226, 72, 72),
      onSurface: Color.fromARGB(255, 255, 255, 255),
      shadow: Color.fromARGB(255, 63, 63, 63),
    );

    ThemeData theme = ThemeData.from(colorScheme: colorScheme, textTheme: textTheme, useMaterial3: true);
    return theme;
  }

  @override
  ThemeData get lightTheme {
        TextTheme textTheme = PrimaryTextTheme(isLight: true).primaryTextTheme;

    ColorScheme colorScheme = const ColorScheme(
      brightness: Brightness.light,
      primary: Color.fromARGB(255, 247, 50, 50),
      onPrimary: Color.fromARGB(248, 251, 35, 35),
      secondary: Color.fromARGB(255, 251, 99, 99),
      onSecondary: Color.fromARGB(248, 237, 84, 84),
      error: Color.fromARGB(255, 255, 17, 0),
      onError: Color.fromARGB(129, 255, 17, 0),
      background: Color.fromARGB(255, 255, 255, 255),
      onBackground: Color.fromARGB(164, 255, 255, 255),
      surface: Color.fromARGB(255, 255, 98, 98),
      onSurface: Color.fromARGB(255, 255, 255, 255),
      shadow: Color.fromARGB(255, 63, 63, 63),
    );

    ThemeData theme = ThemeData.from(colorScheme: colorScheme, textTheme: textTheme, useMaterial3: true);
    return theme;
  }
}
