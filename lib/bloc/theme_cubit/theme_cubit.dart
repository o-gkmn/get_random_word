import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:theme_repository/theme_repository.dart';

part 'theme_state.dart';

class ThemeModeCubit extends Cubit<ThemeState> {
  ThemeModeCubit({required ThemeModeRepository themeRepository})
      : _themeRepository = themeRepository,
        super(const ThemeState());

  final ThemeModeRepository _themeRepository;
  late StreamSubscription<CustomTheme> _themeSubscription;
  static late bool _isDarkTheme;

  void getCurrentTheme() {
    _themeSubscription = _themeRepository.getTheme().listen(
      (customTheme) {
        if (customTheme.name == CustomTheme.light.name) {
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
      _themeRepository.saveTheme(CustomTheme.light);
    }else{
      _themeRepository.saveTheme(CustomTheme.dark);
    }
  }

  @override
  Future<void> close(){
    _themeSubscription.cancel();
    _themeRepository.dispose();
    return super.close();
  }
}
