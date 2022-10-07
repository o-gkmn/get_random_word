import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_random_word/screens/add_word.dart';
import 'package:get_random_word/screens/list_word.dart';
import 'package:get_random_word/screens/show_word.dart';
import 'package:get_random_word/screens/update_word.dart';
import 'package:word_repository/word_repository.dart';

class App extends StatelessWidget {
  const App({super.key, required this.wordRepository, required this.theme});

  final WordRepository wordRepository;

  final ThemeData theme;

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider.value(
      value: wordRepository,
      child: AppView(theme: theme),
    );
  }
}

class AppView extends StatelessWidget {
  const AppView({super.key, required this.theme});

  final ThemeData theme;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: theme,
      routes: {
        "/": ((context) => const ShowWord()),
        "/AddWord": ((context) => const AddWord()),
        "/ListWord": ((context) => const ListWord()),
        "/UpdateWord": (context) => const UpdateScreen(),
      },
      initialRoute: "/",
    );
  }
}
