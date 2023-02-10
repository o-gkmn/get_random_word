import 'package:flutter/material.dart';
import 'package:get_random_word/bootstrap.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sqflite_word_api/sqflite_word_api.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final wordApi = SqfliteWordApi();
  final sharedPreferences = await SharedPreferences.getInstance();
  bootstrap(wordApi, sharedPreferences);
}
