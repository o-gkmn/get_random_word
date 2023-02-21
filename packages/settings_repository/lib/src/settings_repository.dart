import 'package:shared_preferences/shared_preferences.dart';

class SettingsRepository {
  final SharedPreferences _sharedPreferences;
  final String smallPackSettingKey = "__small_pack_settings__";
  final String mediumPackSettingKey = "__medium_pack_settings__";
  final String largePackSettingKey = "__large_pack_settings__";

  const SettingsRepository({required SharedPreferences sharedPreferences}) : _sharedPreferences = sharedPreferences;

  bool getSmallPackSetting (){
    bool? smallPackSettingsValue = _sharedPreferences.getBool(smallPackSettingKey);

    if(smallPackSettingsValue != null){
      return smallPackSettingsValue;
    }
    return false;
  }

  bool getMediumPackSetting (){
    bool? mediumPackSettingValue = _sharedPreferences.getBool(mediumPackSettingKey);

    if(mediumPackSettingValue != null){
      return mediumPackSettingValue;
    }
    return false;
  }

  bool getLargePackSetting (){
    bool? largePackSettingValue = _sharedPreferences.getBool(largePackSettingKey);

    if(largePackSettingValue != null){
      return largePackSettingValue;
    }
    return false;
  }

  Future<bool> setSmallPackSetting (bool value) async {
    return await _sharedPreferences.setBool(smallPackSettingKey, value);
  }


  Future<bool> setMediumPackSetting (bool value) async {
    return await _sharedPreferences.setBool(mediumPackSettingKey, value);
  }

  Future<bool> setLargePackSetting (bool value) async {
    return await _sharedPreferences.setBool(largePackSettingKey, value);
  }
}