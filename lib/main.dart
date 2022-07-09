import 'package:flutter/material.dart';
import 'package:get_random_word/widget/add_word.dart';
import 'package:get_random_word/widget/list_word.dart';
import 'package:get_random_word/widget/show_word.dart';
import 'package:get_random_word/widget/update_word.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        "/": ((context) => ShowWord()),
        "/AddWord": ((context) => AddWord()),
        "/ListWord": ((context) => ListWord()),
        "/UpdateWord": (context) => UpdateScreen.empty(),
      },
      initialRoute: "/",
    );
  }
}
