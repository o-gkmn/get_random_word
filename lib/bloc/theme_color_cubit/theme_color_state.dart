part of 'theme_color_cubit.dart';

class ThemeColorState extends Equatable {
  const ThemeColorState({this.appTheme = const GreenTheme(), this.colorTheme = ColorTheme.green ,this.exception});

  final AppTheme appTheme;
  final ColorTheme colorTheme;
  final Exception? exception;

  ThemeColorState copyWith({AppTheme? appTheme, ColorTheme? colorTheme ,Exception? exception}){
    return ThemeColorState(
      appTheme: appTheme ?? this.appTheme,
      colorTheme: colorTheme ?? this.colorTheme,
      exception: exception ?? this.exception
    );
  }

  @override
  List<Object> get props => [appTheme, colorTheme];
}

