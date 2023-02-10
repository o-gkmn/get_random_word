import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_random_word/bloc/theme_cubit/theme_cubit.dart';
import 'package:get_random_word/theme/green_theme.dart';
import 'package:theme_repository/theme_repository.dart';
import 'package:word_repository/word_repository.dart';

import '../router/page_router.dart';

class App extends StatelessWidget {
  const App(
      {super.key,
      required WordRepository wordRepository,
      required ThemeRepository themeRepository})
      : _wordRepository = wordRepository,
        _themeRepository = themeRepository;

  final WordRepository _wordRepository;
  final ThemeRepository _themeRepository;

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(providers: [
      RepositoryProvider.value(value: _wordRepository),
      RepositoryProvider.value(value: _themeRepository),
    ], child: const AppView());
  }
}

class AppView extends StatelessWidget {
  const AppView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => ThemeCubit(
              themeRepository:
                  RepositoryProvider.of<ThemeRepository>(context),
            )..getCurrentTheme(),
        child: const AppBody());
  }
}

class AppBody extends StatelessWidget {
  const AppBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeCubit, ThemeState>(
      builder: (context, state) {
        return MaterialApp(
          theme: GreenThemeData().greenLightThemeData,
          darkTheme: GreenThemeData().greenDarkThemeData,
          themeMode: state.themeMode,
          onGenerateRoute: PageRouter.generateRoute,
        );
      },
    );
  }
}
