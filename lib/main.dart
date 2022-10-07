import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:json_theme/json_theme.dart';
import 'package:flutter/services.dart';
import 'package:get_random_word/bootstrap.dart';
import 'package:sqflite_word_api/sqflite_word_api.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final themeStr = await rootBundle.loadString('assets/theme.json');
  final themeJson = jsonDecode(themeStr);
  final theme = ThemeDecoder.decodeThemeData(themeJson)!;

  final wordApi = SqfliteWordApi();
  bootstrap(wordApi, theme);
}
