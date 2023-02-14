import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:theme_repository/theme_repository.dart';

part 'theme_mode_state.dart';

class ThemeModeCubit extends Cubit<ThemeModeState> {
  ThemeModeCubit({required ThemeModeRepository themeModeRepository})
      : _themeModeRepository = themeModeRepository,
        super(const ThemeModeState());

  final ThemeModeRepository _themeModeRepository;
  late StreamSubscription<CustomTheme> _themeSubscription;
  static late bool _isDarkTheme;

  void getCurrentThemeModel() {
    _themeSubscription = _themeModeRepository.getTheme().listen(
      (themeMode) {
        if (themeMode.name == CustomTheme.light.name) {
          _isDarkTheme = false;
          emit(state.copyWith(themeMode: ThemeMode.light));
        } else {
          _isDarkTheme = true;
          emit(state.copyWith(themeMode: ThemeMode.dark));
        }
      },
    );
  }

  void switchTheme(){
    if(_isDarkTheme){
      _themeModeRepository.saveTheme(CustomTheme.light);
    }else{
      _themeModeRepository.saveTheme(CustomTheme.dark);
    }
  }

  @override
  Future<void> close(){
    _themeSubscription.cancel();
    _themeModeRepository.dispose();
    return super.close();
  }
}
