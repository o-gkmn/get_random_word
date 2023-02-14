import 'package:flutter/material.dart';

abstract class AppTheme{
  const AppTheme();

  String get name;
  ThemeData get lightTheme;
  ThemeData get darkTheme;
}