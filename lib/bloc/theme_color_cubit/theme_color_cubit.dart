import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:get_random_word/theme/theme.dart';
import 'package:theme_repository/theme_repository.dart';

part 'theme_color_state.dart';

class ThemeColorCubit extends Cubit<ThemeColorState> {
  ThemeColorCubit({required ThemeColorRepository themeColorRepository})
      : _themeColorRepository = themeColorRepository,
        super(const ThemeColorState());

  final ThemeColorRepository _themeColorRepository;
  late StreamSubscription<ColorTheme> _colorThemeSubscription;

  void getCurrentThemeColor() {
    _colorThemeSubscription = _themeColorRepository.getTheme().listen(
      (themeColor) {
        if (themeColor.name == ColorTheme.green.name) {
          emit(state.copyWith(appTheme: const GreenTheme(), colorTheme: themeColor));
        } else if (themeColor.name == ColorTheme.red.name) {
          emit(state.copyWith(appTheme: const RedTheme(), colorTheme: themeColor));
        } else{
          emit(state.copyWith(appTheme: const GreenTheme(), colorTheme: ColorTheme.green));
        }
      },
    );
  }

  void switchTheme(ColorTheme theme){
    _themeColorRepository.saveTheme(theme);
  }

  @override
  Future<void> close() {
    _colorThemeSubscription.cancel();
    _themeColorRepository.dispose();
    return super.close();
  }
}
