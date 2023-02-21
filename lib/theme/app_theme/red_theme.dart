import 'package:flutter/material.dart';
import 'package:get_random_word/theme/app_theme/app_theme.dart';
import 'package:get_random_word/theme/text_theme/text_theme.dart';

class RedTheme extends AppTheme {
  const RedTheme();

  @override
  ThemeData get lightTheme {
    TextTheme textTheme = const PrimaryTextTheme(isLight: true).primaryTextTheme;

    ColorScheme colorScheme = const ColorScheme(
      brightness: Brightness.light,
      onPrimary: Color.fromARGB(248, 170, 27, 27),
      primary: Color.fromARGB(255, 255, 50, 50),
      secondary: Color.fromARGB(255, 237, 68, 68),
      onSecondary: Color.fromARGB(248, 237, 84, 84),
      error: Color.fromARGB(255, 255, 17, 0),
      onError: Color.fromARGB(129, 255, 17, 0),
      background: Color.fromARGB(255, 241, 215, 215),
      onBackground: Color.fromARGB(255, 0, 0, 0),
      surface: Color.fromARGB(255, 251, 73, 73),
      onSurface: Color.fromARGB(255, 255, 255, 255),
      shadow: Color.fromARGB(255, 63, 63, 63),
      outline: Color.fromARGB(255, 225, 225, 225),
    );

    ThemeData theme = ThemeData.from(
        colorScheme: colorScheme, textTheme: textTheme, useMaterial3: true);
    return theme;
  }

  @override
  ThemeData get darkTheme {
    TextTheme textTheme = const PrimaryTextTheme(isLight: false).primaryTextTheme;

    ColorScheme colorScheme = const ColorScheme(
      brightness: Brightness.dark,
      primary: Color.fromARGB(248, 203, 2, 2),
      onPrimary: Color.fromARGB(249, 131, 33, 33),
      secondary: Color.fromARGB(248, 157, 11, 11),
      onSecondary: Color.fromARGB(248, 173, 14, 14),
      error: Color.fromARGB(255, 255, 17, 0),
      onError: Color.fromARGB(129, 255, 17, 0),
      background: Color.fromARGB(255, 45, 51, 63),
      onBackground: Color.fromARGB(255, 255, 255, 255),
      surface: Color.fromARGB(255, 251, 73, 73),
      onSurface: Color.fromARGB(255, 255, 255, 255),
      shadow: Color.fromARGB(255, 63, 63, 63),
      outline: Color.fromARGB(255, 77, 77, 77),
    );

    ThemeData theme = ThemeData.from(
        colorScheme: colorScheme, textTheme: textTheme, useMaterial3: true);
    return theme;
  }

  @override
  String get name => "Kırmızı";
}
