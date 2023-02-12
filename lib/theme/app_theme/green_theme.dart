import 'package:flutter/material.dart';
import 'package:get_random_word/theme/app_theme/app_theme.dart';
import 'package:get_random_word/theme/text_theme/text_theme.dart';

class GreenTheme extends AppTheme{
  GreenTheme();

  @override
  ThemeData get lightTheme {
    TextTheme primaryTextTheme =
        PrimaryTextTheme(isLight: true).primaryTextTheme;

    ColorScheme colorScheme = const ColorScheme(
      brightness: Brightness.light,
      primary: Color.fromARGB(255, 92, 255, 67),
      onPrimary: Color.fromARGB(197, 69, 197, 49),
      secondary: Color.fromARGB(255, 136, 255, 117),
      onSecondary: Color.fromARGB(144, 135, 255, 117),
      error: Color.fromARGB(255, 255, 17, 0),
      onError: Color.fromARGB(129, 255, 17, 0),
      background: Color.fromARGB(255, 255, 255, 255),
      onBackground: Color.fromARGB(164, 255, 255, 255),
      surface: Color.fromARGB(255, 0, 251, 92),
      onSurface: Color.fromARGB(255, 255, 255, 255),
      shadow: Color.fromARGB(255, 158, 158, 158),
    );

    ThemeData greenTheme = ThemeData.from(
        colorScheme: colorScheme,
        textTheme: primaryTextTheme,
        useMaterial3: true);

    return greenTheme;
  }

  @override
  ThemeData get darkTheme {
    TextTheme primaryTextTheme =
        PrimaryTextTheme(isLight: false).primaryTextTheme;

    ColorScheme colorScheme = const ColorScheme(
        brightness: Brightness.light,
        primary: Color.fromARGB(255, 88, 168, 76),
        onPrimary: Color.fromARGB(197, 69, 197, 49),
        secondary: Color.fromARGB(255, 35, 99, 25),
        onSecondary: Color.fromARGB(144, 135, 255, 117),
        error: Color.fromARGB(255, 255, 17, 0),
        onError: Color.fromARGB(129, 255, 17, 0),
        background: Color.fromARGB(255, 45, 51, 63),
        onBackground: Color.fromARGB(163, 56, 56, 56),
        surface: Color.fromARGB(255, 41, 134, 75),
        onSurface: Color.fromARGB(255, 255, 255, 255),
        shadow: Color.fromARGB(255, 63, 63, 63));

    ThemeData greenTheme = ThemeData.from(
        colorScheme: colorScheme,
        textTheme: primaryTextTheme,
        useMaterial3: true);

    return greenTheme;
  }
}
