import 'package:flutter/material.dart';

abstract class AppTheme{
  const AppTheme();

  ThemeData get lightTheme;
  ThemeData get darkTheme;
}