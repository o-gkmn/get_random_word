part of 'theme_mode_cubit.dart';

class ThemeModeState extends Equatable {
  const ThemeModeState({this.themeMode = ThemeMode.dark, this.exception});

  final ThemeMode themeMode;
  final Exception? exception;

  ThemeModeState copyWith({ThemeMode? themeMode, Exception? exception}){
    return ThemeModeState(
      themeMode: themeMode ?? this.themeMode,
      exception: exception ?? this.exception,
    );
  }
  @override
  List<Object> get props => [themeMode];
}