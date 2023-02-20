import 'package:shared_preferences/shared_preferences.dart';

class SettingsRepository {
  final SharedPreferences _sharedPreferences;
  final String smallPackSettingKey = "__small_pack_settings__";

  const SettingsRepository({required SharedPreferences sharedPreferences}) : _sharedPreferences = sharedPreferences;

  bool getSmallPackSetting (){
    bool? smallPackSettingsValue = _sharedPreferences.getBool(smallPackSettingKey);

    if(smallPackSettingsValue != null){
      return smallPackSettingsValue;
    }
    return false;
  }

  Future<bool> setSmallPackSettings (bool value) async {
    return await _sharedPreferences.setBool(smallPackSettingKey, value);
  }
}