import 'dart:async';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:theme_repository/src/theme_persistence.dart';

enum ColorTheme {green, red}

class ThemeColorRepository extends ThemePersistence<ColorTheme>{

  final SharedPreferences _sharedPreferences;
  static const _kColorTheme = "__color_theme_key";
  final _controller = StreamController<ColorTheme>();

  ThemeColorRepository({required SharedPreferences sharedPreferences}) : _sharedPreferences = sharedPreferences{
    _init();
  }

  String? _getValue(String key){
    try{
      return _sharedPreferences.getString(key);
    } catch(e) {
      return null;
    }
  }

  Future<void> _setValue(String key, String value){
    return _sharedPreferences.setString(key, value);
  }

  void _init(){
    final colorTheme = _getValue(_kColorTheme);
    if(colorTheme != null){
      if(colorTheme == ColorTheme.green.name){
        _controller.add(ColorTheme.green);
      }
      else if(colorTheme == ColorTheme.red.name){
        _controller.add(ColorTheme.red);
      }
      else{
        _controller.add(ColorTheme.green);
      }
    }
  }

  @override
  void dispose() {
    _controller.close();
  }

  @override
  Stream<ColorTheme> getTheme() async* {
    yield* _controller.stream;
  }

  @override
  Future<void> saveTheme(ColorTheme theme) {
    _controller.add(theme);
    return _setValue(_kColorTheme, theme.name);
  }

}