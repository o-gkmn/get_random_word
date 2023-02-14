import 'package:flutter/material.dart';
import 'package:get_random_word/app/app.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:word_api/word_api.dart';
import 'package:word_repository/word_repository.dart';
import 'package:theme_repository/theme_repository.dart';

void bootstrap(WordApi wordApi, SharedPreferences sharedPreferences) {
  final wordRepository = WordRepository(wordApi: wordApi);
  final themeRepository = ThemeModeRepository(sharedPreferences: sharedPreferences);
  runApp(App(wordRepository: wordRepository, themeRepository: themeRepository));
}
