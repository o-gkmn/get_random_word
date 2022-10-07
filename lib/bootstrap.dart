import 'package:flutter/material.dart';
import 'package:get_random_word/app/app.dart';
import 'package:word_api/word_api.dart';
import 'package:word_repository/word_repository.dart';

void bootstrap(WordApi wordApi, ThemeData theme) {
  final wordRepository = WordRepository(wordApi: wordApi);
  runApp(App(wordRepository: wordRepository, theme: theme));
}
