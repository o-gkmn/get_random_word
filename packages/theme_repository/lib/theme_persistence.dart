
abstract class ThemePersistence<T> {
  Stream<T> getTheme();
  Future<void> saveTheme(T theme);
  void dispose();
}