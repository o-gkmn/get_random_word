library theme_repository;

import 'dart:async';

import 'package:shared_preferences/shared_preferences.dart';

enum CustomTheme { light, dark }

abstract class ThemePersistence {
  Stream<CustomTheme> getTheme();
  Future<void> saveTheme(CustomTheme theme);
  void dispose();
}

class ThemeRepository extends ThemePersistence {
  final SharedPreferences _sharedPreferences;

  static const _kThemePersistenceKey = '__theme_persistence_key';

  final _controller = StreamController<CustomTheme>();

  ThemeRepository({required SharedPreferences sharedPreferences})
      : _sharedPreferences = sharedPreferences {
    _init();
  }

  String? _getValue(String key) {
    try {
      return _sharedPreferences.getString(key);
    } catch (e) {
      return null;
    }
  }

  Future<void> _setValue(String key, String value) =>
      _sharedPreferences.setString(key, value);

  _init() {
    final themeString = _getValue(_kThemePersistenceKey);
    if (themeString != null) {
      if (themeString == CustomTheme.light.name) {
        _controller.add(CustomTheme.light);
      } else {
        _controller.add(CustomTheme.dark);
      }
    } else {
      _controller.add(CustomTheme.light);
    }
  }

  @override
  Stream<CustomTheme> getTheme() async*{
    yield* _controller.stream;
  }

  @override
  Future<void> saveTheme(CustomTheme theme) {
    _controller.add(theme);
    return _setValue(_kThemePersistenceKey, theme.name);
  }

  @override
  void dispose() {
    _controller.close();
  }
}
