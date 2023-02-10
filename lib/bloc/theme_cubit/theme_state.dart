part of 'theme_cubit.dart';

class ThemeState extends Equatable {
  const ThemeState({this.themeMode = ThemeMode.dark, this.exception});

  final ThemeMode themeMode;
  final Exception? exception;

  ThemeState copyWith({ThemeMode? themeMode, Exception? exception}){
    return ThemeState(
      themeMode: themeMode ?? this.themeMode,
      exception: exception ?? this.exception,
    );
  }
  @override
  List<Object> get props => [themeMode];
}