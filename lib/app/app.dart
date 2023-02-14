import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_random_word/bloc/bloc.dart';
import 'package:get_random_word/router/router.dart';
import 'package:get_random_word/theme/theme.dart';
import 'package:theme_repository/theme_repository.dart';
import 'package:word_repository/word_repository.dart';


class App extends StatelessWidget {
  const App(
      {super.key,
      required WordRepository wordRepository,
      required ThemeModeRepository themeRepository})
      : _wordRepository = wordRepository,
        _themeRepository = themeRepository;

  final WordRepository _wordRepository;
  final ThemeModeRepository _themeRepository;

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
        create: (context) => ThemeModeCubit(
              themeRepository:
                  RepositoryProvider.of<ThemeModeRepository>(context),
            )..getCurrentTheme(),
        child: const AppBody());
  }
}

class AppBody extends StatelessWidget {
  const AppBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeModeCubit, ThemeState>(
      builder: (context, state) {
        return MaterialApp(
          theme: RedTheme().lightTheme,
          darkTheme: RedTheme().darkTheme,
          themeMode: state.themeMode,
          onGenerateRoute: PageRouter.generateRoute,
        );
      },
    );
  }
}
