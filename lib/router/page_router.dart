import 'package:flutter/material.dart';
import 'package:get_random_word/screens/add_word.dart';
import 'package:get_random_word/screens/list_word.dart';
import 'package:get_random_word/screens/show_word.dart';
import 'package:get_random_word/screens/update_word.dart';
import 'package:word_repository/word_repository.dart';

class PageRouter {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case "/":
        return MaterialPageRoute(builder: (context) => const ShowWord());
      case "/list":
        return MaterialPageRoute(builder: (context) => const ListWord());
      case "/add":
        return MaterialPageRoute(builder: (context) => const AddWord());
      case "/update":
        return MaterialPageRoute(builder: (context) => UpdateScreen(word: settings.arguments as Word));
      default:
        return MaterialPageRoute(
            builder: (context) => const Scaffold(
                body: Center(child: Text("Böyle bir sayfa bulunamadı"))));
    }
  }
}
