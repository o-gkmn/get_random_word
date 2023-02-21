import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_random_word/bloc/bloc.dart';
import 'package:get_random_word/router/router.dart';
import 'package:theme_repository/theme_repository.dart';
import 'package:word_repository/word_repository.dart';
import 'package:settings_repository/settings_repository.dart';
class App extends StatelessWidget {
  const App({
    super.key,
    required WordRepository wordRepository,
    required ThemeModeRepository themeModeRepository,
    required ThemeColorRepository themeColorRepository,
    required SettingsRepository settingsRepository,
  })  : _wordRepository = wordRepository,
        _themeModeRepository = themeModeRepository,
        _themeColorRepository = themeColorRepository,
        _settingsRepository = settingsRepository;

  final WordRepository _wordRepository;
  final ThemeModeRepository _themeModeRepository;
  final ThemeColorRepository _themeColorRepository;
  final SettingsRepository _settingsRepository;

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(providers: [
      RepositoryProvider.value(value: _wordRepository),
      RepositoryProvider.value(value: _themeModeRepository),
      RepositoryProvider.value(value: _themeColorRepository),
      RepositoryProvider.value(value: _settingsRepository),
    ], child: const AppView());
  }
}

class AppView extends StatelessWidget {
  const AppView({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(providers: [
      BlocProvider(
        create: (context) => ThemeModeCubit(
          themeModeRepository: RepositoryProvider.of<ThemeModeRepository>(context),
        )..getCurrentThemeModel(),
      ),
      BlocProvider(
        create: (context) => ThemeColorCubit(
          themeColorRepository:
              RepositoryProvider.of<ThemeColorRepository>(context),
        )..getCurrentThemeColor(),
      ),
    ], child: const AppBody());
  }
}

class AppBody extends StatelessWidget {
  const AppBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeModeCubit, ThemeModeState>(
      builder: (context, themeModeState) {
        return BlocBuilder<ThemeColorCubit, ThemeColorState>(
          builder: (context, themeColorState) {
            return MaterialApp(
              theme: themeColorState.appTheme.lightTheme,
              darkTheme: themeColorState.appTheme.darkTheme,
              themeMode: themeModeState.themeMode,
              onGenerateRoute: PageRouter.generateRoute,
            );
          },
        );
      },
    );
  }
}
