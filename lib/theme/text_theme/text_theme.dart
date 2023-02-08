import 'package:flutter/material.dart';

class PrimaryTextTheme {
  final bool isLight;

  PrimaryTextTheme({required this.isLight});

  TextTheme get primaryTextTheme {
    TextTheme textTheme = TextTheme(
      bodyLarge: TextStyle(
        color: isLight ? Colors.black : Colors.white,
        fontFamily: "OpenSans",
        // fontWeight: FontWeight.w500,
        fontSize: 18,
      ),
      bodyMedium: TextStyle(
        color: isLight ? Colors.black : Colors.white,
        fontFamily: "OpenSans",
        // fontWeight: FontWeight.w500,
        fontSize: 16,
      ),
      bodySmall: TextStyle(
        color: isLight ? Colors.black : Colors.white,
        fontFamily: "OpenSans",
        // fontWeight: FontWeight.w500,
        fontSize: 14,
      ),
      displayLarge: TextStyle(
        color: isLight ? Colors.black : Colors.white,
        fontFamily: "OpenSans",
        // fontWeight: FontWeight.w500,
        fontSize: 20,
        letterSpacing: 0.0,
      ),
      displayMedium: TextStyle(
        color: isLight ? Colors.black : Colors.white,
        fontFamily: "OpenSans",
        // fontWeight: FontWeight.w500,
        letterSpacing: 0.0,
        fontSize: 18,
      ),
      displaySmall: TextStyle(
        color: isLight ? Colors.black : Colors.white,
        fontFamily: "OpenSans",
        // fontWeight: FontWeight.w500,
        fontSize: 16,
        letterSpacing: 0.0,
      ),
      headlineLarge: TextStyle(
        color: isLight ? Colors.black : Colors.white,
        fontFamily: "OpenSans",
        // fontWeight: FontWeight.w500,
        fontSize: 26,
        letterSpacing: 0.0,
      ),
      headlineMedium: TextStyle(
        color: isLight ? Colors.black : Colors.white,
        fontFamily: "OpenSans",
        // fontWeight: FontWeight.w500,
        fontSize: 24,
        letterSpacing: 0.0,
      ),
      headlineSmall: TextStyle(
        color: isLight ? Colors.black : Colors.white,
        fontFamily: "OpenSans",
        // fontWeight: FontWeight.w500,
        fontSize: 22,
        letterSpacing: 0.0,
      ),
      labelLarge: TextStyle(
        color: isLight ? Colors.black : Colors.white,
        fontFamily: "OpenSans",
        fontWeight: FontWeight.normal,
        fontSize: 16,
      ),
      labelMedium: TextStyle(
        color: isLight ? Colors.black : Colors.white,
        fontFamily: "OpenSans",
        // fontWeight: FontWeight.w500,
        fontSize: 14,
        letterSpacing: 0.0,
      ),
      labelSmall: TextStyle(
        color: isLight ? Colors.black : Colors.white,
        fontFamily: "OpenSans",
        // fontWeight: FontWeight.w500,
        fontSize: 12,
        letterSpacing: 0.0,
      ),
      titleLarge: TextStyle(
        color: isLight ? Colors.black : Colors.white,
        fontFamily: "OpenSans",
        // fontWeight: FontWeight.w500,
        fontSize: 20,
        letterSpacing: 0,
      ),
      titleMedium: TextStyle(
        color: isLight ? Colors.black : Colors.white,
        fontFamily: "OpenSans",
        // fontWeight: FontWeight.w500,
        fontSize: 18,
        letterSpacing: 0,
      ),
      titleSmall: TextStyle(
        color: isLight ? Colors.black : Colors.white,
        fontFamily: "OpenSans",
        // fontWeight: FontWeight.w500,
        fontSize: 16,
        letterSpacing: 0,
      ),
    );

    return textTheme;
  }
}
