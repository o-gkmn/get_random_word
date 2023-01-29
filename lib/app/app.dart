import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_random_word/theme/green_theme.dart';
import 'package:word_repository/word_repository.dart';

import '../router/page_router.dart';

class App extends StatelessWidget {
  const App({super.key, required this.wordRepository});

  final WordRepository wordRepository;

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider.value(
      value: wordRepository,
      child: const AppView(),
    );
  }
}

class AppView extends StatelessWidget {
  const AppView({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: GreenThemeData(isDark: false).greenThemeData,
      onGenerateRoute: PageRouter.generateRoute,
    );
  }
}
